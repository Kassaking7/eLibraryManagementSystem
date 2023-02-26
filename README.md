# eLibraryManagementSystem

The database will be stored in MySQL port 3306. And we use JDBC(Springboot+Mybatis) to receive data from db 3306, and we upload those data to port 8080. We use React(Next.js) for our web front end and use Axois to take data from port 8080.

To start the project:
* Turn on database and run the commands to creating the tables with sample data.
* Open idea, modify application-dev.yml file, use the password and username for your database. Then run the Java code (backend)
* Open Terminal, go to the next.js file and do npm run dev (frontend)
* Go to localhost 3000 port and use the library.

Test user:  
name: Sax ; password: Mc12!Anell7543ye

Note the for the frontend next.js, please init a next.js project and then copy those files to corresponding files
