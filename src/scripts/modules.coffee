core = require './core'
cpns = require './components'

angular
  .module 'app.core', []
  .config core.config
  .value core.service, core.directive
  .component core.directive, core.component

angular
  .module 'app.simple', []
  .component 'simpleCpn', cpns.simple
