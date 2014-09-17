log4js = require('log4js')
logger = log4js.getLogger('authentication')

app = require('./application')
config = app.locals.config

router =          require('express').Router()
passport =        require('passport')
GoogleStrategy =  require('passport-google').Strategy
# mongo =           require("mongodb")
# MongoClient =     mongo.MongoClient

router.get '/google', passport.authenticate('google')

router.get '/google/return', 
  passport.authenticate 'google', 
    successRedirect: '/'
    failureRedirect: '/login'

passport.use new GoogleStrategy {
    returnURL: config['baseUrl'] + '/api/auth/google/return'
    realm: config['baseUrl']
  }, (identifier, profile, done) ->
    user = { identifier: identifier, profile: profile }
    done(null, user)

router.get '/ping', (req, res) ->
  if req.user?
    res.send req.user
  else
    res.status(401).send "Unauthorized"

## Serializing a user to the session is fairly simple.
## Deserializing a user from the session requires some database lookup and role
## access. We really want to ensure that any roles are set and passed back. The
## final user object should be passed back to the front end, where it can store
## it and make it available to the front end.

# passport.serializeUser (user, done) -> 
#   MongoClient.connect config['data']['user']['store']['url'], (err, db) ->
#     return done(err, null) if err?
#     callback = (err, user) ->
#       db.close()
#       done(err, user)
#     db.collection "users", (err, users) ->
#       return callback(err, null) if err?
#       users.update {userId: user.identifier}, {'$set' : {profile: user.profile}}, {upsert: true}, (err, result) ->
#         return callback(err, null) if err?
#         callback(err, user.identifier)

# passport.deserializeUser (identifier, done) ->
#   MongoClient.connect config['data']['user']['store']['url'], (err, db) ->
#     return done(err, null) if err?
#     callback = (err, user) ->
#       db.close()
#       done(err, user)
#     db.collection "users", (err, users) ->
#       return callback(err, null) if err?
#       users.findOne {userId: identifier}, callback

module.exports = {router: router, passport: passport}