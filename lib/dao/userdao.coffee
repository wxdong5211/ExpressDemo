dao = require '../basedao'

exports.query = (id,callback) ->
  dao.query 'SELECT * from yh_hyb where YHM = ? ', [id],callback