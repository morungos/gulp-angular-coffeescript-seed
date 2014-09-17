## A single component that provides the configuration data

log4js = require('log4js')
logger = log4js.getLogger('configuration')

nconf = require('nconf')

## Configure ourselves
module.exports.getConfiguration = () ->
  options = require('minimist')(process.argv.slice(2))
  configFile = options.config || process.cwd() + "/config.json"

  nconf
    .use('memory')
    .argv()
    .file({ file: configFile })

  logger.info "Reading configuration file: #{configFile}"

  nconf.defaults
    'password:salt': '',
    'server:port': 3001,
    'server:address': "0.0.0.0",
    'debug': true,
    'authenticate': false,
    'baseUrl': 'http://localhost:3000',
    'apikey': 'garblemonkey',
    'cookieSecret': 'keyboard cat',
    'serveStatics': false,
    'serveIndex': false

  nconf.get()
