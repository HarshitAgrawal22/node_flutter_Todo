const userServices = require('../services/user_services');



// here this means register is a function which is async acepts 3 arguments and get exported 
exports.register = async (req, res, next) => {
    try {
        const { email, password } = req.body;



        const successRes = await userServices.registerUser(email, password);
        console.log(successRes);
        if (successRes === undefined) {
            res.json(
                {
                    status: false,
                    success: "UserId already taken "
                }
            );
        } else {

            res.json(
                {
                    status: true,
                    success: "User has been registered successfully "
                }
            );
        }

    } catch (error) {
        console.log(error);
        res.json({
            status: false,
            message: "something bad happened"
        })
    }
}

exports.login = async (req, res) => {
    try {
        const { email, password } = req.body;
        // always remember to use await keyword 
        console.log(email + "  " + password);
        const user = await userServices.checkUser(email);
        if (!user) {

            res.json({
                error: "User not found",
                status: false


            });
        }
        else {
            const isMatch = await user.comparePassword(password);

            if (isMatch === false) {
                res.json({
                    error: "password doesn't match",
                    status: false


                });
            }
            else {
                console.log(user);
                const tokenData = {
                    id: user._id,
                    email: user.email
                };
                const jwttoken = userServices.generateToken(tokenData, "Harshit", "1h").then((token) => {
                    res.status(200).json({
                        status: true,
                        message: "this took hell of my time",
                        token: token
                    });

                }).catch(
                    (err) => {
                        res.send({
                            status: false,
                            message: "unable to generate token",

                        })
                    }
                )
            }

        }
    }
    catch (err) {
        console.log(err);
    }
}

