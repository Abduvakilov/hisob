process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')

const brotli = require('./brotli')
environment.config.merge(brotli)

module.exports = environment.toWebpackConfig()
