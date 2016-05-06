var express = require('express');
var Thenjs = require('thenjs');
var router = express.Router();

var userdao = require('./dao/userdao.js');

/* GET users listing. */
router.get('/', function(req, res, next) {

    var _count = req.query.count;
    var data= "";
    Thenjs().then(function () {
        userdao.getuser(function (error,rows) {
            console.log(rows[0].name)
            data =  rows[0].name;
            res.send(200,rows)
        },_count)
    })

});

module.exports = router;
