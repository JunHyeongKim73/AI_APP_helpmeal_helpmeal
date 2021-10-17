const express = require('express');
const app = express();
const db_config = require(__dirname + '/config/database.js');
const conn = db_config.init();
const fs = require('fs');
const cors = require('cors');
const morgan = require('morgan');
const logger = require('./logger');

const userRouter = require('./routes/users');
const starRouter = require('./routes/stars');
const reviewRouter = require('./routes/reviews');
const troopRouter = require('./routes/troops');
const menuRouter = require('./routes/menus');
const suggestionRouter = require('./routes/suggestion');

const { verifyToken } = require('./middlewares/authorization');
const cookieParser = require('cookie-parser');
const https = require('https');
const PORT = process.env.PORT || 443;  
const options = {
  key: fs.readFileSync(__dirname + '/../../../../etc/letsencrypt/live/helpmeal.duckdns.org/privkey.pem'),
  cert: fs.readFileSync(__dirname + '/../../../../etc/letsencrypt/live/helpmeal.duckdns.org/fullchain.pem'),
  ca: fs.readFileSync(__dirname + '/../../../../etc/letsencrypt/live/helpmeal.duckdns.org/fullchain.pem')
};
db_config.connect(conn);

app.set('views', __dirname + '/views');

app.use(cors()); //CORS문제 해결
app.use(express.json());//req body 파싱
app.use(express.urlencoded({ extended: true }))
app.use(morgan('dev'));
app.use('/users', userRouter);
app.use('/stars', starRouter);
app.use('/reviews', reviewRouter);
app.use('/troops', troopRouter);
app.use('/menus', menuRouter);
app.use('/suggestion', suggestionRouter);
app.use(cookieParser());
app.use((req, res, next) => {
  const error =  new Error(`${req.method} ${req.url} 라우터가 없습니다.`);
  error.status = 404;
  logger.info('hello');
  logger.error(error.message);
  next(error);
});

if (process.env.NODE_ENV === 'production') {
	app.use(morgan('combined'));
}
else{
	app.use(morgan('dev'));
}

app.get('/', verifyToken, function (req, res) {
	res.send('ROOT');
});

https.createServer(options, app).listen(PORT);
