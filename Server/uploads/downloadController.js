var express = require('express');
var app = express.Router();
var bodyParser = require('body-parser');
var fs = require('fs');

app.use(bodyParser.urlencoded({ extended:true }));
app.use(bodyParser.json({extended:true}))

app.get('/:filename',function(req, res) {
    console.log("download request")
    console.log(req.params.filename);
    fs.readFile(req.params.filename, function(error, data){
        res.sendfile("uploads/"+req.params.filename);
    })
});

module.exports = app;