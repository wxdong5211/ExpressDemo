poolModule = require 'generic-pool'
pool = poolModule.Pool
  name     : 'mysql'
  create   :(callback) ->
    mysql      = require 'mysql'
    connection = mysql.createConnection
      host     : 'localhost'
      database : 'yzjp'
      user     : 'root'
      password : '123123'
      #debug : true
    connection.connect (err, server) ->
      # callback(err, this);
    callback null, connection
  destroy  :(db) -> db.end()
  max      : 10
  # optional. if you set this, make sure to drain() (see step 3)
  min      : 2
  # specifies how long a resource can stay idle in pool before being removed
  idleTimeoutMillis : 30000
  # if true, logs via console.log - can also be a function
  # log : true

exports.query = (presql,param,callback) ->
  # acquire connection - callback function is called
  # once a resource becomes available
  pool.acquire (err, client) ->
    if err
      # handle error - this is generally the err from your
      # factory.create function
    else
      client.query presql, param, (err, rows, fields) ->
        callback err, rows, fields
        # return object back to pool
        pool.release client