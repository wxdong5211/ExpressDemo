exports.isController=true;

exports.get = function(req, res, next){
  res.render('login', { title:'welcome it\'s login wxd modul' });
};

exports.post = function(req, res, next){
  var state = 'fail';
  var dao = require('../lib/dao/userdao');
  dao.query('test01',function(err, rows, fields){
    console.log('The pool solution is: ', rows[0]);
    if(rows[0]==null)
        res.render('login', { title:'welcome it\'s login wxd modul',login_state:'empty' });
    else 
        res.render('login', { title:'welcome it\'s login wxd modul',login_state:rows[0]['YHM'] });
  });
};