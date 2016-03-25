app = require './app'
ctrls = require './controllers'

angular
  .module 'app.core', []
  .config app.config
  .value app.service, app.directive
  .component app.directive, app.component

angular
  .module 'app.simple', []
  .controller 'PasswordController', ctrls.simple
