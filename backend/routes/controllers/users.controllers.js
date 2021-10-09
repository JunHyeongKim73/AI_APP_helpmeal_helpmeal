const jwt = require('jsonwebtoken');
require('dotenv').config();
const db_config = require(__dirname + '/../../config/database.js');
const YOUR_SECRET_KEY = process.env.SECRET_KEY;
const conn = db_config.init();
db_config.connect(conn);


exports.createToken = async function (req, res, next)  {
	try {
		const SelectUser = `SELECT * FROM user WHERE email = "${req.body.email}";`;	
		conn.query(SelectUser, (error, rows) => {	
			if(error) {
				res.status(401).json({meesege: error});
			}	
			else{
				if (rows.length > 0) {
					if (rows[0].password == req.body.password){	
						const token = jwt.sign({
							email: rows[0].email,
							name: rows[0].name
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

	//return troopId	
	const findTroopId = new Promise(function(resolve, reject) {
		let troop2, troop1, userId;
		selectTroop = `SELECT * FROM troop WHERE level4 = ? AND level3 = ?;`;
			conn.query(selectTroop, [req.body.troop[4], req.body.troop[3]],function (error, troops) {
				if (error) {
					res.status(401).json({messege: error});
					console.log(error);	
					}
				else if(troops.length < 0){
					res.status(401).json({messege: "존재하지 않는 부대입니다!"});
				}
				else if (!req.body.troop[2]){
					troop2 = NULL;		
					troop1 = NULL;
				}
				else if (!req.body.troop[1]){
					troop1 = NULL; 
				}
				else{
					troop2 = req.body.troop[2]; troop1 = req.body.troop[1]; 
				}
				//부대 선택	
				conn.query(`SELECT id FROM troop WHERE level4 = ? AND level3 = ? AND level2 = ? AND level1 = ?`, [req.body.troop[4], req.body.troop[3], req.body.troop[2], req.body.troop[1]], function (error, troopList) {
					if (error){
						res.status(401).json({messege: error});
						console.log(error);	
					}
					//부대 없을 경우
					else if(troopList.length < 1){
						conn.query(`INSERT INTO troop(level4, level3, level2, level1) VALUES(?, ?, ?, ?)`, [req.body.troop[4], req.body.troop[3], req.body.troop[2], req.body.troop[1]], function (error, insertedTroop) {
							if (error){
								res.status(400).json({messege: error});
								console.log(error);	
							}			
							console.log("insertedTroopId: ", insertedTroop.insertid);
							troopId = insertedTroop.insertId;
							resolve(troopId);
						});
					}
					else{
						troopId = troopList[0].id;
						console.log("troopId: ", troopId);
						resolve(troopId); 
					}
				});	
			});
	});	
	
	Promise.all([findTroopId, checkEmailOverlap])
	.then((promiseResult) => {
		console.log("foundTroopId: ", promiseResult[0]);
		//관리자인 경우
		if(req.body.managerLevel){
			const createUser = `INSERT INTO user(name, password, troop_id, military_serial_number, email, manage_level) VALUES(?, ?, ?, ?, ?, ?);`;
			conn.query(createUser, [req.body.name, req.body.password, promiseResult[0], req.body.military_serial_number, req.body.email, req.body.managerLevel], (error, rows) => {
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
			const createUser = `INSERT INTO user(name, password, troop_id, military_serial_number, email) VALUES(?, ?, ?, ?, ?);`;
			conn.query(createUser, [req.body.name, req.body.password, promiseResult[0], req.body.military_serial_number, req.body.email], async function(error, rows) {
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


