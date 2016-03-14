cpns = require './components/index.coffee'
ctrls = require './controllers/index.coffee'

angular
  .module 'app.core', []
  .component 'app', cpns.app
  .controller 'AppCtrl', ctrls.app
