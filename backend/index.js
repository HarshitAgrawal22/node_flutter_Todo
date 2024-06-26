const app = require("./app");
const Connection = require("./config/db")
const port = 3000;
const todo = require("./models/todo_model");
const user = require('./models/user_model');


app.get('/', (req, res) => {
    res.send('GET request to the homepage');
});





app.listen(port, () => {
    console.log(`server is at http://localhost:${port}`);
});