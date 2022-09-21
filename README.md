# Todo-App

>  ToDoCervidae file is a Web API solution for todo project. TodoApp/todo_flutter is a flutter file for the projet.

1. In Web API project, I used Entity Framework and migration to create automatically database and its variable.

2. Whit this app, you can add, delete or update your task.

- create_page.dart has a simple dialog which contains creation of task. After you create a task, which means when
you click on he create button, you have to click cross icon to close the simple dialog.
- data.dart file has initialization and constructor of the variables in sql.
- edit_page.dart file has a different page that edit the task. However it cannot working due to exception. I could
not find any solution.
- home_screen.dart file is a main page of todo app. It has a list of task. There are three icons working with
delete, edit and if task is complete or not.
- main.dart file has runApp function.
- todo_api file has connection with Web API and command of futures.
