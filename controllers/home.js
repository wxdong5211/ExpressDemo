exports.isController=true;

exports.get = function(req, res, next){
  res.render('home', { title:'welcome it\'s home wxd modul' });
};