cpns = require './components/index.coffee'
ctrls = require './controllers/index.coffee'

appCore =
  angular
    .module('appCore', [])
    .component('app', cpns.app)
    .controller('AppCtrl', ctrls.app)

exports = appCore
