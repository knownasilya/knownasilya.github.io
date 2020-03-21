---
title: >
  Ember With GraphQL

authors:
  - ilya
date: '2020-03-21T19:38:59.050Z'
tags: 
  - ember.js
---
Most Ember developers are familiar with Ember Data and JSON:API, which means that GraphQL and Apollo are not nearly as wide spread in the Ember community. This past year I had the chance to work on an app with GraphQL and Apollo in an Ember app, and I wanted to share some of the things I learned.

By the way I'll be posting from the perspective of working with GraphQL on the client mainly, and using [ember-apollo-client](https://github.com/ember-graphql/ember-apollo-client).

## What I Miss

First of all, I miss having a model class for each entity as I'd have with Ember Data before hand.
    
    