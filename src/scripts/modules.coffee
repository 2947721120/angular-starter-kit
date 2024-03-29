config = require './config'
values = require './values'
core = require './core'
cpns = require './components'

angular
  .module 'app.core', [
    'core.home'
    'core.about'
  ]
  .config config.core
  .value '$routerRootComponent', values.core
  .component 'app', core

angular
  .module 'app.example', []
  .component 'starterKit', cpns.example

angular
  .module 'core.home', []
  .component 'home', template: '<span>Home Page</span>'

angular
  .module 'core.about', []
  .component 'about', template: '<span>About Page</span>'
