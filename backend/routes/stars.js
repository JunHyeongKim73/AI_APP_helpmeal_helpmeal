const express = require('express');
const app = express();
const router = express.Router();
const cookieParser = require('cookie-parser');
const db_config = require(__dirname + '/../config/database.js');
const conn = db_config.init();
db_config.connect(conn);
//별점 작성 API
app.use(cookieParser());

//평균 별점 관리하는 함수
const manageAverageStarAndRateNumber = async function(menuId, rating){
	selectMenuQuery = `select * from menu WHERE id = ?;`;
	conn.query(selectMenuQuery, [menuId], function(err, menus, fields){
		if(err) console.log('select menu query is not excuted. select fail...\n' + err);
		let averageStar = menus[0].average_star;
		let rateNumber = menus[0].rate_number;
		let newAverageStar = (averageStar * rateNumber + rating)/(rateNumber + 1)
		let newRateNumber = rateNumber + 1;
		console.log(newAverageStar, newRateNumber);
		let updateMenuQuery = `UPDATE menu SET average_star = ?, rate_number = ? WHERE id = ?;`;
		conn.query(updateMenuQuery, [newAverageStar, newRateNumber, menuId], function(err, result, fields){
			if(err) {
				console.log('update menu query is not excuted. select fail...\n' + err);
				//res.status(401).send({messege: err});
				return 0;
			}
			console.log("update average star sucess!");
			return 1;
		});
	});
};
	
router.post('/:troopId/:day/:numberOfDay', async function(req, res) {
	//메뉴 id 얻기
	getMenuIdQuery =`SELECT menu.id, menu.food_id, menu.menu_order FROM meal INNER JOIN menu on menu.meal_id = meal.id WHERE troop_id = ?  AND meal.number_of_day = ? AND meal.day = ? ORDER BY menu_order;`
	conn.query(getMenuIdQuery, [req.params.troopId, req.params.numberOfDay, req.params.day], async function (err, menus, fields) {
		if(err) console.log('mealSelect query is not excuted. select fail...\n' + err);
		else if (menus.length < 1){
			res.status(401).json({messege:"해당하는 메뉴가 없습니다!"});
			return;
		}
		let foodNames = new Array();
		console.log("menus[0]: ", menus[0]);
		//음식 이름 비교하기
		const insertStars =new Promise(async function(resolve, reject){
			let count = 0
			for(let i = 0; i < menus.length; i++){
				getFoodNameQuery = `SELECT * FROM food WHERE id = ?;`;
				conn.query(getFoodNameQuery, [menus[i].food_id], async function (err, foods, fields) {
					if(err) console.log('foodSelect query is not excuted. select fail...\n' + err);
					console.log(foods);
					foodNames[i] = foods[0].name;//안되면 push 사용
					console.log("foodNames: ", foodNames);	
					if(foodNames[i] == req.body[i].name){
						//별점 테이블에 isnert
						let isSucceess = await manageAverageStarAndRateNumber(menus[i].id, req.body[i].stars);	
						insertStarsQuery = `INSERT INTO star(menu_id, star_number) VALUES(?, ?);`;
						conn.query(insertStarsQuery, [menus[i].id, req.body[i].stars], async function(err, result, fields){
							if(err) {
								res.status(401).json({messege: err});
								console.log(err);
								return;
							}
							console.log("insert", i, " 성공!");
							count++;
							if (count == menus.length) resolve();
						});
					}
					else { 
						res.status(401).json({messege: "메뉴 번호와 이름이 일치하지 않습니다!"});
						return
						console.log("메뉴이름 다름");
						count++;
						if (count == menus.length) resolve();
					}
				});
			}
		});	
		insertStars
		.then(() => {
			console.log(req.cookies);
			res.status(201).send({messege: "insert 성공!"});
		});
	});
});

//별점 GET
router.get('/:troopId/:day/:numberOfDay', async function(req, res){
	getStarsQuery =`SELECT name, menu_order, star_number AS stars, user_id, created_at FROM star_view WHERE troop_id = ?  AND number_of_day = ? AND day = ? ORDER BY menu_order, created_at;`
	conn.query(getStarsQuery, [req.params.troopId, req.params.numberOfDay, req.params.day], async function (err, stars, fields) {
		if(err) console.log('mealSelect query is not excuted. select fail...\n' + err);
		else if (stars.length < 1){
			res.status(401).json({messege:"해당하는 별점이 없습니다!"});
			return;
		}
		res.send(stars);
	});
});
module.exports = router;
