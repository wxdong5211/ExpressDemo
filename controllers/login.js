exports.isController=true;

exports.get = function(req, res, next){
  res.render('login', { title:'welcome it\'s login wxd modul' });
};

exports.post = function(req, res, next){
  var state = 'fail';
  var dao = require('../lib/dao/userdao');
  dao.query('test01',function(err, rows, fields){
    if(err!=null){
        console.error(err);
    }
    var msg;
    if(rows==null||rows[0]==null){
        msg = 'empty';
        res.render('login', { title:'welcome it\'s login wxd modul',login_state:'empty' });
    } else {
        msg = rows[0];
        res.render('login', { title:'welcome it\'s login wxd modul',login_state:rows[0]['YHM'] });
    }
    console.log('The pool solution is: ', msg);
  });
};