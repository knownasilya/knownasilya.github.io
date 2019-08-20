---
title: Use Ember CLI
# image: ''
authors:
  - ilya
date: '2015-01-15T21:07:17.000Z'
tags:
  - ember-js
  - ember-cli
---
I've been using Ember.js since just before the first RC, and since then I've
been wanting a sane project structure that just works. This was a struggle,
since Ember told you to put everything on App.. :(

After I heard about the proposed POD structure, I started working on emberate
[https://github.com/AppGeo/emberate], which took a directory and processed the
files in a way where you didn't have to deal with App, you'd just module.export 
whatever code the file was about.

Now mix emberate, browserify, and gulp  and you have a pretty decent build
system, right? Well, something was missing, because it would be very brittle,
and it's features were kinda barebones. There was more to be desired, and yes I
tried ember-app-kit, but it was too bulky and required you to learn so many 
grunt  plugins, that it was total overhead.

Enter, ember-cli, yes it's not perfect, but it's the best thing we have for a
build system that works. It's maintained by several of the Ember core team, and
many other awesome contributors
[https://github.com/ember-cli/ember-cli/graphs/contributors]. Not only does it
support browserify [https://github.com/ef4/ember-browserify], but ES6 as well.
There are generators, e.g. ember g  and ember d, like Rails had, and POD
support. Not mentioning the addon system, http mocking with node.js, and
build/server watching.

There is no reason to not use it if you do anything that needs a build step.
Even if you don't need one, it makes the structure uniform and anyone can come
in and know what's up. It has the same goals as Ember, and there are even plans 
to make it official.

In Ember 2.0, Ember CLI and ES6 modules will become first-class parts of the
Ember experience.

Ember 2.0 RFC by Ember Team

Ember CLI will be a big part of the transition from Ember 1.x to Ember 2.x,
which is supposed to be a gradual transition from versions 1.10.0 and onward.
Two-Point-O will just remove the deprecated features.

You should begin moving your app to Ember CLI as soon as possible.

Plus there is a huge community that is writting addons [emberaddons.com]  for
Ember CLI. You can write your own too; I wrote pagination-pager
[https://www.npmjs.org/package/pagination-pager], ember-cli-toggle
[https://www.npmjs.org/package/ember-cli-toggle]  and ember-cli-pen
[https://www.npmjs.org/package/ember-cli-pen]  (more to come). I also use a few
of them, like liquid-fire [https://github.com/ef4/liquid-fire], ember-notify
[https://github.com/aexmachina/ember-notify], ember-cli-less
[https://github.com/gdub22/ember-cli-less], ember-browserify
[https://github.com/ef4/ember-browserify], and others!

So use it today, and you wont regret it tomorrow! Check out ember-cli.com
[http://ember-cli.com]  to get started.

P.S. Check out this gist by Sam Selikoff [https://github.com/samselikoff]  on
how to future proof [https://gist.github.com/samselikoff/1d7300ce59d216fdaf97] 
your Ember app.