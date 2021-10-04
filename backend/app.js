const express = require('express');
const  app = express();
const db_config = require(__dirname + '/config/database.js');
const conn = db_config.init();
const cors = require('cors');
const morgan = require('morgan');
var mealId;
db_config.connect(conn);

app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');

app.use(cors()); //CORS문제 해결
app.use(express.json());//req body 파싱
app.use(express.urlencoded({ extended: true }))
app.use(morgan('dev'));
app.get('/', function (req, res) {
    res.send('ROOT');
});

app.get('/menus/:troopId/:day/:numberOfDay', function (req, res) {
	res.set({ 'Content-Type': 'application/json'});
	menuSelection = `SELECT name, id from food WHERE id IN (SELECT menu.food_id FROM meal INNER JOIN menu on menu.meal_id = meal.id WHERE troop_id = ${req.params.troopId} AND meal.number_of_day = ${req.params.numberOfDay} AND meal.day = "${req.params.day}" ORDER BY menu_order);`; 
	let k = 0;
	let results = new Array();	
	const selectMenu = new Promise(function (resolve, reject){
		conn.query(menuSelection, function (err, rows, fields) {
			if(err) console.log('menuSelect query is not excuted. select fail...\n' + err);
			else { 
				results = rows;	
				//알러지 조회하기
				for(let j = 0; j < rows.length; j++) {
					rows[j].order = j+1;
					selectAllergy = `SELECT * FROM food_allergy WHERE food_id = ${rows[j].id};`;	
					conn.query(selectAllergy, function (err, allergy, fields) {
						if(err) console.log('allergySelect query is not excuted. select fail...\n' + err);
						else{
						 	//해당 음식에 알러지가 존재하는 경우	
							if(allergy[0]){
								const showAllergy = new Promise(function (resolve, reject){
									rows[j].allergy = new Array(); 
									for(let i = 0; i < allergy.length; i++){
										rows[j].allergy[i] = allergy[i].allergy;
										console.log("allergy:", allergy[i].allergy);
									}		
									resolve();//프로미스의 작업이 모두 끝나고 호출	
								});
								showAllergy.then(() => {
									k++;	
									if(k==rows.length) resolve();
								});
							}

							//해당 음식에 알러지가 없는 경우	
							else{
								console.log("food ", j+1, ", no allergy");	
								k++;	
								if(k==rows.length) resolve();	
							}	
						}
					});
					delete rows[j].id;
				}
			}	
		});
	});
	selectMenu.then(() => {	
		console.log("result:", JSON.stringify(results)); 
		res.send(JSON.stringify(results));
	});
});

app.post('/menus', function (req, res) {
    res.set( { 'content-Type': 'application/json'});	
    const result = new Object(); 
	//Meal id 얻기	
 	const getMealId = new Promise(function (resolve, reject){	
		selectMeal = `SELECT id FROM meal WHERE troop_id = ${req.body.troopId} AND day = "${req.body.day}" AND number_of_day = ${req.body.numberOfDay};`;
		conn.query(selectMeal, function (err, meals, fields) {
			if(err) console.log('query error\n' + err);
			else{
				//MEAL table에 삽입	
				if(meals.length < 1){
					//console.log("nomealid");	
					insertMeal = `INSERT INTO helpmeal.meal(troop_id, day, number_of_day) VALUES(${req.body.troopId}, "${req.body.day}", ${req.body.numberOfDay});`
					conn.query(insertMeal, function (err, rows, fields) {
						if(err) console.log('query error\n' + err);
						else{
							conn.query(selectMeal, function(err, meals, fields){
								if(err) console.log('query error\n' + err);
								else{
									mealId = meals[0].id;	
									console.log("meal insert success!, mealId: ", mealId);
									resolve();	
								}	
							});	
						}
					});	
				}
				else{
					mealId = meals[0].id	
					console.log("meal already exist!, mealId: " , mealId);
					resolve();	
				}
			}
		});	
	});	
	//각각의 메뉴에 대해서 반복	
   	let count = 0; 
	const getFoodId = new Array(10);
	const foodId = new Array();
   	const insertFood = new Array();
	const selectFood = new Array();
	const insertMenus = new Promise(function (resolve, reject){	
		for(let i = 0; i < req.body.menus.length; i++){	
			//food id 얻기
			getFoodId[i] = new Promise(function (resolve, reject) { 
				selectFood[i] = `SELECT id FROM food WHERE name = "${req.body.menus[i].name}";`; 	
				conn.query(selectFood[i], function (err, food, fields) {
					if(err) console.log('query error\n' + err);
					else{
						//food insert	
						if(food.length < 1){
							insertFood[i] = `INSERT INTO helpmeal.food(name) VALUES("${req.body.menus[i].name}");`;	
							conn.query(insertFood[i], function (err, rows, fields) {
									if(err) console.log('food insert query error\n' + err);
									else{
										conn.query(selectFood[i], function(err, food2, fields){
											if(err) console.log('food select query error\n' + err);
											else{
												console.log(food2);	
												foodId[i] = food2[0].id;	
												console.log(`food ${i} insert success!, foodId: ${foodId[i]}`);
												resolve();	
											}	
										});	
									}
								});	
							}
							else{
								foodId[i] = food[0].id	
								console.log(`food ${i} ${req.body.menus[i].name} already exist!, foodId: ${foodId[i]}`);
								resolve();	
							}
					}
				});	
			});	
			//알러지 있을 경우	
			getFoodId[i].then(() => {	
				if(req.body.menus[i].allergy){
					for(let j = 0; j < req.body.menus[i].allergy.length; j++){
						insertAllergy =`INSERT IGNORE INTO helpmeal.food_allergy(food_id, allergy) VALUES(${foodId[i]}, "${req.body.menus[i].allergy[j]}");`; 	
						conn.query(insertAllergy, function (err, rows, fields) {
							if(err) console.log('allergy query error\n' + err);
							else{
								console.log(`allergy ${i}-${j} insert success!`);	
							}
						});	
					}	
				}
				//menu 추가
				getMealId.then(() => {
					insertMenu = `INSERT IGNORE INTO helpmeal.menu(meal_id, food_id, menu_order) VALUES(${mealId}, ${foodId[i]}, ${i+1});`;	
					conn.query(insertMenu, function (err, rows, fields) {
						if(err) console.log('query error\n' + err);
						else{
							console.log(`menu ${i} insert success!`);	
							req.body.menus[i].order = i+1;
							count++;
							console.log(`count: ${count}`);	
							if(count==req.body.menus.length) resolve();	
						}
					});
				});
			});
		}
	});	
	insertMenus.then(() => {	
		console.log("end");	
		res.send(JSON.stringify(req.body));
	});
});

app.post('/writeAf', function (req, res) {
    var body = req.body;
    console.log(body);

    var sql = 'INSERT INTO menu(meal_id, food_id, menu_order, average_star) VALUES(?, ?, ?, ?)';
    var params = [body.meal_id, body.food_id, body.menu_order, body.average_star];
    console.log(sql);
    conn.query(sql, params, function(err) {
        if(err) console.log('query is not excuted. insert fail...\n' + err);
        else res.redirect('/list');
    });
});

app.listen(80, () => console.log('Server is running on port 80...'));
