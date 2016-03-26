app = require './app'
cpns = require './components'

angular
  .module 'app.core', []
  .config app.config
  .value app.service, app.directive
  .component app.directive, app.component

angular
  .module 'app.simple', []
  .component 'simpleCpn', cpns.simple
