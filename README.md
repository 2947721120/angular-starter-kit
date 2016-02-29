# Angular Starter Kit

### Key Features
* Angular, Material and Firebase
* Bash and Atom
* Jade, Stylus and CoffeeScript
* Git, NPM, Gulp, PostStylus, Browserify and BrowserSync

### Getting Started

##### Prerequisites
You need git to clone the angular-starter-kit repository. You can get git from http://git-scm.com/.

We also use a number of node.js tools to initialize angular-starter-kit. You must have node.js and its package manager installed. You can get them from http://nodejs.org/.

##### Clone angular-starter-kit

```bash
$ git clone --depth=1 https://github.com/Shyam-Chen/angular-starter-kit.git <your-project-name>
$ cd <your-project-name>
```

##### Install Dependencies

```bash
$ npm install -g gulp rimraf pnpm
$ pnpm-install
```

##### Run the Application

```bash
$ npm start  # in development
```

### Other Commands

##### Building the Application in Production

```bash
$ npm run build
```

##### Serving the Application Files

```bash
$ npm run serve
```

##### Cleaning the Application Files

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
│   ├── images
│   │   ├── image-1.png
│   │   └── image-2.png
│   ├── scripts
│   │   ├── animations
│   │   │   ├── animation-1.coffee
│   │   │   └── animation-2.coffee
│   │   ├── components
│   │   │   ├── app.coffee
│   │   │   ├── component-1.coffee
│   │   │   └── component-2.coffee
│   │   ├── contrillers
│   │   │   ├── app.coffee
│   │   │   ├── contriller-1.coffee
│   │   │   └── contriller-2.coffee
│   │   ├── directives
│   │   │   ├── directive-1.coffee
│   │   │   └── directive-2.coffee
│   │   ├── filters
│   │   │   ├── filter-1.coffee
│   │   │   └── filter-2.coffee
│   │   ├── services
│   │   │   ├── constants.coffee
│   │   │   ├── service-1.coffee
│   │   │   ├── service-2.coffee
│   │   │   └── values.coffee
│   │   ├── config.coffee
│   │   ├── main.coffee
│   │   ├── run.coffee
│   │   └── vendor.coffee
│   ├── styles
│   │   ├── components
│   │   │   ├── app.styl
│   │   │   ├── component-1.styl
│   │   │   └── component-2.styl
│   │   ├── main.styl
│   │   └── vendor.styl
│   ├── views
│   │   ├── components
│   │   │   ├── app.jade
│   │   │   ├── component-1.jade
│   │   │   └── component-2.jade
│   │   └── main.jade
│   ├── favicon.ico
│   ├── index.jade
│   └── robots.txt
├── .editorconfig
├── .gitattributes
├── .gitignore
├── .jadelintrc
├── .stylintrc
├── LICENSE
├── README.md
├── coffeelint.json
├── gulpfile.coffee
└── package.json
```

### Deploy to Firebase Hosting
```bash
$ npm install -g firebase-tools
$ firebase init
$ firebase deploy
```
