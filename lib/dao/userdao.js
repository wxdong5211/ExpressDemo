var dao = require('../basedao');

exports.query=function(id,callback){
  dao.query('SELECT * from yh_hyb where YHM = ? ', [id],callback);
};