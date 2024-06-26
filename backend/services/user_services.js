const jwt = require('jsonwebtoken');
const user = require('../models/user_model');

class userServices {

    static async registerUser(email, password) {
        try {
            let checkedUser = await this.checkUser(email);

            if (!checkedUser) {

                const newUser = new user(
                    {
                        email: email,
                        password: password
                    }
                );

                return await newUser.save();

            }
            else {
                throw new ReferenceError("user id already taken");
            }
        }
        catch (err) {
            console.log(err);

        }
    }






    static async checkUser(email) {
        try {

            return await user.findOne({ email: email });
        } catch (error) {
            console.log(error);
            return;
        }
    }







    static async generateToken(tokenData, secretKey, jwt_expire) {
        return jwt.sign(tokenData, secretKey, { expiresIn: jwt_expire })
    }
}

module.exports = userServices;