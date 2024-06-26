const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const db = require("../config/db");

const { Schema } = mongoose;

const UserScheme = new Schema({


    email: {
        type: String,
        required: true,
        unique: true,

    },
    password: {
        type: String,
        required: true

    }

});






// here we need to know this keyword works only with "function" type function not arrow function 

UserScheme.pre("save", async function (next) {


    try {


        console.log("hashing the password");

        console.log(this.email + "    " + this.password + "      " + this);

        var user = this;

        const salt = await (bcrypt.genSalt(10));

        const hashpass = await bcrypt.hash(user.password, salt);

        user.password = hashpass;

        console.log("saving user ");

        next();

    } catch (error) {

        console.log(error);
    }
});


UserScheme.methods.comparePassword = async function (ReceivedPassword) {

    try {

        const isMatch = await bcrypt.compare(ReceivedPassword, this.password);

        return isMatch;

    } catch (error) {

        throw error;

    }
}

const user = db.model("users", UserScheme);

module.exports = user;