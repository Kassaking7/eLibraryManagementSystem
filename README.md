# eLibraryManagementSystem
This is a new version of eLibraryManagementSystem. Order version can be found in [CS348version](https://github.com/Kassaking7/eLibraryManagementSystem/tree/CS348version)

I also made a new [Blog](https://kassakingzyw.com/posts/eLibrarySpringboot) in my personal website for this new update. 

The database will be stored in MySQL port 3306. And we use JDBC(Springboot+Mybatis) to receive data from db 3306, and we upload those data to port 8080. We use React(Next.js) for our web front end and use Axois to take data from port 8080. We also use Redis to temporarily store login information and redis-cli is open in port 6379

Prerequest:
* [idea](https://www.jetbrains.com/idea/)
* [Node.js](https://nodejs.org/en/download)

To start the project:
* Turn on database and run the commands to creating the tables with sample data.
* Open idea, modify application-dev.yml file (located [here](https://github.com/Kassaking7/eLibraryManagementSystem/blob/main/LibraryBackend/src/main/resources/application-dev.yml)), use the password and username of your database. Then run the Java code. It will take some time for those who run Springboot Project first time since idea will automatically install the required dependency (Backend)
* Open terminal. cd to LibraryFrontend and do 
```
npm run dev
```
(frontend)
If an error on next happen (happens for all who first run a next.js prject), it's likely that you have to do a
```
npm install next react react-dom
```
If there's still lots of errors, it's likely that your npm version is old. Please do 
```
npm install
```
to update npm
* Go to localhost 3000 port and use the library.

Test admin user:  
name: Emmalyn; password: unGCZtARdY

Sign up is activated. Feel free to sign up a new account and use as guest

Note:
* To check the SQL queries used in Backend, please see the .xml files in [here](https://github.com/Kassaking7/eLibraryManagementSystem/tree/main/LibraryBackend/src/main/resources/mapper)

# Available Features So Far

* Login
* Sign Up
* Searching Books
* Borrow Books

# Generating Production Dataset

The production dataset of our library system is generated via two ways. The first is using online webpage [mockaroo](https://www.mockaroo.com/). The other is using the [python program](https://github.com/Kassaking7/eLibraryManagementSystem/tree/main/dataGeneration). Both will directly output the data informat of sql insertion codes.

# Load Production Dataset into Database
* Create tables by using the [table creation schema](https://github.com/Kassaking7/eLibraryManagementSystem/tree/main/schema/table_creation_schema)
* Adding [triggers](https://github.com/Kassaking7/eLibraryManagementSystem/tree/main/SQL/triggers)
* Loading [each sql file](https://github.com/Kassaking7/eLibraryManagementSystem/tree/main/SQL/Milestone2_Data/Production_Data) under this folder
* Don't forget to add the [procedures](https://github.com/Kassaking7/eLibraryManagementSystem/tree/main/SQL/functions)
