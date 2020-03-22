---
title: >
  Ember With GraphQL

authors:
  - ilya
date: '2020-03-22T20:52:20.092Z'
tags: 
  - ember-js
---
Most Ember developers are familiar with Ember Data and JSON:API, which means that GraphQL and Apollo are not nearly as wide spread in the Ember community. This past year I had the chance to work on an app with GraphQL and Apollo in an Ember app, and I wanted to share some of the things I learned.

By the way I'll be posting from the perspective of working with GraphQL on the client mainly, and using [ember-apollo-client](https://github.com/ember-graphql/ember-apollo-client).

## What I Missed Most

First of all, I miss having a model class for each entity as I'd have with Ember Data before hand. This becomes obvious once you have a single entity type that you use all over your app, and in my case this was the repeated use of `{{this.user.firstName}} {{this.user.lastName}}` instead of `{{this.user.name}}`. This is not as fun to work with, and you end up repeating yourself many times for a value that should be derived.

Fortunately there is a solution of sorts; it's called client resolvers. I didn't end up using them, since I learned about them a bit late, but they go something like this:

```js
export default class OverriddenApolloService extends ApolloService {
  clientOptions() {
    return {
      ...super.clientOptions(...arguments),
      resolvers: {
        User: {
          name: (parent, args, obj) => {
            return parent.firstName + ' ' + parent.lastName;
          }
        }
      }
    };
  }
}
```

And can be queried using the `@client` directive.

```graphql
query CurrentUser {
  user {
    id
    name @client
  }
}
```

This is probably sufficient for most of what I miss, but if you need more, like actions based on entities, you could define a custom class with `@tracked` properties and `@action` methods to handle that scenario. I think this could be done automatically using a map of types to classes and a custom Apollo Link "middleware".

One minor thing I miss is being able to query without much ceremony. Since there are no models, you don't have `await model.save()`, instead you need to import a mutation, and pass the update RPC style.

```js
import Component from '@glimmer/component';
import { task } from 'ember-concurrency-decorators';
import { queryManager } from 'ember-apollo-client';
import updateProfile from './update-profile.graphql';

export default class PublishProfileComponent extends Component {
  @queryManager apollo;

  @task
  publish = function*() {
    let slug = this.args.profile.slug;

    yield this.apollo.mutate({
      mutation: updateProfile,
      variables: {
        input: {
          slug,
          publishedAt: new Date()
        }
      }
    }, 'updateProfile');
}
```

Which could be solved by having a model with common tasks on it, but that is more boiler plate on top of course. Also in the example above you could have `saveProfile`, `publishProfile`, etc. there are no conventions/enforcement on how you should structure your mutations and queries. I miss the conventions of JSON:API.
    
## 
    
    
    
    