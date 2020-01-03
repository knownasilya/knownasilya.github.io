---
title: 'One Reason Why You Should Be Using URLs'
# image: ''
authors:
  - ilya
date: '2020-01-03T03:40:30.290Z'
tags:
  - ember-js
---
One of the reasons that [Ember.js](https://emberjs.com) is so powerful of a framework is because of its Router, and ultimately its bet on the web and the fact that the URL is important.
With Ember's router, the URL becomes a nested state-machine for your app, which is one of the reasons you should be using URLs in your app whenever you can. Let me explain a bit.

I'm just learning about state-machines, and from what I can tell one of the basics is that in the most simplest of state-machines, you represent a single state that can happen at one time. So for example, `fetching` or `errored` for an AJAX request, you cannot be in both states. Ember.js gives you these two for free in the router, the [`loading`](https://guides.emberjs.com/release/routing/loading-and-error-substates/#toc_loading-substates) and [`errored`](https://guides.emberjs.com/release/routing/loading-and-error-substates/#toc_error-substates) routes (or substates as the guides call them).

The way that Ember has routes and UI setup promotes these exclusive states in the UI, because nested routes map to nested UI. So if you have a wizard UI for an onboarding kind of experience, you can model each step of that onboarding flow as a nested route:

```js
this.route('onboarding', function () {
  // 'index' is predefined and is step 0
  this.route('step1');
  this.route('step2');
  this.route('step3');
  // 'loading' is predefined
  // 'errored' is predefined
});
```

As you can see, if you visit `onboarding` you will land on the `index` route, which can be step 0 or can redirect you to the correct step. This is the initial state of our onboarding state-machine. If the `index` route loads something, it will transition to `loading` before rendering. So you can only be in one of the substates of the `onboarding` route.

You can now transition from `index` to another sibling route using `transitionTo` on the [`router` service](https://api.emberjs.com/ember/release/classes/RouterService) or on routes (`transitionToRoute` in a controller). Something like `this.router.transitionTo('onboarding.step1')`. Once again `loading` and maybe `errored` will be entered during/after the `model` loading phase. Using this structure to define nested UI, since the child routes are nested in whatever UI is defined in the `onboarding` template, allows you to define exclusive states and prevents subtle bugs that might creep up if you decided to handle these steps using `{{#if (eq this.step 'step1')}}` syntax, especially if you have multiple if statements for the same state for different pieces of UI, it makes it hard to reason about and allows your app to be in unknown states you didn't intent.

So in closing, the URL is important, because it drives nested UI in a state-machine fashion which keeps your app easier to understand, read, and prevents bugs in many cases.

If you want to read more about routing, check out my post about [Using Nested Routes In Ember](https://ilyaradchenko.com/using-nested-routes-in-ember).
