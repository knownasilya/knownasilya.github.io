---
  title: 'Ember Components At Their Simplest'
  # image: ''
  authors:
    - ilya
  date: '2020-01-06T04:24:40.856Z'
  tags:
    - ember-js
  ---
  [Ember Octane](https://blog.emberjs.com/2019/12/20/octane-is-here.html) gives us template-only components by default, which basically means you have a zero-boilerplate
way to create a component. This component is 100% declarative and has the same characteristics as a pure function.

An example:

```hbs
<div class="alert" aria-live="polite" ...attributes>
{{#if @message}}
  <div class="alert-content">
    {{@message}}
  </div>
{{/if}}
</div>
```

Which can be used like so: `<Alert id="octane-alert" @message="Ember Octane has been released!" />`.
The `@message` is immutable and identified by the same symbol inside and outside. While `id` is passed down to the element that has `...attributes` set.
Every time you render this component with the same attributes and arguments (ones that start with the `@`, like `@message`), you will get the same result.

Notice how there is no boilerplate to setup the component, all you need is the file, and the contents are the contents you expect your component to create in the DOM.

Check out the awesome [guides](https://guides.emberjs.com/release/components/) on getting started with components in Ember.