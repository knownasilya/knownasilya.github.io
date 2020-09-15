---
title: >
  Sharing A Parent Model Across Route Boundaries
authors:
  - ilya
date: '2020-09-15T21:04:38.688Z'
tags: 
---
Just last week [Alex LaFroscia](https://mobile.twitter.com/alexlafroscia) released a new addon called [Ember Context](https://github.com/alexlafroscia/ember-context) and I wanted to share some patterns that I've used in the past that this addon changes. 

## The Problemdd

Sometimes you have a UI where at a certain level you have multiple nested routes and they deal with one parent item. For example if you had a
blog management system that supported multiple blogs, you could have a route like `dashboard.blog.post.edit` and the `Blog` model is found at the `dashboard.blog` route. So at this point you want to use that same blog model in the other routes. Historically there has never been a great way to do this, you might think put it on a service, but then you have to register and cleanup that service since services are global. Along with that inconvenience it's also not clear where the service gets its data, it seems a bit magic.

## The Past

In the past I've tackled this problem with the `modelFor` route method, something like:

```js
import Route from '@ember/routing/route';
import { inject as service } from '@ember/service';

export default class PostEditRoute extends Route {
  @service store;

  async model({ postId }) {
    let blog = this.modelFor('dashboard.blog');
    let post = await this.store.findRecord('post', postId)
    return {
      blog,
      post
    };
  }
}
```

Now I can access the blog in my template via `{{@model.blog}}`, and it all works. The issue here is that `modelFor` will return whatever data you returned in the `model` hook of the `dashboard.blog` route, and that could change to an object of items, like `{ config, blog }` and now you need to visit every `modelFor` and change the assumption there. In cases where a route doesn't have any other model data you need to fetch, you still have to add a route file and do this whole dance.

## The Present

With the new `ember-context` addon, we get to change this to something with less boilerplate, and a bit clearer about where the data is coming from.
With this addon we'd define the following in our `dashboard.blog` template:

```hbs
<ContextProvider @key='blog' @value={{@model}}>
  {{outlet}}
</ContextProvider>
```

Now in our `dashboard.blog.post.edit` template we can use this blog model by using a helper: `{{consume-context 'blog'}}`:

```hbs
{{#let (consume-context 'blog') as |blog|}}
  {{! work with blog here }}
{{/let}}
```

And if we wanted to access it in a controller or a component, it would be as simple as injecting the value:

```js
import Component from '@glimmer/component';
import { inject as context } from '@alexlafroscia/ember-context';

export default class PostEditor extends Component {
  @context('blog') blog;
}
```

This gets even more powerful when you create a custom class and use `@tracked` and `@action` which can be consumed at the top level, but nested routes could also affect the state of that class. There you have it! Have you found similar patterns that ember-context improves? Let me know on Twitter.   
    