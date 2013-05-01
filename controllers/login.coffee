exports.isController=true

exports.get = (req, res, next) ->
  res.render 'login',title:'welcome it\'s login wxd modul'

exports.post = (req, res, next) ->
  state = 'fail'
  dao = require '../lib/dao/userdao'
  dao.query 'test01',(err, rows, fields)->
    if err?
      console.error err
    if not rows? or not rows[0]?
      msg = 'empty'
      res.render 'login',title:'welcome it\'s login wxd modul',login_state:'empty'
    else
      msg = rows[0]
      res.render 'login',title:'welcome it\'s login wxd modul',login_state:rows[0]['YHM']
    console.log 'The pool solution is: ', msg