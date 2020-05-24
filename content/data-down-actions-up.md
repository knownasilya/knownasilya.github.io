---
title: "Data Down, Actions Up"
# image: ''
authors:
  - ilya
date: "2015-04-20T16:34:16.000Z"
tags:
  - ember-js
  - components
---

I hear many people asking how they can compose components, and since the Ember
Guides [http://guides.emberjs.com/] don't help us in that respect, I wrote my
own guide as a PR [https://github.com/emberjs/guides/pull/66] to the guides. I
figured that I might as well get this out to the public while I wait on it
getting merged. This will allow us to improve the guide, so feel free to leave
comments/suggestions in the PR (inline, etc).

---

Components really shine when you use them to their full potential, which is when
you compose them.
Take for example the <ul> element, and the fact that only <li> elements are
appropriate as children.
If we want the same type of behavior, then we have to compose our components.

Just like we compose regular HTML elements, we can do the same with components.

```handlebars
{{#user-list users=model sortBy='name' as |user|}}
  {{user-card user=user}}
{{/user-list}}
```

Component Blocks
Components can be used in two forms, just like regular HTML elements.

Inline Form

```handlebars
{{user-list users=model}}
```

Block Form

```handlebars
{{#user-list users=model}}
  {{!-- custom template here --}}
{{/user-list}}
```

To compose components, we must use the block form, but we must also
be able to distinguish from within our component which form the user
is implementing. This can be done with the template property.

```handlebars
{{#if template}}
  {{yield}}
{{else}}
  <p>No Template Specified</p>
{{/if}}
```

We can check if template is truthy, and if it is that means that the user
specified a custom template.
Well, once we have a template, we probably want to use that in our component,
and that's exactly what {{yield}} does.

This helper can be used once, or many times. You can make your component into a
type of <ul> element,
that is a list that will repeat n times. Like the following example, where we
can output a custom summary.

```handlebars
{{#each posts as |post|}}
  <h3>{{post.title}}</h3>
  <p>{{yield}}</p>
{{/each}}
```

Which can be used like so:

```handlebars
{{#post-list posts=model}}
  Greatest post ever!
{{/post-list}}
```

And will result in the following HTML:

```html
<div id="ember123" class="ember-view">
  <h3>Tomster goes to town</h3>
  <p>Greatest post ever!</p>
  <h3>Tomster on vacation</h3>
  <p>Greatest post ever!</p>
</div>
```

But what use is it to just output the same thing over and over? Don't we want to
customize our posts,
and display the right content? Sure we do. Lets explore the {{yield}} helper a
bit.

Data Down
To accomplish composability beyond just simple templates, we need to pass
context to those templates. This can be done with the `{{yield}}` helper.

The `{{yield}}` defines where the template we defined inside our component block
will yield in the component's layout, as we saw in the previous section. Apart
from that, the yield helper also allows us to send data down, providing a
context for the templates.

```handlebars
{{yield}}
{{yield "hello"}}
{{yield item}}
{{yield this "bye"}}
```

By default yield does not send any context, but you can provide an arbitrary
number of arguments.
Once you are sending data down, the child components need to consume that data.
We can do this with the as operator. Let's take {{yield user "My Item"}} as an
example:

```handlebars
{{#user-list users=model as |user title|}}
  <h3>{{title}}</h3>
  {{user-card user=user}}
{{/user-list}}
```

Now `{{user-card}}` has access to the current user, which would change if
`{{user-list}}` placed it's yield helper inside an each block.
This opens up the possibility to use the `{{component}}` helper for different
templates, for example:

```handlebars
<h3>Profile</h3>
{{yield "user-avatar" user}}
{{yield "user-contact" user}}


{{#user-profile user=model as |section user|}}
  {{component section user=user}}
{{/user-profile}}
```

With the `{{component}}` helper, we can bind our context to names of components
dynamically, which in this case means that we can customize
the user profile with custom components bound to the relevant data. This means
we can have multiple extension points in our components, making them much more
versatile.

Actions Up
Now that we can send data down, we probably want to manipulate that data via
some user interaction,
like changing a user's avatar, or whatever it is you're doing. We can accomplish
this by using actions.

Actions are great, but for actions to work in the right context, we must use the
targetObject property to specify
where we want the action to go. Before we can specify the targetObject property
on our "acting" component, we need
to expose that target as the context.

```handlebars
{{yield this}}
```

The targetObject is the component that you want to handle the action, in this
case it's the parent component.

```handlebars
{{#user-profile user=model as |profile|}}
  {{user-avatar change="updateAvatar" targetObject=profile}}
{{/user-profile}}
```

Since profile is the instance of the {{user-profile}} component, that means it
can accept the "updateAvatar" action request.
The action must be defined on the user profile component instance.

Here's a mash-up of the possible scenarios with actions:

```handlebars
{{#full-post post=model as |fullPost|}}
  {{post-like like="like" targetObject=fullPost}}
  {{post-subscribe subscribe="subscribe" targetObject=fullPost}}
  {{comment-box submit="addComment" targetObject=post viewName="commentBox"}}

  <button type="button" {{action "fullScreen" target=commentBox}}>Zen Mode</button>
{{/full-post}}
```

Note: When using `{{action}}` helpers, instead of a component, you need to
specify target instead of targetObject.
Also, when working with actions and sibling components, use viewName to
"export" the sibling component instance as a possible target.
