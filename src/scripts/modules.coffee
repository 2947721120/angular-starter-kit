config = require './config'
values = require './values'
core = require './core'
cpns = require './components'

angular
  .module 'app.core', []
  .config config.core
  .value '$routerRootComponent', values.core
  .component 'app', core

angular
  .module 'app.simple', []
  .component 'simple', cpns.simple
