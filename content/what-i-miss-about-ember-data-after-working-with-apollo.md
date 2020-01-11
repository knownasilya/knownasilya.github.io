---
title: >
  What I Miss About Ember Data After Working With Apollo
authors:
  - ilya
date: '2020-01-11T03:12:07.951Z'
tags:
  - ember-js
---
While I love the ability to query the backend very specifically and build up complex data with GraphQL and Apollo, I still miss a few things from the good-old JSON API and Ember Data days.

## Strict Typing and Errors Cause Unnecessary Downtime

I enjoy the typing of the GraphQL language, and think it's one of the best features, but at the same time, because of these types it's impossible to recover from mis-matched queries.
Mainly the issue happens when you change a field for a resolver on the backend, the frontend is still using the old types and during the deployment of the backend the frontend is still using the old queries. This is usually fine in REST, because the APIs are generally more fault-tolerant and will give you something, but in GraphQL you get a hard error for the query, and that part of the app just doesn't load. The solution is a more robust deployment strategy for features like that, like adding a new resolver, and then just changing the frontend to use the new resolver. This is obviously not ideal.

## I Miss The Models

In Ember Data you could store derived state on the model as computed properties, but with Apollo there are no models. Supposedly you can use client resolvers and the `@client` modifier in the query, but I haven't figured out how to do that with Ember Apollo Client. The main reason I miss this so much, is it promotes lots of repetition or weird solutions to data related to a type of data. When using a model, I'd just define a computed property, and be done with it.

## Async Relationships

It's fine that I can create big queries, but sometimes I want to optimize a UI to load smoother and only load additional data after the fact, this isn't really possible, since you just have to write another query. Sure the query is probably off the main type, but there is no way to say `await user.loadProfile()` or something of that nature. Most people write big queries to get all they need, but this just doesn't feel right for many cases.
    