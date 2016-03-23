app = require './app.coffee'

angular
  .module 'app.core', []
  .config app.config
  .value app.inject, app.tag
  .component app.tag, app.component

angular
  .module 'app.todo-app'
  .component 'todoApp', cpns
