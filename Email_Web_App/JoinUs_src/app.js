var express = require('express');
var mysql = require('mysql');
//sends information back 
var bodyParser = require('body-parser');
var app = express();

app.set("view engine", "ejs");
app.use(bodyParser.urlencoded({extended:true}));
app.use(express.static(__dirname + "/public"));


// Create connection with mysql database
var connection = mysql.createConnection({
	host	:	'localhost',
	user	:	'root',
	database	: 'join_us'
});


app.get("/", function(req, res){
	// Find count of users in database and respond with that count
	var q = "SELECT COUNT(*) AS count FROM users";
	connection.query(q, function(error, results){
		if(error) throw error;
		var count = results[0].count;

		// send html, result of sql query
		res.render("home", {count: count});
	});
});

app.post('/register', function(req, res){
	var email = req.body.email;
	console.log("POST request sent to /register, email is " + email)
	
	// insert email into sql database
	var person = {email: email}
	connection.query('INSERT INTO users SET ?', person, function(error, result){
		if(error) throw error;
		console.log(result + " inserted into users table ");
	});	
});

app.listen(3000, function(){
	console.log('Server running on 3000');
});