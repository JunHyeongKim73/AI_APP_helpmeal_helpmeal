var express = require('express');
var  app = express();
var db_config = require(__dirname + '/config/database.js');
var conn = db_config.init();
var bodyParser = require('body-parser');
var cors = require('cors');
db_config.connect(conn);

app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');

app.use(cors()); //CORS문제 해결
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended : false}));

app.get('/', function (req, res) {
    res.send('ROOT');
});

var test_req = {

	//"day" : `'2021-09-27'`, 
	
	"troop_id" : 1, 
	
	"number_of_day" : 2
}
app.get('/menus', function (req, res) {
    sql = `SELECT name from food WHERE id IN (SELECT menu.food_id FROM meal INNER JOIN menu on menu.meal_id = meal.id WHERE troop_id = ${req.troop_id} AND meal.number_of_day = ${test_req.number_of_day} AND meal.day = ${req.day} ORDER BY menu_order);` 
    res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' }); 
	conn.query(sql, function (err, rows, fields) {
        if(err) console.log('query is not excuted. select fail...\n' + err);
        else {var menus = new Array(); 
			//메뉴 이름 담긴 배열 만들기
			for(i = 0; i < rows.length; i++) {
				res.write(JSON.stringify(rows[i])); 
   	        	var menu = new Object();
		    	menu.menu = rows[i].name;
		    	menu.order = i;
			
				menu = JSON.stringify(menu); 
		    	menus.push(JSON.parse(menu))	
			}
	        res.result = menus;
		    console.log(menus);	
		}
	});
});

app.get('/write', function (req, res) {
    res.render('write.ejs');
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
