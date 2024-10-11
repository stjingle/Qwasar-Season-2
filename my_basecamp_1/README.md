# Welcome to My Basecamp 1
***

## Task
The goal of this project is to build a simplified project management tool inspired by Basecamp. The challenge is to implement core features like user registration, session management, role-based permissions, and project CRUD functionalities. The application should provide an efficient and intuitive user experience.

## Description
"My Basecamp 1" is a Ruby on Rails application that allows users to register, manage projects, and assign admin roles. This application focuses on role-based permissions where an admin users can create, edit, and delete projects, as well as manage other users' roles (promote/demote to admin). The app provides basic project management capabilities like creating, editing, viewing, and deleting projects.

- Key Features for the Project includes:
User Registration & Login: Users can sign up, log in, log out, and manage their accounts using the Devise gem.
Role Permissions: Admin users can assign and remove admin privileges for other users.
Project Management: CRUD functionality (Create, Read, Update, Delete) for projects is available for authorized users.
Bootstrap Integration: The user interface is styled using Bootstrap for a responsive and clean look.

## Installation
To get started with the project, follow the steps below to install the necessary tools and set up the project locally.

- Prerequisites
    Ruby: Version 7.1
    Rails: Version 7.1+
    Node.js: Version 14+ (required for compiling JavaScript assets)
    SQLite: Default database for Rails

- Step-by-Step Installation
Install Node.js: Node.js is required for managing the front-end assets in a Rails application. Download and install Node.js.

* Verify Node.js installation:
    "node -v"
    "npm -v"

Install Ruby 7.1: Download and Install Ruby.

* Verify Ruby installation:
    "ruby -v"

Install Rails 7.1: After installing Ruby, install Rails using the gem command:
    "gem install rails -v 7.1.0"

* Verify Rails installation:
    "rails -v"

- Clone the repository:
First you clone the repo, using
    "git clone"

Then you enter the folder/path 
    "cd my_basecamp_1"

Install required gems: Install the project dependencies, including Devise for authentication, by running:
    "bundle install"

Set up the database: Run the following commands to create and migrate the database:

    "rails db:create"
    "rails db:migrate"

Install Devise for User Authentication: Devise handles the user registration, login, and session management features. Run the following to set up Devise in the project:

    "rails generate devise:install"
    "rails generate devise User"
    "rails db:migrate"

Seed the Database: Create a default admin user for testing purposes:
    "rails db:seed"

Modify the db/seeds.rb file to add:

unless User.exists?(email: 'admin@example.com')
  User.create(email: 'admin@example.com', password: 'password', admin: true)
end

Then run the command:
    "rails db:seed"

Start the Rails server: To run the application, use:
    "rails server"
Open your browser and go to http://localhost:3000.

## Usage
Once the project is set up and the server is running, you can perform the following actions:

User Registration: Visit the sign-up page and create a new account.
User Login: Log in with your credentials to access the project management features.
Project Management:
Create new projects by navigating to the "New Project" page.
Edit or delete existing projects through the project detail view.
Role Management:
Admin users can assign other users as admins or remove their admin rights.
Only admin users can create or delete other admins.

- To run the Rails server:
    "rails server"

- To create a new admin user from the console:
    "rails console
    
    User.create(email: 'admin@admin.com', password: '123456', admin: true) unless User.exists?(email: 'admin@admin.com')
    User.create(email: 'admin2@admin.com', password: '123456', admin: true) unless User.exists?(email: 'admin2@admin.com')


* Fixing Migration Error:   
    In the place where a migration Error message is encountered while the rails sever is open, run the following commands:        
        "rails db:create db:migrate"        

    Use the command;        
    "rails db:seed" to seed the default admin user(s).


### The Core Team
 Sule Stephen Wuri and Abdulkarim Madinah otni 

<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering Schools Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px' /></span>
