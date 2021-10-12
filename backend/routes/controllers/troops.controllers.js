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

//troop 추가 함수
exports.addNewTroop = async function (req, res, next) {
	let troopId;	

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
};


