---
    title: 'When Components Aren't Enough'
    # image: ''
    authors:
      - ilya
    date: '2020-01-08T04:17:41.451Z'
    tags:
      - ember-js
    ---
    Sometimes components are too high-level, and you need to get at a specific DOM element, either for `scrollTo` or `focus`, in these situations Ember provides a lower-level primitive called an element-modifier. To get started with element modifiers you can check out existing modifiers at [EmberObserver](https://emberobserver.com/categories/modifiers) or create your own using the `ember-modifier` [library](https://github.com/ember-modifier/ember-modifier).

## Some Examples

```hbs
<form {{autofocus}}>
<input />
</form>
```

Which will focus the first non-disabled input that it finds (from [ember-autofocus-modifier](https://github.com/qonto/ember-autofocus-modifier)).

```hbs
<div {{scroll-to}}>
</div>
```

Which will scroll to the element once it's in the DOM, and is super easy to implement:

```js
// /app/modifiers/scroll-to.js
import { modifier } from 'ember-modifier';

export default modifier((element) => {
element.scrollIntoView({
  behavior: 'smooth'
});
});
```

There is also the `ref` modifier from [ember-ref-modifier](https://www.npmjs.com/package/ember-ref-modifier) which gives you access to the element:

```hbs
<button {{ref this "button"}} data-name="foo">
Click me baby, one more time!
</button>

{{this.button.dataset.name}} >> "foo"
```

Along with `{{on-click-outside}}` from [ember-click-outside](https://github.com/zeppelin/ember-click-outside).

```hbs
<div {{on-click-outside @close}}>
Your HTML...
</div>
```

## Why Are Element Modifiers Useful?

Mainly because you can do things like:

```hbs
{{#if this.isEditorVisible}}
<div
  class="wysiwig-editor"
  {{did-insert this.setupEditor}}
  {{will-destroy this.teardownEditor}}
>
</div>
{{/if}}
```

Which handles the setup and teardown of the element, so if `isEditorVisible` turns `false` the editor initialized on our element will be properly cleaned up. This is important because the new Glimmer Components allow multiple top-level elements without any kind of fragment syntax.

> Note: I'm using [ember-render-modifiers](https://github.com/emberjs/ember-render-modifiers) in the above example. But you could create a modifier to encapsulate both the setup and teardown so reusability is easier.