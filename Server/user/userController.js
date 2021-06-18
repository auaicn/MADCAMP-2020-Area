var express = require('express')
var app = express.Router()
var bodyParser = require('body-parser')
var User = require('./user')

// Configure app to use body-parser
app.use(bodyParser.urlencoded({extended:true}))
app.use(bodyParser.json({extended:true}))


// Login
app.post('/login', function(req, res) {
    console.log('Login')
    console.log(req.body)
    User.find({email: req.body.email}, {email: 1, password:1, _id:0}, function(err, user){
        console.log(user)
        if(err) return res.status(500).json({error: err})
        else if(user.length == 0) return res.status(500).json("Email Not Found")
        else {
            User.find({email: req.body.email, password: req.body.password}, {email:1, password:1, name:1, interests:1, _id: 0}, function(err, user) {
                if(err) return res.status(500).json({error: err})
                else if(user.length == 0)        
                
                return res.status(404).json("Wrong Password")
                else {
                    console.log(user)

                    return res.json(user)
                }
            })
        }
    })
})

// Register
app.post('/register', function(req, res) {
    console.log('Register')


    var user = new User()

    user.name = req.body.name
    user.phone = req.body.phone
    user.email = req.body.email
    user.password = req.body.password
    user.interests = req.body.interests
    console.log(req.body)
    User.find({email: user.email}, {email:1, _id:0}, function(err, nuser) {
        // console.log(nuser)
        if(err) return res.status(500).json({error:err})
        if(nuser.length == 0) {
            user.save(function(err) {
                if(err) return res.status(500).json({error:err})
                else return res.json({result: 1})
            })
        }
        else return res.json("Already Exists")
    })
    
})


// Update Interests
app.post('/update/interests', function(req, res) {
    console.log('Update my interests')

    User.updateOne({email: req.body.email}, {$set: {interests: req.body.interests}}, function(err, user) {
        console.log(user)
        if(err) return res.status(500).json({error:err})
        else if (user.length == 0) return res.status(404).json("User Not Found")
        else return res.json({result: 1})
    })
})



// Get My Gallery
app.get('/mygallery/:email', function(req, res) {
    console.log("Get My Gallery")
    console.log(req.params.email)
    User.find({email: req.params.email}, {}, function(err, user) {
        console.log(user)
        if(err) return res.status(500).json({error:err})
        else if (user.length == 0) return res.status(404).json("User Not Found")
        else return res.json(user)
    })
})


module.exports = app