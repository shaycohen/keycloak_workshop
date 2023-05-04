const express = require('express');
const session = require('express-session');
const bodyParser = require('body-parser');
const Keycloak = require('keycloak-connect');
const cors = require('cors');

const app = express();
app.use(bodyParser.json());

app.use(cors());

const memoryStore = new session.MemoryStore();

app.use(session({
  secret: 'asdasdasdasdasd12312312390812ojasdfkjhasdfb',
  resave: false,
  saveUninitialized: true,
  store: memoryStore
}));

const keycloak = new Keycloak({
  store: memoryStore
});

app.use(keycloak.middleware({
  logout: '/logout',
  admin: '/'
}));


app.get('/service/public', function (req, res) {
  res.json({message: 'public'});
});

app.get('/service/secured', keycloak.protect('realm:user'), function (req, res) {
  res.json({message: 'secured'});
});

app.get('/service/admin', keycloak.protect('realm:admin'), function (req, res) {
  res.json({message: 'admin'});
});

app.use('*', function (req, res) {
  res.send('Not found!');
});

app.listen(3001, function () {
  console.log('Started at port 3001');
});
