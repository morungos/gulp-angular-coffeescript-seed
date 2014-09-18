## Main modules
express =   require('express')
log4js =    require('log4js')
nconf =     require('nconf')

## Middlewares
methodOverride = require('method-override')
cookieParser =   require('cookie-parser')
morgan =         require('morgan')
bodyParser =     require('body-parser')

## Note we export immediately, allowing circular dependencies
app = module.exports = express()

## Initialize logging
logger = log4js.getLogger('application')

## Configure ourselves
config = require('./configuration').getConfiguration()
app.locals.config = config

app.locals.pretty = true

app.use methodOverride('X-HTTP-Method-Override')
app.use cookieParser()
app.use morgan('short')
app.use bodyParser.json()

