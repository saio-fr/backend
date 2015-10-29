import express from 'express';
import jwt from 'jsonwebtoken';
import wsocket from '../utils/wsocket';
import restricted from '../utils/restricted';

const router = express.Router();

router.get('/login', function(req, res) {
  res.render('login/index');
});

router.post('/auth/check', function(req, res) {

  wsocket.call('fr.saio.internal.user.login', [], {
    email: req.body.email,
    password: req.body.password
  }).then((user) => {

    if (user) {
      // Set token into cookie
      const token = jwt.sign(user, 'i am a bad bad secret');
      res.cookie('token', token);
      res.status(200).send('you have been loged in');
    } else {
      res.status(403).send('email or password incorrect');
    }
  }).catch((err) => {
    console.log(err);
    res.status(400).send(err.message);
  });
});

router.get('/auth/logout', restricted, function (req, res) {
  res.cookie('token', null);
  res.status(200).send('you have been loged out');
});

export default router;
