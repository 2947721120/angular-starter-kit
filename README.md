# Angular Starter Kit

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
├── README.md
├── LICENSE
├── src
│   ├── scripts
│   │   ├── components
│   │   │   ├── component-1.coffee
│   │   │   ├── component-2.coffee
│   │   │   └── starter-app.coffee
│   │   ├── services
│   │   │   ├── service-1.coffee
│   │   │   └── service-2.coffee
│   │   ├── contrillers
│   │   │   ├── contriller-1.coffee
│   │   │   ├── contriller-2.coffee
│   │   │   └── starter-app.coffee
│   │   ├── filters
│   │   │   ├── filter-1.coffee
│   │   │   └── filter-2.coffee
│   │   ├── main.coffee
│   │   └── vendor.coffee
│   ├── styles
│   │   ├── components
│   │   │   ├── component-1.styl
│   │   │   ├── component-2.styl
│   │   │   └── starter-app.styl
│   │   ├── main.styl
│   │   └── vendor.styl
│   ├── views
│   │   ├── components
│   │   │   ├── component-1.jade
│   │   │   ├── component-2.jade
│   │   │   └── starter-app.jade
│   │   └── main.jade
│   ├── images
│   │   └── angular.png
│   ├── favicon.ico
│   ├── index.jade
│   └── robots.txt
├── gulpfile.coffee
└── package.json
```

### Deploy to Firebase Hosting
```bash
$ npm install -g firebase-tools
$ firebase init
$ firebase deploy
```
