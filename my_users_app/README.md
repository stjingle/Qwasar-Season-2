# Welcome to My Users App
***

## Task
In this project we will implement a very famous architecture: MVC (Model View Controller) Simulating the sinatra app control.

## Description
Part 1 
Create a class User that will find, update and destroy user in sqlite, the table will carry the attribute firstname, lastname, age, password and email.
Part 2
Create a controller. You will use your User class from Part I. Your route will return a JSON.
Part 3
Add a route /. This one will respond with HTML.
Create subdirectory views and inside, create a file named: index.html (you will have to submit it)

## Installation
To install the project you will have to run the project on a terminal using the sqlite3 compile command.

## Usage
To run the project;
1. You compile the the Gemfile
2. You install Bundler by inputing on the terminal console (bundle install).
3. You run the app (ruby app.rb).When the server starts running. and use ctrl + C to stop the server.
4. Open another Terminal and input the following commands:

-To Create a user:
    curl -X POST http://0.0.0.0:8080/users -d "firstname=John" -d "lastname=Doe" -d "age=30" -d "password=secret" -d "email=johndoe@example.com" 
-To Get all users:
    curl http://0.0.0.0:8080/users
-To Sign in:
    curl -X POST http://0.0.0.0:8080/sign_in -d "email=johndoe@example.com" -d "password=secret" -c cookies.txt 
-To Update user password (it will requires sign-in):
    curl -X PUT http://0.0.0.0:8080/users -d "password=newsecret" -b cookies.txt
-To Sign out:
    curl -X DELETE http://0.0.0.0:8080/sign_out -b cookies.txt
-To Delete user (requires sign-in):
    curl -X DELETE http://0.0.0.0:8080/users -b cookies.txt

### The Core Team


<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering School's Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px' /></span>
