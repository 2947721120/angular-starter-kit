class Core
  @templateUrl: '../views/main.html'
  @$routeConfig: [
    path: '/'
    name: 'Home'
    component: 'home'
    useAsDefault: true
  ,
    path: '/about'
    name: 'About'
    component: 'about'
  ]

module.exports = Core
