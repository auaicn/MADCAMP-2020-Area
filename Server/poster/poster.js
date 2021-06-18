var mongoose = require('mongoose')
const { Decimal128 } = require('mongodb')
var Schema = mongoose.Schema

var posterSchema = new Schema({
    email: String,
    // latitude: Decimal128,
    // longitude: Decimal128,
    // altitude: Decimal128,
    // angle: Decimal128,
    latitude: String,
    longitude: String,
    altitude: String,
    angle: String,
    image: String,
    category: String,
    date: String, 
    post_date: {type:Date, default: Date.now}
})

module.exports = mongoose.model('poster', posterSchema)