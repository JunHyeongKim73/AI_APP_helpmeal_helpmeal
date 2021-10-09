const jwt = require('jsonwebtoken');
const YOUR_SECRET_KEY = process.env.SECRET_KEY;
require('dotenv').config();
const verifyToken = (req, res, next) => {
try {
	console.log(JSON.stringify(req.cookies));
	const clientToken = req.cookies.user;
	const decoded = jwt.verify(clientToken, YOUR_SECRET_KEY);
	if (decoded) {
		res.locals.eamil = decoded.eamil;
	}
	else {
		res.status(401).json({ error: 'unauthorized' });
	}
} catch (err) {
	res.status(401).json({ error: err });
	console.log(err);
}
};
exports.verifyToken = verifyToken;
