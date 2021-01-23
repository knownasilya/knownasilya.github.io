---
title: >
  Notes For Using TypeScript With EmberJS
authors:
  - ilya
date: '2021-01-23T21:55:13.787Z'
tags: 
  - ember
---
I've been using TypeScript for a bit with Ember, and I keep having to look up the same things for new projects, so this post is just those things that I keep looking for when using TypeScript with EmberJS.


## Services

The most popular service is the `RouterService`, but it's kind of hard to find how to type it, so here's that:

```ts
import { inject as service, Registry as Services } from '@ember/service';

// ...
@service router!: Services['router'];
```

    