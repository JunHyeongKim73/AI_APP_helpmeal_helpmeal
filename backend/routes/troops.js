const express = require('express');
const router = express.Router();
const usersController = require('./controllers/troops.controllers');

router.post('/postTroop', usersController.addNewTroop);
module.exports = router;
