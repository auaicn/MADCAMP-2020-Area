var express = require('express')
var app = express.Router()
var bodyParser = require('body-parser')
var Poster = require('./poster')

app.use(bodyParser.urlencoded({extended:true}))
app.use(bodyParser.json({extended:true}))


// Upload the poster image
var multer = require('multer')
var storage = multer.diskStorage({
    destination: (req, file, callback)=>{
        callback(null, "uploads/")
    },
    filename: (req, file, callback)=>{
        callback(null, file.originalname)
    }
})
var upload = multer({
    storage: storage, 
    limits: {fieldSize:20*1024*1024}
})

app.post('/upload', upload.single('photo'), function(req, res){
    console.log('Upload image in the dir')
    console.log(req)
    console.log(req.body)
    res.status(200).json({result:1})
})

// Save uploaded image in DB
app.post('/', function(req, res) {
    console.log("Upload an image in DB")
    console.log(req.body)
    var poster = new Poster()

    poster.email = req.body.email
    poster.image = req.body.image
    poster.category = req.body.category

    poster.angle = req.body.angle
    poster.longitude = req.body.longitude
    poster.latitude = req.body.latitude
    poster.altitude = req.body.altitude

    poster.save(function(err) {
        if(err) return res.json({error:err})
        else return res.json({result:1})
    })
})

// Get Posters of my Interests
app.get('/interests/:interest', function(req, res) {
    console.log(req.body)

    console.log("Get Poster of my Interests")
    Poster.find({category: req.params.interest}, {}, function(err, poster) {
        if(err) return res.status(500).json({error:err})
        else return res.json(poster)
    })
})

// Get All Posters
app.get('/all', function(req, res) {
    console.log(req.body)
    console.log("Get All Posters")
    Poster.find({}, {}, function(err, poster) {
    // Poster.findOne({}, {}, function(err, poster) {
        if(err) return res.status(500).json({error:err})
        else {
            console.log(poster)
            return res.json(poster)
        }
    })
})

// Update Date, Interest
app.post('/update/info', function(req, res) {
    console.log("UPDATE!!!!!!!!!!")
    console.log(req.body)
    
    Poster.update({email: req.body.email, image: req.body.image}, {$set:{category:req.body.category, date:req.body.date}}, function(err, poster) {
        if(err) return res.status(500).json({error:err})
        else {
            console.log(poster)
            return res.json({result: 1})
        }
    })
})

module.exports = app