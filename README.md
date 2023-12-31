# README


Design Decisions:
After reviewing the test, this ended up being the overall structure for the classes integrating the solution

![CC-Eng-Design](https://github.com/manuelxwhite/credit_card_processing_batch/assets/16273215/8c89a3c0-f72b-4af2-8385-c94a61de6ca3)


Programming Language Choice:
For this solution, I used Ruby on Rails. Ruby is a dynamic, object-oriented programming language known for its simplicity and readability. It has a rich ecosystem and a web framework like Rails, which can be advantageous for building web applications. Additionally, Ruby provides excellent string manipulation and file processing capabilities, making it suitable for implementing the requirements of this credit card processing program.

Required Dependencies:
To run the Ruby code, you need to have Ruby installed on your machine. You can download Ruby from the official website (https://www.ruby-lang.org/en/downloads/) and follow the installation instructions specific to your operating system.

Building/Compiling:
Since Ruby is an interpreted language, there is no need for explicit building or compiling. However, if you have any additional dependencies or gems (Ruby libraries) required for your code you must follow the following instructions:

Running the Code and Tests:
To run the code, you can follow these steps:
1. Open a terminal or command prompt.
2. clone the project repository, executing the following command in the terminal:
   ```
   git clone git@github.com:manuelxwhite/credit_card_processing_batch.git
   ```
3. Navigate to the directory where the project was saved 
   ```
   cd credit_card_processing_batch
   ```
4. To install all the framework dependencies use the following command:
   ```
   bundle install
   ```
5. Store the testing batch files inside `batch_files` directory.
6. To execute the code use the following command:
   ```
   bundle exec rake process_file test.txt
   ```
   Replace `test.txt` with the actual filename containing the input commands.

   or execute the following command for capturing STDIN in the terminal
   ```
   bundle exec rake process_file
   ```
6. The program will process the input commands and generate the summary output, which will be displayed in the terminal.

Testing:
To test your code, you can write unit tests using a testing framework like RSpec. These tests can ensure that your code functions correctly and handles different scenarios appropriately.

To run all tests you'll have to execute:
   ```
   bundle exec respe spec/models/
   ```

   or you can execute the following for a particular set:
   ```
   bundle exec respe spec/models/account_spec.rb
   ```

Additional Notes: `Rubocop` was utilized to ensure good coding practices.
