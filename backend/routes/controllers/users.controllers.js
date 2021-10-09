const jwt = require('jsonwebtoken');
require('dotenv').config();
const crypto = require('crypto');
const db_config = require(__dirname + '/../../config/database.js');
const YOUR_SECRET_KEY = process.env.SECRET_KEY;
const conn = db_config.init();
db_config.connect(conn);

// 비밀번호 암호화  함수
const createSalt = () => 
    new Promise((resolve, reject) => {
        crypto.randomBytes(64, (err, buf) => {
            if (err) reject(err);
            resolve(buf.toString('base64'));
        });
    });
const createHashedPassword = (plainPassword) =>
    new Promise(async (resolve, reject) => {
        const salt = await createSalt();
		crypto.pbkdf2(plainPassword, salt, 9999, 64, 'sha512', (err, key) => {
            if (err) reject(err);
			resolve({ password: key.toString('base64'), salt });
        });
    });
const makePasswordHashed = (salt, plainPassword) =>
    new Promise(async (resolve, reject) => {
        crypto.pbkdf2(plainPassword, salt, 9999, 64, 'sha512', (err, key) => {
            if (err) reject(err);
            resolve(key.toString('base64'));
        });
    });

//로그인 함수
exports.createToken = async function (req, res, next)  {
	try {
		const SelectUser = `SELECT * FROM user WHERE email = "${req.body.email}";`;	
		conn.query(SelectUser, async function (error, rows) {	
			if(error) {
				res.status(401).json({meesege: error});
			}	
			else{
				if (rows.length > 0) {
					let password = await makePasswordHashed(rows[0].salt, req.body.password);//비밀번호 암호화;
					if (rows[0].password == password){	
						const token = jwt.sign({
								email: rows[0].email,
								name: rows[0].name,
								manageLevel: rows[0].magage_level
							}, YOUR_SECRET_KEY, {
							expiresIn: '10d'
						});
						res.cookie('user', token);
						res.status(201).json({
						result: 'ok',
						token
						});
					}
					else {
						res.status(400).json({ messege: '비밀번호가 잘못되었습니다.'});	
					}
				} 
				else {
					res.status(400).json({ messege: '존재하지 않는 이메일입니다.' });
				}
			}	
		});
	} catch (err) {
		console.error(err);
		next(err);
	}
};

//회원가입 함수
exports.createNewUser = async function (req, res, next) {
	let troopId;	
	//이메일 중복 확인	
	const checkEmailOverlap = new Promise(function(resolve, reject)  {
		selectUser = `SELECT * FROM user WHERE email = "${req.body.email}";`;	
		conn.query(selectUser, (error, emailSameUsers) => {
			if (error) {
				res.status(401).json({
					messege: error
				});
				console.log(error);	
			}	
			else if(emailSameUsers.length > 0){
				res.status(400).json({
					messege: "이미 존재하는 이메일 주소입니다!"
				});	
				return;
			}
			else resolve();
		});	
	});

	//비밀번호 암호화
	const { password, salt } = await createHashedPassword(req.body.password);	
	//console.log("salt: ", salt, "len: ", salt.length);	
	checkEmailOverlap
	.then((messege) => {
		//관리자인 경우
		if(req.body.managerLevel){
			const createUser = `INSERT INTO user(name, password, troop_id, military_serial_number, email, manage_level, salt) VALUES(?, ?, ?, ?, ?, ?, ?);`;
			conn.query(createUser, [req.body.name, password, req.body.troopId, req.body.military_serial_number, req.body.email, req.body.managerLevel, salt], (error, rows) => {
				if (error) {
					res.status(400).json({
						messege: error
					});
					console.log(error);	
					return;
				}
				res.status(201).json({
					messege: 'new manager created!',
				});
			});	
		}
		//일반 사용자인 경우
		else{
			const createUser = `INSERT INTO user(name, password, troop_id, military_serial_number, email, salt) VALUES(?, ?, ?, ?, ?, ?);`;
			conn.query(createUser, [req.body.name, password, req.body.troopId, req.body.military_serial_number, req.body.email, salt], async function(error, rows) {
				if (error) {
					res.status(400).json({messege: error});
					console.log(error);	
					return;
				}
				//알러지가 있는 사용자일 경우
				if(req.body.allergy){
					async function insertAllergies() { 
						console.log("allergy exists!");
						for(let i = 0; i < req.body.allergy.length; i++){
							let insertAllergy = 'INSERT INTO user_allergy(user_id, allergy) VALUES(?, ?);';
							console.log("allergy: ", req.body.allergy[i], " userId: ", rows.insertId);
							conn.query(insertAllergy, [rows.insertId, req.body.allergy[i]], (error, allergyResult) => {
								if (error) {
									res.status(400).json({messege: error});
									console.log("Allergy ", i, " error!", error);
									return 1;
								}
							});
						}
					}	
					await insertAllergies();
					res.status(201).json({messege: "new user created!"});
					return;
				}
				//알러지 없는 사용자일 경우
				else{
					res.status(201).json({messege: "new user created!"});
				}
			});	
		}
	});
};


