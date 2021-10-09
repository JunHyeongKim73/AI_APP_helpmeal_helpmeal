const passport = require('passport');
const local = require('./localStrategy');
const db_config = require(__dirname + '/config/database.js');
module.exports = () => {
  passport.serializeUser((user, done) => {
    done(null, user.id);
  });

  passport.deserializeUser((id, done) => {
    User.findOne({ where: { id } })
      .then(user => done(null, user))
      .catch(err => done(err));
  });

  local();
};
