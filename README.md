# Angular Starter Kit

### Project Status
* [![Build Status](https://travis-ci.org/Shyam-Chen/angular-starter-kit.svg?branch=master)](https://travis-ci.org/Shyam-Chen/angular-starter-kit)
* [![Quality Status](https://img.shields.io/badge/quality-A-brightgreen.svg)](https://www.codacy.com/app/shyamchen1994/angular-starter-kit/dashboard)
* [![Coverage Status](https://coveralls.io/repos/github/Shyam-Chen/angular-starter-kit/badge.svg?branch=master)](https://coveralls.io/github/Shyam-Chen/angular-starter-kit?branch=master)
* [![Browser Status](https://img.shields.io/badge/browser-passing-brightgreen.svg)](https://saucelabs.com/u/Shyam-Chen)
* [![Dependency Status](https://david-dm.org/Shyam-Chen/angular-starter-kit.svg)](https://david-dm.org/Shyam-Chen/angular-starter-kit)
* [![devDependency Status](https://david-dm.org/Shyam-Chen/angular-starter-kit/dev-status.svg)](https://david-dm.org/Shyam-Chen/angular-starter-kit#info=devDependencies)

### Key Features
* Angular, Material and Firebase
* Bash, Atom, Git and NPM
* Jade, Stylus and CoffeeScript
* Gulp, PostStylus, Browserify and BrowserSync  
* Jadelint, Stylint and CoffeeLint
* Jasmine, Karma, Istanbul and Protractor
* Travis CI, Codacy, Coveralls and Sauce Labs

### Getting Started
##### Clone angular-starter-kit
```bash
$ git clone --depth=1 https://github.com/Shyam-Chen/angular-starter-kit.git <your-project-name>
$ cd <your-project-name>
```

##### Install Dependencies
```bash
$ npm install
```

##### Run the Application
```bash
$ npm start
```

##### Test the Application
```bash
$ npm test

```

### Other Commands
##### Build the Application
```bash
$ npm run build-dev
$ npm run build-dev-watch

$ npm run build-prod
```

##### Test the Application
```bash
$ npm run build-test
$ npm run build-test-watch

$ npm run build-e2e
```

##### Clean the Application
```bash
$ npm run clean
```

##### Reinstall Dependencies
```bash
$ npm run reinstall
```

### Directory Structure
```
.
├── src
│   ├── fonts
│   │   ├── font-1.woff
│   │   └── font-2.woff
│   ├── images
│   │   ├── image-1.png
│   │   └── image-2.png
│   ├── scripts
│   │   ├── animations
│   │   │   ├── animation-1.coffee
│   │   │   ├── animation-2.coffee
│   │   │   └── index.coffee
│   │   ├── components
│   │   │   ├── component-1.coffee
│   │   │   ├── component-2.coffee
│   │   │   └── index.coffee
│   │   ├── contrillers
│   │   │   ├── contriller-1.coffee
│   │   │   ├── contriller-2.coffee
│   │   │   └── index.coffee
│   │   ├── directives
│   │   │   ├── directive-1.coffee
│   │   │   ├── directive-2.coffee
│   │   │   └── index.coffee
│   │   ├── filters
│   │   │   ├── filter-1.coffee
│   │   │   ├── filter-2.coffee
│   │   │   └── index.coffee
│   │   ├── services
│   │   │   ├── index.coffee
│   │   │   ├── service-1.coffee
│   │   │   └── service-2.coffee
│   │   ├── config.coffee
│   │   ├── constants.coffee
│   │   ├── core.coffee
│   │   ├── main.coffee
│   │   ├── modules.coffee
│   │   ├── run.coffee
│   │   ├── values.coffee
│   │   └── vendor.coffee
│   ├── styles
│   │   ├── components
│   │   │   ├── component-1.styl
│   │   │   └── component-2.styl
│   │   ├── layout.styl
│   │   ├── main.styl
│   │   ├── mixins.styl
│   │   ├── structure.styl
│   │   ├── typography.styl
│   │   ├── variables.styl
│   │   └── vendor.styl
│   ├── views
│   │   ├── components
│   │   │   ├── component-1.jade
│   │   │   └── component-2.jade
│   │   └── main.jade
│   ├── favicon.ico
│   ├── index.jade
│   └── robots.txt
├── test
│   ├── e2e
│   │   ├── core.coffee
│   │   ├── e2e-1.coffee
│   │   └── e2e-2.coffee
│   └── unit
│       ├── animations
│       │   ├── unit-1.coffee
│       │   └── unit-2.coffee
│       ├── components
│       │   ├── unit-1.coffee
│       │   └── unit-2.coffee
│       ├── controllers
│       │   ├── unit-1.coffee
│       │   └── unit-2.coffee
│       ├── directives
│       │   ├── unit-1.coffee
│       │   └── unit-2.coffee
│       ├── filters
│       │   ├── unit-1.coffee
│       │   └── unit-2.coffee
│       ├── services
│       │   ├── unit-1.coffee
│       │   └── unit-2.coffee
│       └── core.coffee
├── .editorconfig
├── .gitattributes
├── .gitignore
├── .jadelintrc
├── .stylintrc
├── .travis.yml
├── LICENSE
├── README.md
├── coffeelint.json
├── gulpfile.coffee
├── karma.conf.coffee
├── package.json
└── protractor.conf.coffee
```

### Deploy to Firebase Hosting
```bash
$ npm install -g firebase-tools
$ firebase init
$ firebase deploy
```

### Cheat Sheet
[AngularCoffee: Angular and CoffeeScript](https://github.com/Shyam-Chen/AngularCoffee)
