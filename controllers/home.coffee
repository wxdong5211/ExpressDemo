exports.isController=true

exports.get = (req, res, next) ->
  res.render 'home', title:'welcome it\'s home wxd modul'