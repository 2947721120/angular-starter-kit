appCpn = require './components/app.coffee'
AppCtrl = require './controllers/app.coffee'

angular
  .module('app', ['ngMaterial', 'firebase'])
  .component('app', appCpn)
  .controller('AppCtrl', AppCtrl)
