---
title: >
  Ember With GraphQL

authors:
  - ilya
date: '2020-03-22T19:21:19.037Z'
tags: 
  - ember-js
---
Most Ember developers are familiar with Ember Data and JSON:API, which means that GraphQL and Apollo are not nearly as wide spread in the Ember community. This past year I had the chance to work on an app with GraphQL and Apollo in an Ember app, and I wanted to share some of the things I learned.

By the way I'll be posting from the perspective of working with GraphQL on the client mainly, and using [ember-apollo-client](https://github.com/ember-graphql/ember-apollo-client).

## What I Missed Most

First of all, I miss having a model class for each entity as I'd have with Ember Data before hand. This becomes obvious once you have a single entity type that you use all over your app, and in my case this was the repeated use of `{{this.user.firstName}} {{this.user.lastName}}` instead of `{{this.user.name}}`. This is not as fun to work with, and you end up repeating yourself manytimes for a value that should be derived.

Fortunately there is a solution of sorts; it's called client resolvers. I didn't end up using them, since I learned about them a bit late, but they go something like this:

```js
export default class OverriddenApolloService extends ApolloService {
  clientOptions() {
    return {
      link: this.link(),
      cache: this.cache(),
      resolvers: {
        User: {
          name: (parent, args, obj) => {
            return parent.firstName + ' ' + parent.lastName;
          }
        }
      }
    };
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
    
    

    
    