---
title: >
  Ember With GraphQL

authors:
  - ilya
date: '2020-03-26T21:39:40.003Z'
tags: 
  - ember-js
---
Most Ember developers are familiar with Ember Data and JSON:API, which means that GraphQL and Apollo are not nearly as wide spread in the Ember community. This past year I had the chance to work on an app with GraphQL and Apollo in an Ember app, and I wanted to share some of the things I learned.

By the way I'll be posting from the perspective of working with GraphQL on the client mainly, and using [ember-apollo-client](https://github.com/ember-graphql/ember-apollo-client).

## What It Looks Like

You can use Apollo by importing .graphql file with a mutation or a query, which gets used via the `queryManager`.

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
}
```

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
Which could be solved by having a model with common tasks on it, but that is more boilerplate on top of course. Also in the example in the "What It Looks Like" section, you could have `saveProfile`, `publishProfile`, etc. there are no conventions/enforcement on how you should structure your mutations and queries. I miss the conventions of JSON:API.
    
## What Was Gained

The RPC nature of GraphQL gives you the power to create any kind of query or mutation, which is much harder with Ember Data. In the past I've used [ember-data-model-fragments](https://github.com/lytics/ember-data-model-fragments) and [ember-api-actions](https://github.com/mike-north/ember-api-actions) addons to get the nesting and arbitrary endpoints. Since relationships are defined so easily, it also lowers the cognitive overhead necessary when requesting new data in you app. Plus you get the added benefit of defining less requests throughout, which is some what of a mental shift, because normally you don't group all the data into one request for a single "page".

With the nature of GraphQL having a schema, it also allows you to have a sort of typed contract between your frontend and backend. This also comes into play when writing acceptance tests without a backend. We did this by using Mirage, and writing some glue code to sync the schema to the defined test resolvers (the things that return the data or perform a mutation). If we use a query/mutation in our tests, but haven't defined a corresponding test resolver, we get a failing test.
    
    
    
    
    