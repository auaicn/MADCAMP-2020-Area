var mongoose = require('mongoose')
var Schema = mongoose.Schema

var userSchema = new Schema({
    email: String,
    password: String,
    name: String,
    phone: String,
    interests: [ {category: String} ],
    bookmarks: [ {image: String} ],
    myGallery: [ {image: String} ]
})

module.exports = mongoose.model('user', userSchema)