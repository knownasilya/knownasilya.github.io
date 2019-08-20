---
title: Ember In 2018 and Beyond
#image: /content/images/2018/05/ember_Ember-Light-e42a2b30-2.png
authors:
  - ilya
date: '2018-05-22T20:31:27.000Z'
tags:
  - ember-js
---
This post is in response to the Call for Blog Posts
[https://emberjs.com/blog/2018/05/02/ember-2018-roadmap-call-for-posts.html] 
put out there by the core team. Have a look at all the other blog posts in this
series [https://github.com/zinyando/emberjs2018-posts]. Most of what I'll say
has probably been said, but I think it's worth repeating to show the important
things via repetition.

I'm an avid user of Ember and have been using it since the RCs of v1.0.0. I love
Ember, warts and all, which means I have come to terms with many of it's issues
and short comings. Having said that, I see a future that is brighter, where
Ember is a major contendor and trend setter in the frontend community. What
follows are the things that I think  need to change to make that vision come
true.

Ship the things
The Ember community is one focused on conventions and shared solutions rather
then many solutions without a clear winner. This makes it hard to focus on one
area, since we need conventions in many areas of frontend development. Due to
this difficulty I think we've gotten many hands in many things and many of those
are half finished. I think we need to double down as a community and finish the
things that we've started.

I'm one of those that loved the idea of Routable Components, even when the goal
was moving further and further away. It was promised so long ago and I hoped for
so long. When Yehuda Katz [https://mobile.twitter.com/wycats]  closed  that RFC,
I think a bit of that dream died, but at the same time I was happy. Not because
it wasn't going to happen but because there was clear communication, finally. In
the same way, we might need to put some in-progress work on the backburner with
clarity and divert resources to work that is more pressing.

Fix the bugs
A big part of Ember is the router, but that is probably also one of the messiest
parts with lots of cruft due to the churn in the earliest days of Ember. There
has been much work in the last couple of years (thanks Trent Willis
[https://mobile.twitter.com/trentmwillis]  and others!) to clean up and document
more of the router code, but this part is still very brittle
[https://github.com/emberjs/ember.js/labels/Query%20Params]. Almost every app
that I have built using Ember has used the URL in a major way for users of the
apps.

One of the biggest things when new users come in is to run into these bugs that
have been open for a while, and it's not the most encouraging thing when you
want to build something on top of this big framework.

Focus on longterm vision
Many have spoken about marketing, vision and brand, but I think it's worth
repeating that it's super important. For Ember to grow we need a long term
vision that needs to grow as the wider community grows. We made some early bets
that have worked out well, and we need to keep doing that in the technical
sphere, but we also need to do that for the image of the framework. We don't
have the backing and resources of the big companies that React and Angular have,
so we must be more focused.

Starting with a marketing team, which should be responsible for branding, the
main website and promoting the framework on social media.

I think this is also the place to hone what Ember is. I really like the idea of
Ember as a Component-Service Framework
[https://medium.com/@pzuraq/emberjs-2018-ember-as-a-component-service-framework-2e49492734f1] 
 as proposed by @pzuraq [https://mobile.twitter.com/pzuraq]. Many have a view of
Ember as MVC, and I think that is hurting more then helping when other
frameworks put themselves forward as component based.

https://mobile.twitter.com/pzuraq

I ❤️ Ember
Just the fact that we can learn from others and do so actively - take this whole
"call for blog posts" initiative - really gives me hope in Ember's future. I
know that the core team cares deeply about the future of Ember and this shows in
their attitude. Many have said some hard things in response, and I hope those
hard things cause a stir in the community for the better for Ember's future. We
need more leaders to step up and organize/delegate in the right areas.

Thanks to David Baker [https://mobile.twitter.com/acorncom]  for reviewing this
post!