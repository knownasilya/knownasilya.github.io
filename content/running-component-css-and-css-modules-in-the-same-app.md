---
title: 'Running Component CSS and CSS Modules in the Same App'
# image: ''
authors:
  - ilya
date: '2020-01-03T23:02:29.750Z'
tags:
  - ember-js
---
With Ember Octane [now released](https://blog.emberjs.com/2019/12/20/octane-is-here.html) it's a good time to start looking at upgrading that app. One of the issues we faced at Crash with upgrading is that Ember Component CSS doesn't support Glimmer components and even breaks on classic components because of some changes to the framework. So we decided to run Component CSS alongside CSS Modules, because we have a good amount of CSS (as do most apps). I won't go into why we decided to use CSS Modules (a post coming in the future on this topic), but I will show you how to get them running together.

First, install both dependencies. Second you need to tell Component CSS to not run CSS Module files, so add this to your `config/environment.js`:

```
ENV['ember-component-css'] = {
  // ignore css-modules styles
  excludeFromManifest: ['**/*.module.scss']
};
```

We decided to use `styles.module.scss` as the name for CSS Modules, and Component CSS uses `styles.scss`. To get CSS Modules to use this format, we need another config, this time in `ember-cli-build.js`

```
const nested = require('postcss-nested');
// ...
cssModules: {
  extension: 'module.scss',
  intermediateOutputPath: 'app/styles/_modules.scss',
  plugins: {
    before: [nested]
  }
},
```

> Notice that you need to install `postcss-nested` to allow for nested syntax and nested `:global` selector.

Now in `app/styles/app.scss` you need to add the modules import after the pods import:

```scss
@import 'pod-styles.scss';
@import 'modules';
```

Don't forget to also install `ember-css-modules-sass` to support SASS. And that should be it, let me know if you run into any issues on Twitter.
