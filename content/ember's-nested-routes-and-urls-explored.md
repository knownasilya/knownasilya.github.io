---
  title: 'Ember's Nested Routes and URLs Explored'
  # image: ''
  authors:
    - ilya
  date: '2019-12-05T22:14:07.784Z'
  tags:
  ---
  Ember's router is powerful and a bit unique, in that it has a nested structure for the routes which build up the URL a user would see in the browser.
Given it's power, it is easy to be unsure about how to structure your routes, especially in scenarios where you have parent-child UI patterns or CRUD like
resources.

One of the patterns that I've learned is not using extra nesting when want to build out a multi-part URL structure, like `/users/1234`, which seems like it should be nested, but generally
a single level is enough. I'd structure it like this:

```js
this.route('user', { path: '/users/:userId' });
```

This puts your user "view" route at the `app/pods/user` directory (my examples will use PODS, since they are sane for routes).
The following is generally not the way I'd write my router map, even though it creates the same URL pattern.

```js
this.route('users', function () {
this.route('user', { path: ':userId' });
});
```

Unless you are showing the list of users at the same time as the selected user, which I think is a rare pattern, this is probably not the way your route should work.
The reason I wouldn't do this is because it adds unnecessary mental overhead between the list and a selected item from the list.
With my preferred pattern, if I wanted a list route, it would be a sibling to the resources.

```js
this.route('users');
this.route('user', { path: '/users/:userId' });
```

And the folder structure is sane as well:

```
app
pods
  users
  user
```

Since the two usually don't share any common UI, the common UI will probably be one route up or at the `application` route.
Well that's it! Let me know if this is how you do it or if you completely disagree.