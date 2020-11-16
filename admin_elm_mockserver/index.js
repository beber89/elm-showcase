const express = require('express'),
     http = require('http');
const morgan = require('morgan');
const bodyParser = require('body-parser');
const cors = require('cors');

const appRouter = require('./routes/appRouter');

const hostname = 'localhost';
const port = 8080;

const app = express();

app.use(cors());
app.use(morgan('dev'));
app.use(bodyParser.json());

app.use('', appRouter);

const server = http.createServer(app);

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});