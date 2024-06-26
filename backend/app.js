const express = require('express');
const app = express();
const body_parser = require("body-parser");
const user_router = require("./routes/user_routes");
const todo_router = require("./routes/todo_route");
app.use(body_parser.json());
app.use("/", user_router);
app.use("/todo", todo_router);
module.exports = app;
