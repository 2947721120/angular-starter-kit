starterCpn = require './components/starter-app.coffee'
StarterCtrl = require './controllers/starter-app.coffee'

angular
  .module('starterApp', ['ngMaterial', 'firebase'])
  .component('starterApp', starterCpn)
  .controller('StarterCtrl', [StarterCtrl])
