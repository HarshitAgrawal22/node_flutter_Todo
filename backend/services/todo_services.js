const todo = require("../models/todo_model");
const { GoogleGenerativeAI } = require("@google/generative-ai");

class Todo_Services {
    static async createTodo(userId, title, desc) {
        desc = await this.generate(desc);
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
    "AIzaSyDfKEbgWUCz73eEAJ893B44OpZOevf1YUw"
    // Access your API key as an environment variable.


    static async generate(prompt) {
        const genAI = new GoogleGenerativeAI('AIzaSyDFDklQRskmKByRdaU11zkNHVbR8CRAVf0');
        // Choose a model that's appropriate for your use case.
        const model = genAI.getGenerativeModel({ model: "gemini-1.0-pro-latest" });

        const finalPrompt = `Here is a startup idea: "${prompt}". Improve this idea by removing any potential issues, enhancing the concept, and providing additional innovative suggestions. If it's just a simple todo task for future, just make it grammatically correct.`;

        const result = await model.generateContent(finalPrompt);
        const response = result.response;
        const text = response.text();
        return text;
    }




}

module.exports = Todo_Services;