// Connects to mysql database and inserts data

const { faker } = require('@faker-js/faker');
var mysql = require('mysql');

// establish connection
var connection = mysql.createConnection({
	host	:	'localhost',
	user	:	'root',
	database	: 'join_us'
});

// create user data to be inserted into users table
var data  = []
for (var i = 0; i < 500; i++) {
	data.push([
		faker.internet.email(), 
		faker.date.past()
]);
}

// bulk INSERT query
var q = 'INSERT INTO users(email, created_at) VALUES ?';

// Reference the connection created, run the query q 
connection.query(q, [data], function(error, result) {
	console.log(error);
	console.log(result);
});

connection.end();