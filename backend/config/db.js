const mongoose = require('mongoose');


// mongoose.connect("mongodb+srv://haharshit22:oMs7hTBZMW4gZcS2@todoapp.8ouyk6x.mongodb.net/?retryWrites=true&w=majority&appName=todoapp").then(() => {
//     console.log("the connection has been established");
// }).catch((err) => console.log(err));
const Connection = mongoose.createConnection("mongodb+srv://harshitag1810:LJidBk6Kyn3tbulp@cluster0.eeiwr1y.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0")



    .on("connected", () => {// whenever the connection is established with the database then this function will be ex
        console.log("connected to the database")
    })


    .on("open", () => { console.log("the database is opened "); })


    .on("error", (err) => {
        console.log(err);
    })




module.exports = Connection;