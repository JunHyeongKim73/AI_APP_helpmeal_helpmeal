const express = require('express');
const app = express();
const router = express.Router();
const cookieParser = require('cookie-parser');
const {verifyToken} = require(__dirname + '/../middlewares/authorization.js');
const db_config = require(__dirname + '/../config/database.js');
const conn = db_config.init();

db_config.connect(conn);
app.use(cookieParser());

//리뷰 작성하는 라우터
router.post('/:troopId/:day/:numberOfDay', async function(req, res) {
	//필요한 mealID 검색
	let mealId;
	const getMealIdQuery = `SELECT id FROM meal WHERE troop_id =? AND day = ? AND number_of_day = ?;`;
	conn.query(getMealIdQuery, [req.params.troopId, req.params.day, req.params.numberOfDay], async function(err, meals, fields){
		if(err) {
			res.status(401).json({meesege: err});	
			return;
		}
		else if(meals.length < 1) {
			console.log(req.params.troopId, req.params.day, req.body.numberOfDay)
			console.log(getMealIdQuery, meals);
			res.status(401).json({messege: '선택한 식단이 존재하지 않습니다!'});
			return;
		}
		mealId = meals[0].id;
		console.log("mealId: ", mealId);
		
		//리뷰 테이블에 삽입
		const insertReviewQuery = `INSERT INTO review(user_id, meal_id, comment) VALUES(?, ?, ?);`;
		conn.query(insertReviewQuery, [req.body.userId, mealId, req.body.comment], async function(err, results, fields){
			if(err) {
				console.log(err);
				res.status(401).json({meesege: err});	
				return;
			}
			res.status(201).send({messege: "review insert success!"});
		});
	});
});

router.get('/analytics/wordCount/:sentiment', async function(req, res) {
	const getwordsCountQuery = `SELECT word, count from review_data WHERE sentiment = ? AND day = '2021-10-16' AND troop_id = 1;`;
	conn.query(getwordsCountQuery, [req.params.sentiment], async function(err, wordCounts, field){
		res.send(wordCounts);
	});
});

//해당 끼니의 리뷰 읽어오는 라우터
router.get('/:troopId/:day/:numberOfDay', async function(req, res) {
	res.set( { 'content-Type': 'application/json'});		
	const getReviewQuery = `SELECT name, comment, created_at FROM review_view WHERE troop_id = ? AND day = ? AND number_of_day = ?;`;
	conn.query(getReviewQuery, [req.params.troopId, req.params.day, req.params.numberOfDay], async function (err, reviews, fields){
		if (err) {
			res.status(401).json({meesege: err});	
			return;
		}
		else if (reviews.length < 1){
			res.status(401).send({messege: "조건에 맞는 리뷰가 없습니다!"});
			return;
		}
		res.send(reviews);	
		return;
	});
});

//자기 자신이 작성한 리뷰를 읽어오는 라우터
router.post('/myReview', async function(req, res) {
	//res.locals.userId = 59 // cookie 읽는 작업 원활하게 진행되면 제거하기
	res.set( { 'content-Type': 'application/json'});		
	const getReviewQuery = `SELECT name, comment, created_at, day FROM review_view WHERE user_id = ?;`;
	conn.query(getReviewQuery,[req.body.userId], async function (err, reviews, fields){
		if (err) {
			res.status(401).json({meesege: err});	
			return;
		}
		else if (reviews.length < 1){
			res.status(401).send({messege: "작성한 리뷰가 없습니다!"});
			return;
		}
		res.send(reviews);	
		return;
	});
});

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
