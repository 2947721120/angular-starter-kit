cpn = require './components/index.coffee'
ctrl = require './controllers/index.coffee'

exports =
  angular
    .module('app.core', [])
    .component('app', cpn.app)
    .controller('AppCtrl', ctrl.app)
