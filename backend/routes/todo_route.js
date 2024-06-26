const todoController = require('../controller/todo_controller');


const router = require('express').Router();


router.post("/create-todo", todoController.createTodo);
router.post("/list-todo", todoController.listTodos);
router.post("/delete-todo", todoController.deleteTodo);
module.exports = router;