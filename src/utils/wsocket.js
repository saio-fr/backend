import yargs from 'yargs';
import configBuilder from './config';
import Socket from '@saio/wsocket';

const options = yargs.argv;
const config = configBuilder(options);

console.log(config.ws.url);

const socket = new Socket(config.ws.url, config.ws.realm, {
  authId: config.ws.authId,
  password: config.ws.password
});

socket.open();

export default socket;
