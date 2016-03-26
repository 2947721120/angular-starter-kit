app = require './app'
cpns = require './components'
ctrls = require './controllers'

angular
  .module 'app.core', []
  .config app.config
  .value app.service, app.directive
  .component app.directive, app.component

angular
  .module 'app.simple', []
  .controller 'PasswordController', ctrls.simple

angular
  .module 'app.simple2', []
  .component 'simpleCpn', cpns.simple
