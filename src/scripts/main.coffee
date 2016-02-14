starterCpn = require './components/starter-app.coffee'
starterCtrl = require './controllers/starter-app.coffee'

angular
  .module('starterApp', ['ngMaterial', 'firebase'])
  .component('starterApp', starterCpn)
  .controller('StarterCtrl', [starterCtrl])
