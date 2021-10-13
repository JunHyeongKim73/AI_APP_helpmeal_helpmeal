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
	console.log(req.body);
	conn.query(`INSERT INTO troop(level4, level3, level2, level1) VALUES(?, ?, ?, ?)`, [req.body[4], req.body[3], req.body[2], req.body[1]], function (error, insertedTroop) {
		if(error){
			res.status(400).json({messege: error});
			console.log(error);
		}
		res.status(201).json({messege: 'OK'});
		console.log("insertedTroopId: ", insertedTroop);
	})

};

//troop 검색 함수
exports.searchTroop = async function (req, res, next) {
	let selectTroopQuery = `SELECT * FROM troop WHERE level4 = ? and level3 = ? and level2 = ?;`;
	let paramList = [req.body[4], req.body[3], req.body[2]];

	if(req.body[2] == ''){
		selectTroopQuery = `SELECT * FROM troop WHERE level4 = ? and level3 = ?`;
		paramList = [req.body[4], req.body[3]];
	}
	console.log(selectTroopQuery);
	console.log(paramList);

	let troopList = await new Array();

	const selectedTroops = new Promise(async function(resolve, reject){
		conn.query(selectTroopQuery, paramList, async function (error, _troopList) {
			if(error) {
				res.status(401).json({messege: error});
			}
			else if(_troopList) {
				console.log(_troopList);
				for(let i=0; i<_troopList.length; i++){
					let troop = {
						'troopId': _troopList[i].id, 
						'4': _troopList[i].level4, 
						'3': _troopList[i].level3,
						'2': _troopList[i].level2,
						'1': _troopList[i].level1,
					}
					troopList[i] = troop;
				}
				res.status(200).json({troop: troopList});
			}
			else {
				res.status(400).json({messege: 'no group'});
			}
		})
	})	

}


