const todo = require("../models/todo_model");

class Todo_Services {
    static async createTodo(userId, title, desc) {
        const newTodo = new todo({
            userID: userId,
            desc: desc,
            title: title
            ,
        });
        return await newTodo.save();
    }
    // https://mega.nz/folder/acwyXSQC#2wIPOicNScY-LYe-5bCHPg
    static async listTodos(userId) {
        const todos = await todo.find({ userID: userId });

        return todos;
    }

    static async deleteTodo(todoId) {
        console.log(todoId);
        console.log(
            await todo.deleteOne({
                _id: todoId
            }));

    }
}

module.exports = Todo_Services;