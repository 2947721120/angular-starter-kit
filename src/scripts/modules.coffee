app = require './app'
ctrls = require './controllers'

angular
  .module 'app.core', []
  .config app.config
  .value app.inject, app.tag
  .component app.tag, app.component

angular
  .module 'app.simple', []
  .controller 'SimpleCtrl', ctrls.simple
