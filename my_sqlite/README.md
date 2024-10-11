# Welcome to My Sqlite

***

## Task

The task is to build a simplified version of SQLite that can perform basic SQL operations such as `SELECT`, `INSERT`, `UPDATE`, and `DELETE` on CSV files. The challenge lies in accurately parsing SQL-like commands from the user, executing these commands on CSV files, and handling potential errors gracefully.

## Description

The problem is solved by creating two main components: `MySqliteRequest` and `MySqliteQueryCli`.

1. **MySqliteRequest**: This class handles the core functionality of parsing and executing SQL-like commands on CSV files.
    - **Initialization**: Sets up the initial state of the request object.
    - **Methods**: Implements methods to handle `SELECT`, `INSERT`, `UPDATE`, `DELETE`, `JOIN`, and `ORDER BY` commands.
    - **Execution Methods**: Contains methods to execute the parsed commands and interact with the CSV files.
    - **Validation**: Ensures that the commands are valid and the necessary data is provided.

2. **MySqliteQueryCli**: This class provides a command-line interface for users to input their SQL-like queries.
    - **Input Collection**: Uses the `Readline` library to collect user input.
    - **Command Analysis**: Parses the input commands and delegates the execution to `MySqliteRequest`.
    - **Execution**: Runs the parsed commands and displays the results or errors.

## Installation

To install the project, follow these steps:

1. Clone the repository to your local machine.
2. Ensure you have Ruby installed on your machine.

## Usage
**To use the my_sqlite_request.rb**:

Write your test cases in the main function e.g: 
request = MySqliteRequest.new
request = request.from('nba_player_data.csv')
request = request.select('name')
request.run


**To use the CLI, follow these steps**:

1. Navigate to the project directory.
2. Run the following command to start the CLI:
   ```
   ruby my_sqlite_cli.rb
   ```
3. Once the CLI is running, you can input SQL-like commands to interact with your CSV files. Here are some examples:
   - **SELECT**:
     ```
     my_sqlite_cli> my_sqlite_cli> SELECT * FROM students
     ```
   - **INSERT**:
     ```
     my_sqlite_cli> INSERT INTO students VALUES (John,john@johndoe.com,A,https://blog.johndoe.com)
     ```
   - **UPDATE**:
     ```
     my_sqlite_cli> UPDATE students SET email = 'jane@janedoe.com', blog = 'https://blog.janedoe.com' WHERE name = 'Mila'
     ```
   - **DELETE**:
     ```
     my_sqlite_cli> DELETE FROM students WHERE name = 'John'
     ```

### The Core Team
ESTHER NEHEMIAH AMOS
SULE STEPHEN WURI

<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering School's Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px' /></span>