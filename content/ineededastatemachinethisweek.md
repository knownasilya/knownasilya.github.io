---
title: >
  I Needed A State Machine This Week

authors:
  - ilya
date: '2020-01-19T04:20:30.184Z'
tags:
  - ember-js
---
This week I fixed a "feature" that I had done half-way, yes I'm not perfect! The feature was to show a loading state for video uploads/recording, and it was more complex than I realized.

While I did not end up using a state machine , I should have (I realized that I should have today). The feature had to work directly after upload or after a recording. It also had to work on a page refresh
if the video was in a processing state on the server. This was not simple, because there are multiple ways to initiate the state and multiple ways to know if you need to be in a loading state to show a UI to the user.
Even now I am sure there are some bugs in the implementation that I wrote.

The XState website has a [visualizer](https://xstate.js.org/viz/) which by default shows some scenario that I've just described. Just visualizing the logic gives me a clearer idea of what I should have done, and if I did implement it in a state machine, I wouldn't have any invalid states because it's impossible to get into them (as long as the logic is sound). I think XState will be the next library that I add to my side-project so that I can give it a go before proposing to add it to our tech stack at Crash.
    
    