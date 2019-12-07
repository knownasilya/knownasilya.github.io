---
title: 'Using Nested Routes In Ember.js'
# image: ''
authors:
  - ilya
date: '2019-12-06T14:19:07.652Z'
tags:
  - ember-js
---
In my [last post](https://ilyaradchenko.com/ember's-nested-routes-and-urls-explored) I mentioned how nested routes don't make sense sometimes, which means that they do have their uses at other times, which I want to cover here. I think the example I used in my last post wasn't clear enough, because what I meant to communicate is that if you want a nested URL structure, it doesn't always mean you need nested routes. I'd like to cover a scenarios that works really well with nested routes.

## When You Have Many Resources

The first is an app that is heavily CRUD (create read update delete) focused and has more than ~3 resources. In these scenarios it helps to nest, because you end up with a clean folder structure, e.g.

- `app`
  - `pods`
    - `users`
    - `groups`
    - `articles`
    - `categories`

Which I'd model like this in the router map:

```js
this.route('categories', function () {
  // 'index' route is implicit and is for listing/filtering users
  this.route('create');
  this.route('category', { path: '/:categoryId' }, function () {
    // 'index' route is implicit and is for viewing the user
    this.route('edit');
  });
});
```

This pattern works really well because all sub-routes have access to the `users` route, and usually in ambitious CRUD apps you need to load some related dynamic data, like values for dropdowns that can be loaded at the top route and used with `this.modelFor('users')` in the child routes. This is usually useful in the `users.index` for filtering using a dropdown and in `users.create` and `users.user.edit` for selecting the value to create/update.

At the `users.user` route, you'd load the actual model for viewing or editing, and the child routes would consume that via `modelFor`.

This would create the following urls:

- /categories
- /categories/create
- /categories/1234
- /categories/1234/edit

## What About... ?

The above works really well, but the idea is that it's about organizing items into related groups that are talking about one thing. So scenarios where you have public routes and authenticated routes will also fall in this category. Wizards that have steps that should be url accessible also should be nested. Routes are kind of like state machines, where sibling routes are the states that the parent route can be in, and the `index` is the initial state.

If your UI is nested and needs to be URL accessible at the different levels of nesting, use nested routes.





