import 'babel/polyfill';
import path from 'path';
import logger from 'morgan';
import bodyParser from 'body-parser';
import cookieParser from 'cookie-parser';
import jwt from 'express-jwt';
import express from 'express';
import cons from 'consolidate';

import login from './routes/login';

const server = express();

server.set('port', (process.env.PORT || 5000));
server.set('views', path.join(__dirname, 'views'));
server.set('view engine', 'html');
server.engine('html', cons.underscore);
server.use(express.static(path.join(__dirname, 'public')));

server.use(logger('dev'));
server.use(bodyParser.json());
server.use(bodyParser.urlencoded({extended: false}));
server.use(cookieParser());
server.use(jwt({
  secret: 'i am a bad bad secret',
  credentialsRequired: false,
  getToken: function fromHeaderOrQueryString(req) {
    if (req.headers.authorization &&
      req.headers.authorization.split(' ')[0] === 'Bearer') {
      return req.headers.authorization.split(' ')[1];
    } else if (req.cookies && req.cookies.token) {
      return req.cookies.token;
    }

    return null;
  }
}));

server.use('/', login);

server.listen(server.get('port'), () => {
  if (process.send) {
    process.send('online');
  } else {
    console.log('The server is running: at http://localhost:' +
      server.get('port'));
  }
});
