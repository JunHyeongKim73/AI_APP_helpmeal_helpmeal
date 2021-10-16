const express = require('express');
const app = express();
const router = express.Router();
const cookieParser = require('cookie-parser');
const {verifyToken} = require(__dirname + '/../middlewares/authorization.js');
const db_config = require(__dirname + '/../config/database.js');
const conn = db_config.init();
db_config.connect(conn);
app.use(cookieParser());

//건의사항 작성하는 라우터
router.post('/', async function(req, res) {
	const insertSuggestionQuery = `INSERT INTO suggestion(user_id, comment) VALUES(?, ?);`;
	conn.query(insertSuggestionQuery, [req.body.userId, req.body.comment], async function(err, result, fields){
		if (err) {
			console.log(err);
		}
		else {
			req.body.id = result.insertId;
			res.send(req.body);
		}
	});
});

//부대의 건의사항 조회하는 라우터 
router.get('/:troopId', async function(req, res){
	const getSuggestionQuery = `SELECT * FROM suggestion_view WHERE troop_id = ? ORDER BY created_at DESC;`;
	conn.query(getSuggestionQuery, [req.params.troopId], async function(err, suggestions, field){
		if(err) {
			console.log(err);
		}
		res.send(suggestions);
	});
});

//사용자의 건의사항을 조회하는 라우터
router.get('/users/:userId', async function(req, res){
	const getSuggestionQuery = `SELECT * FROM suggestion WHERE user_id = ? ORDER BY created_at DESC;`;
	conn.query(getSuggestionQuery, [req.params.userId], async function(err, suggestions, field){
		if(err) {
			console.log(err);
		}
		res.send(suggestions);
	});
});

module.exports = router;
