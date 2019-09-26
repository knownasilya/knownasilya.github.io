---
title: 'Billing and Finite State Machines'
# image: ''
authors:
  - ilya
date: '2019-09-26T15:31:32.693Z'
tags:
  - ember-js
---
This week I've been coding up some billing workflows and it has been a while since I've done that, so naturally I underestimated the amount of work that is required for proper billing. Thankfully I'm using Stripe, which has all of their many ducks in a row and great documentation and testing tools. Every time I work on billing I lean towards using a finite state machine to represent my workflow, but I never end up doing it, because for some reason it's hard for me to decide on and stick to using FSMs, maybe because it's just so against how my brain thinks or it's because I think the problem will be easier. Well it usually never ends up easier, and in the end I regret not using a FSM. Maybe something like #nocode/visual editing would help with this kind of disconnect for me and state machines.

Just some raw thoughts as I'm working on billing. What has been your experience with billing and FSMs on the server or client side?
