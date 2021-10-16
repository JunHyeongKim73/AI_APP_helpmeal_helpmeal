var mysql      = require('mysql');
var conn = mysql.createConnection({
  	host     : 'localhost',    // 호스트 주소
  	port: '3306',
	user     : 'yangbchu',           // mysql user
  	password : 'mynumber14',       // mysql password
  	database : 'helpmeal'         // mysql 데이터베이스
});

module.exports = conn;
