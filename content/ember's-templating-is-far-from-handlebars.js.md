---
title: 'Ember''s Templating Is Far From Handlebars.js'
# image: ''
authors:
  - ilya
date: '2020-01-08T21:38:06.721Z'
tags:
  - ember-js
---
I've heard this so many times on Twitter, that someone doesn't want to try out Ember because of a bad experience with Handlebars.js. Let me tell you something, the handlebars that is in Ember is far divergent from the normal Handlebars.js. Both projects have their uses, but don't judge one by the other.

For instance, take this example code on the Handlebars.js website:

```hbs
<ul class="people_list">
{{#each people}}
  <li>{{this}}</li>
{{/each}}
</ul>
```

In Ember this would be written as

```hbs
<ul class="people_list">
{{#each this.people as |person|}}
  <li>{{person}}</li>
{{/each}}
</ul>
```

It's clear where the data comes from, and you can use the top-level `{{this.}}` to access the controller or the component that powers the template.
We can also see where the original list comes from, in Ember it could be directly on the class if via `this.people`, or as an argument passed to the component, so from outside, if `@people`.

Another example of Handlebars.js syntax:

```hbs
{{#with person}}
{{firstname}} {{lastname}}
{{/with}}
```

In Ember this is impossible, because it becomes ambiguous where the data comes from, especially since `this` isn't required for passed in data.
Partials are also not available, just define a template-only component which takes explicit arguments and doesn't have access to `this`.
Changing context is also not possible in Ember, because the context is explicit with `as |item|` syntax.

```hbs
{{#each people}}
  {{../prefix}} {{firstname}} 
{{/each}}
```

So changing context is just not needed.
Handlebars.js has some things that are useful that Ember doesn't provide, because the priorities of the two projects are different.
Ember and Handlebars.js are both great projects, but have taken different directions and should be evaluated on their own merit, not on past experiences.
Maybe give Ember a try if you resisted because of Handlebars.js before; it has changed quite a bit from the old days.
