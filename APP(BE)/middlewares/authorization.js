const express = require('express');
const app = express();
const jwt = require('jsonwebtoken');
const cookieParser = require('cookie-parser');
const YOUR_SECRET_KEY = process.env.SECRET_KEY;
require('dotenv').config();
app.use(cookieParser());

const verifyToken = (req, res, next) => {
try {
	//if(req.headers.authorization && req.headers.authorization.startWith('Bearer')){
  //앞에 Bearer과 하나의 공백을 빼고 토큰 값만 파싱 ! */
  //		const clientToken = req.headers.authorization.split(' ')[1];
//	}	
	//console.log(req.cookies);
	consoloe.log(req.body);
	const clientToken = req.body.token;
	console.log(clientToken);
	const decoded = jwt.verify(clientToken, YOUR_SECRET_KEY);
	if (decoded) {
		console.log("decoded!");
		res.locals.userId = decoded.userId;
	 	res.locals.manageLevel = decoded.manageLevel;	
		next();
	}
	else {
		res.status(401).json({ error: 'unauthorized' });
	}
} catch (err) {
	res.status(401).json({ messege: err });
	console.error();	
	}
  	//res.writeHead(200, { 'Set-cookie': 'mycookie=test'});
	//console.log("req.cookies: ", req.cookies);
	//console.log("res.cookie: ", res.cookies);
	//res.send({messege: "cookie error!"});
};
exports.verifyToken = verifyToken;
