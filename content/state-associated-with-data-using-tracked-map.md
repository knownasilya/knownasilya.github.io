---
title: >
  State Associated With Data Using Tracked Map
authors:
  - ilya
date: '2020-11-01T20:32:23.035Z'
tags: 
---
Historically I've used Ember Data which gives you a model instance which you can set arbitrary values on using the `set` method. That as I've been working with more POJO data (via ember-apollo-client) I started using a pattern which fits nicer with the new Octane paradigm.

## tracked-built-ins

[Chris Garret](https://github.com/pzuraq) has an awesome little library that implements tracked versions of JavaScript's built-in classes called [tracked-built-ins](https://github.com/pzuraq/tracked-built-ins). For this pattern I'm going to use `TrackedMap` which has the same API as `Map`, but is tracked (read reactive) in the context of Ember Octane.

```js
import Component from '@glimmer/component';
import { TrackedMap } from 'tracked-built-ins';

export default class Tasks extends Component {
  stateMap = new TrackedMap();
}
```

We have the tracked state set up, but how do we associate the data now?

## Setup

With Ember Octane you get access to the `args` (values passed to the component) on component instantiation, so we can setup our `stateMap` in the constructor.

```js
import Component from '@glimmer/component';
import { TrackedMap } from 'tracked-built-ins';

export default class Tasks extends Component {
  stateMap = new TrackedMap();

  constructor(owner, args) {
    super(owner, args);
    this.setupState();
  }

  setupState() {
    this.args.data.forEach(item => this.stateMap.set(item, { selected: false }));
  }
}
```

The above code takes the data, which might look something like `[{ name: 'Item 1', description: 'Something here' }, { ... }]` and associates each item to a state object, in this case it's `{ selected: false }`, which is the initial state.

## Show Me The State

Normally you iterate over your state using the built-in `each` template helper, but since we are iterating over a map, we use the `each-in` helper instead:

```handlebars
{{#each-in this.stateMap as |item state|}}
    <li class={{unless state.selected 'bg-gray-100'}}>
        <input
          type='checkbox'
          checked={{state.selected}}
          {{on 'change' (fn this.toggleSelected item)}}
        />
  </li>
{{/each-in}}
```

You'll notice that `each-in` yields the key and the value from our map, and in this case the key is our data and the value our state, so we label it by what it is.
To set the value we send the `item` to our action called `toggleSelected` which we'll declare next.

## Changing State

We cannot use the `mut` or the `set` (awesome little helper provided by https://github.com/pzuraq/ember-simple-set-helper, did I mention that Chris has so many great addons?) because the state itself is not reactive, but we can set a new state value for our key (POJO state).

```js
@action
toggleSelected(item) {
  let { selected } = this.stateMap.get(item);

  this.stateMap.set(item, { selected: !selected });
}
```

We get the original value, which we could have passed to our action but I decided to show the process for the sake of this post, and we set a new state value for our key.
This will cause an update to our state and the new value will update in the template.

## Closing

I've found this pattern to be nice because it keeps the two things separated. It reminds me of the https://github.com/stefanpenner/ember-state-services addon, which has some nice helpers for accessing one item but isn't great when managing a collection. The method using `TrackedMap` is following new Octane paradigms for state, and I've been enjoying using it because it's less magic. I think it could be improved by a custom `set-map` helper (or some other name) so you don't have to define an action to toggle a property. What other new state patterns have you started using in your Octane apps?

    