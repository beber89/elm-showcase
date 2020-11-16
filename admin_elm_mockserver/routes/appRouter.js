const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');


const appRouter = express.Router();

appRouter.use(bodyParser.json());

appRouter.route('/members/:date')
    .all( (req, res, next) => {
        res.statusCode = 200;
        res.setHeader('Content-Type', 'application/json');
        next();
    })
  .get( (req, res, next) => {
    var resBody = [
      {ename:'Hamada', arrival:'8:00 pm', nid: 'A350011', img:'Hamada.jpg'},
      {ename:'Hamdy', arrival:'8:00 pm', nid: 'A350012', img:'Hamdy.jpg'},
      {ename:'Derek', arrival:'8:00 pm', nid: 'A350013', img:'Derek.jpg'}
    ]
    res.end(JSON.stringify(resBody));
  });

appRouter.route('/p/nid/:nid/img/:img')
  .all( (req, res, next) => {
      res.statusCode = 200;
      next();
  })
  .get( (req, res, next) => {
    var options = {
      root: path.join(__dirname,'..', 'public')
    };    
    res.sendFile(req.params.img, options);
});  

appRouter.route('/pendings')
  .all( (req, res, next) => {
      res.statusCode = 200;
      next();
  })
  .get( (req, res, next) => {
    var resBody = [{imgName:'Hamada', nid:'A350011', date: '2020-09-09'}]
    res.end(JSON.stringify(resBody));
});  

module.exports = appRouter
  