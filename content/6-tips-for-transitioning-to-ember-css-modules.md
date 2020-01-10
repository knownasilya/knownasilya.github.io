---
title: >
  6 Tips For Transitioning To Ember CSS Modules

authors:
  - ilya
date: '2020-01-10T18:44:32.141Z'
tags:
  - ember-js
---
A few tips as you transition your SASS, LESS, PostCSS or plain CSS to using CSS Modules, and specifically for Ember (not sure what the differences are).

## Use `local-class` Instead of `class`

This is Ember only, and is just a requirement at the moment. This attribute is used to convert the generated classes and insert them into your template.
If you pierce component styles (see next section), you should leave your old `class` until you migrate away.

## Add Classes to Components Used In Templates

CSS Modules don't let you style inside of components you use in your template, so you need to add a class.

```hbs
<User local-class="user" />
```

Is required to target that component, otherwise you'd have to use `:global`, which should be used sparingly. If you need to expose deeper classes, then it's recommended to add arguments, like `@roleClass` and using the helper:

```hbs
<User local-class="user" @roleClass={{local-class "role"}} />
```

## Use `:global` Sparingly

It's alright to use `:global` if you do lots of component piercing and are migrating, but I recommend setting up stylelint and using the [selector-pseudo-class-no-unknown](https://stylelint.io/user-guide/rules/selector-pseudo-class-no-unknown) rule, so you can catch missed globals when you go to refactor:

```js
module.exports = {
  rules: {
   'selector-pseudo-class-no-unknown': [
      true,
      {
        ignorePseudoClasses: ['global']
      }
    ],
  }
};
```

## Wrap IDs in :global

IDs get transformed, not sure why, so use `:global(#my-id) {}`.

## Refactor Away From Component CSS Parent Selector

The following is not supported to target the default element (in classic components, or the route namespace):

```scss
& {
  display: flex;
}
```

You need to wrap that template in a new class, like `.page`. This is especially true if you are transitioning to Glimmer components.

## Don't Use Element Selectors In The Top-Level

You must include selectors like `h1, a, p` inside of a class in your style file, otherwise those will apply to your whole app.
This is because the style file doesn't get its own namespace, only the classes (and IDs) inside the file are renamed.


    
    