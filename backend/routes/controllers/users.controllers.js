const express = require('express');
const app = express();
const jwt = require('jsonwebtoken');
require('dotenv').config();
const crypto = require('crypto');
const db_config = require(__dirname + '/../../config/database.js');
const YOUR_SECRET_KEY = process.env.SECRET_KEY;
const conn = db_config.init();
const cookieParser = require('cookie-parser');
db_config.connect(conn);
app.use(express.json());//req body 파싱
app.use(cookieParser);
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
						//클라이언트에서 활용할 정보
						const selectTroopQuery = `SELECT * from troop WHERE id = ?`; 
						let troop = await {'troopId': '', '4': '', '3': '', '2': '', '1': ''};
						//프로미스로 만들기
						const selectTroop = new Promise(async function(resolve, reject){ 
							conn.query(selectTroopQuery, [rows[0].troop_id], async function (error, userTroop) {
								if(error) {
									res.status(401).json({meesege: error}); 
								}	
								else if (userTroop){
									troop['troopId'] = userTroop[0].id;
									troop['4'] = userTroop[0].level4;
									troop['3'] = userTroop[0].level3;
									troop['2'] = userTroop[0].level2;
									troop['1'] = userTroop[0].level1;

									resolve();
								}
								else resolve("no troop");
							});	
						});	

						let allergies_res = await new Array();

						const selectAllergyQuery = `SELECT * from user_allergy WHERE user_id = ?;`;	
						const selectAllergy = new Promise(async function(resolve, reject){
							conn.query(selectAllergyQuery, [rows[0].id], async function (error, allergies) {
								if(error) {
									res.status(401).json({meesege: error});
								}	
								else if (allergies){
									console.log(allergies);
									for(let i = 0; i < allergies.length; i++){
										allergies_res[i] = allergies[i].allergy;
										console.log("Allergy ", i, ": ", allergies_res[i]);
										if(i == allergies.length - 1) resolve();
									}			
									resolve();
								}
								else resolve("no allergy");
							});	
						});

						Promise.all([selectTroop, selectAllergy])
							.then((messege) => {
								const token = jwt.sign({
									userId: rows[0].id,
									email: rows[0].email,
									name: rows[0].name,
									manageLevel: rows[0].manage_level,
									troop: troop,
									allergy: allergies_res,
								}, YOUR_SECRET_KEY, {
									expiresIn: '10d'
								});

								res.cookie('user', token, maxAge =  10 * 24 * 60 * 60 * 1000);
								console.log(res.cookie);	

								res.send({
									result: 'ok', token: token					
								});
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

//이메일 중복 검증하는 함수
exports.checkEmailOverlap = async function (req, res) {
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
				res.status(200).json({
					result: "Overlapped"
				});	
				return;
			}
			else resolve();
		});	
	});
	checkEmailOverlap
		.then(() => {
			res.status(200).json({result: "Not Overlapped"})
		});
};

//회원가입 함수
exports.createNewUser = async function (req, res, next) {
	//	let troopId;	
	//	
	//	const findTroopId = new Promise(function(resolve, reject) {
	//		let troop2, troop1, userId;
	//		selectTroop = `SELECT * FROM troop WHERE level4 = ? AND level3 = ?;`;
	//			conn.query(selectTroop, [req.body.troop[4], req.body.troop[3]],function (error, troops) {
	//				if (error) {
	//					res.status(401).json({messege: error});
	//					console.log(error);	
	//					}
	//				else if(troops.length < 0){
	//					res.status(401).json({messege: "존재하지 않는 부대입니다!"});
	//				}
	//				else if (!req.body.troop[2]){
	//					troop2 = NULL;		
	//					troop1 = NULL;
	//				}
	//				else if (!req.body.troop[1]){
	//					troop1 = NULL; 
	//				}
	//				else{
	//					troop2 = req.body.troop[2]; troop1 = req.body.troop[1]; 
	//				}
	//				//부대 선택	
	//				conn.query(`SELECT id FROM troop WHERE level4 = ? AND level3 = ? AND level2 = ? AND level1 = ?`, [req.body.troop[4], req.body.troop[3], req.body.troop[2], req.body.troop[1]], function (error, troopList) {
	//					if (error){
	//						res.status(401).json({messege: error});
	//						console.log(error);	
	//					}
	//					//부대 없을 경우
	//					else if(troopList.length < 1){
	//						conn.query(`INSERT INTO troop(level4, level3, level2, level1) VALUES(?, ?, ?, ?)`, [req.body.troop[4], req.body.troop[3], req.body.troop[2], req.body.troop[1]], function (error, insertedTroop) {
	//							if (error){
	//								res.status(400).json({messege: error});
	//								console.log(error);	
	//							}			
	//							console.log("insertedTroopId: ", insertedTroop.insertid);
	//							troopId = insertedTroop.insertId;
	//							resolve(troopId);
	//						});
	//					}
	//					else{
	//						troopId = troopList[0].id;
	//						console.log("troopId: ", troopId);
	//						resolve(troopId); 
	//					}
	//				});	
	//			});
	//	});	

	//비밀번호 암호화
	const { password, salt } = await createHashedPassword(req.body.password);	
	//console.log("salt: ", salt, "len: ", salt.length);	
	//findTroopId
	//.then((messege) => {
	//관리자인 경우
	console.log(req);
	if(req.body.managerLevel > 0){
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
	//});
};


