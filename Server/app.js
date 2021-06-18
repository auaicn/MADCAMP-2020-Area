var express = require('express')
var app = express()
var bodyParser = require('body-parser')
var mongoose = require('mongoose')

// 1. Run Server
var port = process.env.PORT || 80
var server = app.listen(port, function(){
    console.log('Express server has started on port ' + port)
})

// 2. Connect to Mongodb Server
var db = mongoose.connection;
mongoose.connect('mongodb://localhost:27017/project4', { 
    useNewUrlParser: true, useUnifiedTopology: true
})

db.on('error', console.error)
db.once('open', function(){
    console.log('Successfully Connected to Mongodb')
})

// 3. Routing
const DownloadController = require('./uploads/downloadController.js')
const PosterController = require('./poster/posterController')
const UserController = require('./user/userController')
app.use('/downloads', DownloadController)
app.use('/users', UserController)
app.use('/posters', PosterController)