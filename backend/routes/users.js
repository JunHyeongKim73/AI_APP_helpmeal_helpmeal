const express = require('express');
const router = express.Router();
const usersController = require('./controllers/users.controllers');

router.post('/login', usersController.createToken);
router.post('/new', usersController.createNewUser);
router.post('/checkEmailoverlap', usersController.checkEmailOverlap);
module.exports = router;


