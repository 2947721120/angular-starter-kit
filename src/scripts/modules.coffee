cpn = require './components/index.coffee'
ctrl = require './controllers/index.coffee'

appCore =
  angular
    .module('appCore', [])
    .component('app', cpn.app)
    .controller('AppCtrl', ctrl.app)

exports = appCore
