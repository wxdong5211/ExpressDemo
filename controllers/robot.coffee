http = require 'http'

exports.isController=true

exports.get = (req, res, next) ->
  res.render 'home', title:'welcome it\'s home wxd modul'
  post()

post = ->
  http.request {hostname:'www.baidu.com',method:'POST'},(res) ->
    console.log 'Post STATUS: ' + res.statusCode
    console.log 'Post HEADERS: ' + JSON.stringify res.headers
    res.setEncoding 'utf8'
    res.on 'data', (chunk) ->
      console.log 'Post BODY: ' + chunk
  .on 'error',(e) ->
    console.log "Post error: " + e.message
  .end()

get = ->
  http.get 'http://www.baidu.com',(res) ->
    console.log 'Got STATUS: ' + res.statusCode
    console.log 'Got HEADERS: ' + JSON.stringify res.headers
    res.setEncoding 'utf8'
    res.on 'data', (chunk) ->
      console.log 'Got BODY: ' + chunk
  .on 'error',(e) ->
    console.log "Got error: " + e.message