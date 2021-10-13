const express = require('express');
const router = express.Router();
const usersController = require('./controllers/troops.controllers');

router.post('/post', usersController.addNewTroop);
router.post('/get', usersController.searchTroop);

module.exports = router;

