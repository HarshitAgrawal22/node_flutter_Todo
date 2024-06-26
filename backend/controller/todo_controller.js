const Todo_Services = require('../services/todo_services');

exports.createTodo = async (req, res) => {
    try {
        const { userId, title, desc } = req.body;
        console.log(req.body);
        let newTODO = await Todo_Services.createTodo(userId, title, desc);

        console.log(newTODO);
        res.json({
            status: true,
            success: newTODO
        });



    } catch (error) {
        console.log(error);

    }
}


exports.listTodos = async (req, res, next) => {
    try {
        const { userId } = req.body;
        let todo = await Todo_Services.listTodos(userId);
        res.json({
            status: true,
            success: todo
        });
    }
    catch (error) {
        res.json({
            status: false,
            message: "the todos failed"
        })
    }
}

exports.deleteTodo = async (req, res, next) => {
    try {
        const { todoId } = req.body;
        Todo_Services.deleteTodo(todoId);
        res.json({
            status: true,
            message: "todo deleted successfully"
        });
    } catch (error) {
        console.log(error);
        res.json({
            status: false,
            message: "an error is encountered"
        })
    }
}
