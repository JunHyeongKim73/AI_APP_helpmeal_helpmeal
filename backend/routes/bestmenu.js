const express = require('express');
const app = express();
const router = express.Router();
const cookieParser = require('cookie-parser');
const {verifyToken} = require(__dirname + '/../middlewares/authorization.js');
const db_config = require(__dirname + '/../config/database.js');
const conn = db_config.init();
const  moment = require('moment');
moment().format();
db_config.connect(conn);
app.use(cookieParser());

router.get('/', function(req, res){	
	console.log(moment());
	const startDay = moment().format('YYYY-MM-DD');
	console.log(typeof startDay);	
	if(req.query.duration == "day"){
		endDay = moment().format('YYYY-MM-DD');
	}
	else{
		endDay = moment().subtract(1, req.query.duration).format('YYYY-MM-DD');
		console.log(endDay);
	}
	const getBestMenusQuery = `SELECT * FROM best_menu_view WHERE day <= ? AND day >= ? AND rate_number >= 1 ORDER BY average_star DESC, rate_number DESC LIMIT 5;`; 
	conn.query(getBestMenusQuery, [startDay, endDay], async function(err, bestMenus, fields){
		if (err) {
			res.status(401).json({meesege: err});	
			return;
		}
		else if (bestMenus.length < 1){
			res.status(401).json({meesege: "조건에 맞는 메뉴가 없습니다!"});	
			return;
		}
		console.log(bestMenus);
		res.send(bestMenus);		
	});

});

module.exports = router;
