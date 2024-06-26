const db = require('../config/db');
const user = require("./user_model");
const mongoose = require('mongoose');
const { Schema } = mongoose;

const todoSchema = new Schema({
    title: {
        type: String,
        required: true,

    },
    desc: {
        type: String,
        required: true,
    }
    ,


    userID: {
        type: String,
        ref: user.modelName
    }

})


const todo = db.model("todos", todoSchema);

module.exports = todo;