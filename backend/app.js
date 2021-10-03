const express = require('express');
const  app = express();
const db_config = require(__dirname + '/config/database.js');
const conn = db_config.init();
const cors = require('cors');
var mealId, foodId;
db_config.connect(conn);

app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');

app.use(cors()); //CORS문제 해결
app.use(express.json());//req body 파싱
app.use(express.urlencoded({ extended: true }))
app.get('/', function (req, res) {
    res.send('ROOT');
});

app.get('/menus/:troopId/:day/:numberOfDay', function (req, res) {
	res.set({ 'Content-Type': 'application/json'});
	menuSelection = `SELECT name, calorie from food WHERE id IN (SELECT menu.food_id FROM meal INNER JOIN menu on menu.meal_id = meal.id WHERE troop_id = ${req.params.troopId} AND meal.number_of_day = ${req.params.numberOfDay} AND meal.day = "${req.params.day}" ORDER BY menu_order);` 

	conn.query(menuSelection, function (err, rows, fields) {
		if(err) console.log('query is not excuted. select fail...\n' + err);
		else { 
			//API형식 맞추기
			for(j = 0; j < rows.length; j++) {
				rows[j].order = j+1;
		        delete rows[j].id;	
				//results[i].push(JSON.stringify(rows[j]));
			}
		}
        console.log(rows[0].name); 
	    console.log(JSON.stringify(rows[0]));	
	    //rows = JSON.stringify(rows);	
		//results[i] = rows;	
		//console.log(JSON.stringify(results));	
	});
    console.log(JSON.stringify(rows)); 
	res.send(JSON.stringify(rows));
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
    const getFoodId = new Array(10);	
    const insertMenus = new Promise(function (resolve, reject){	
		for(let i = 0; i < req.body.menus.length; i++){	
			//food id 얻기
			getFoodId[i] = new Promise(function (resolve, reject) { 
				selectFood = `SELECT id FROM food WHERE name = "${req.body.menus[i].name}";`; 	
				conn.query(selectFood, function (err, food, fields) {
					if(err) console.log('query error\n' + err);
					else{
						//food insert	
						if(food.length < 1){
							//if(req.body.menus[i].calorie){	
							insertFood = `INSERT INTO helpmeal.food(name) VALUES("${req.body.menus[i].name}");`;	
							conn.query(insertFood, function (err, rows, fields) {
									if(err) console.log('food insert query error\n' + err);
									else{
										conn.query(selectFood, function(err, food, fields){
											if(err) console.log('food select query error\n' + err);
											else{
												foodId = food[0].id;	
												console.log(`food ${i} insert success!, foodId: ${foodId}`);
												resolve();	
											}	
										});	
									}
								});	
							}
							else{
								foodId = food[0].id	
								console.log(`food ${i} ${req.body.menus[i].name} already exist!, foodId: ${foodId}`);
								resolve();	
							}
					}
				});	
			});	
			//알러지 있을 경우	
			getFoodId[i].then(() => {	
				if(req.body.menus[i].allergy){
					insertAllergy =`INSERT IGNORE INTO helpmeal.food_allergy(food_id, allergy) VALUES(${foodId}, "${req.body.menus[i].allergy}");`; 	
					conn.query(insertAllergy, function (err, rows, fields) {
						if(err) console.log('allergy query error\n' + err);
						else{
							console.log(`allergy ${i} insert success!`);	
						}
					});	
				}	

				//menu 추가
				getMealId.then(() => {
					insertMenu = `INSERT IGNORE INTO helpmeal.menu(meal_id, food_id, menu_order) VALUES(${mealId}, ${foodId}, 0);`;	
					conn.query(insertMenu, function (err, rows, fields) {
						if(err) console.log('query error\n' + err);
						else{
							console.log(`menu ${i} insert success!`);	
							req.body.menus[i].order = i+1;	
							console.log(req.body.menus[i].order, i);	
						}
					});
				});
			});
			if(i==req.body.menus.length-1) resolve();	
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
