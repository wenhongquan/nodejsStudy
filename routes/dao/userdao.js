var mysql = require('mysql');
var pool  = mysql.createPool({
    connectionLimit : 10,
    host            : '127.0.0.1',
    user            : 'root',
    password        : 'root',
    database        : 'testdb'
});
var  userdao =  module.exports = {};

userdao.getuser = function(callback,count){

    pool.getConnection(function(err, connection) {
        // Use the connection
        connection.query( 'call selectuserbytype('+count+')', function(err, rows) {
            // And done with the connection.
            callback(err,rows);
            connection.release();

            // Don't use the connection here, it has been returned to the pool.
        });
    });
}

