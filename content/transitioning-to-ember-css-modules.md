---
title: 'Transitioning to ember-css-modules'
authors:
  - ilya
date: '2019-10-11T18:24:34.367Z'
tags:
  - ember-js
---
At Crash we use Ember and on the CSS front we utilze Sass and ember-component-css, which have worked very well for us.
One of the benefits is being able to place your styles with your components and knowing that (mostly) styles won't clash with each other. With the new Octane edition being almost upon us, we realized that component-css was a major blocker for us in that transition so we looked into alternatives and Dave even wrote an experimental [styles import addon](https://github.com/davewasmer/ember-template-styles-import) (very experimental, which is why we aren't using it yet). We landed on transitioning to ember-css-modules, which takes a slightly different approach and fits with the new Glimmer Components paradigm. This post is about that transition.

