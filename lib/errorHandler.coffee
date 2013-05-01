errorHandler = module.exports;

# assume 404 since no middleware responded
errorHandler.r404 = (req, res, next) ->
  res.status(404).render '404', url:req.originalUrl

# assume "not found" in the error msgs
# is a 404. this is somewhat silly, but
# valid, you can do whatever you like, set
# properties, use instanceof etc.
errorHandler.r5xx = (err, req, res, next) ->
  # treat as 404
  if ~err.message.indexOf  'not found'
    return next()
  console.error err.stack
  res.status(500).render '5xx'