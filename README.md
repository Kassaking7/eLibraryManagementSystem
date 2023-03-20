# eLibraryManagementSystem

The database will be stored in MySQL port 3306. And we use JDBC(Springboot+Mybatis) to receive data from db 3306, and we upload those data to port 8080. We use React(Next.js) for our web front end and use Axois to take data from port 8080.

Prerequest:
* [idea](https://www.jetbrains.com/idea/)
* [Node.js](https://nodejs.org/en/download)

To start the project:
* Turn on database and run the commands to creating the tables with sample data.
* Open idea, modify application-dev.yml file (located [here](https://github.com/Kassaking7/eLibraryManagementSystem/blob/main/LibraryBackend/src/main/resources/application-dev.yml)), use the password and username of your database. Then run the Java code (Backend)
* Choose a file to do 
```
npx create-next-app@latest nextjs-blog --use-npm --example "https://github.com/vercel/next-learn/tree/master/basics/learn-starter"
```
This will init a next.js project with basic config. Then replace the pages and styles files ([here](https://github.com/Kassaking7/eLibraryManagementSystem/tree/main/frontend)).
* Open Terminal, go to the next.js file and do 
```
npm run dev
```
(frontend)
* Go to localhost 3000 port and use the library.

Test user:  
name: Sax ; password: Mc12!Anell7543ye

Note:
* To check the SQL queries used in Backend, please see the .xml files in [here](https://github.com/Kassaking7/eLibraryManagementSystem/tree/main/LibraryBackend/src/main/resources/mapper)
