---
title: >
  TailwindCSS Lets Me Move Fast

authors:
  - ilya
date: '2020-06-24T15:34:22.216Z'
tags:
  - tailwind
---
I heard that one of the main benefits of Tailwind is that it limits your choices, and I can't agree more, but a less noted feature is the fact that it removes
another barrier. That is the extra steps it takes to style something and to move freely and confidently.

I've been noticing that when I'm working on a project, I have this extra step of "where do I even start" when it comes to styling a feature. I notice this pattern in projects that have CSS disconnected from the components that they style and in projects where the CSS lives right next to the component. I haven't tried CSS-in-JS yet, so can't comment on that yet. I think there are a few blockers for me when I'm trying to get into the styling mindset, and the fact that there is even that mental shift at all says something.

First of all I need to decide where the CSS has to go, then I have to decide what to call the class. Next I need to see if there is other CSS that already covers this component and should I reuse another class or add the new class as part of the existing structure or should it be stand-alone? Now did I write maintainable CSS that others will be able to understand and extend or delete if needed? I'm sure there are more steps, not to mention the whole idea of having to do a context switch to begin with. If we look at Tailwind, it's a different story.

With Tailwind the styles are in the same place as the markup so you don't decide on where to put them or if it's with existing CSS. You might have to create a component to reuse classes that you write repeatedly, but you are already doing the work of abstracting markup and creating components, tailwind just helps you as another metric for when to start a component. There is also no need to think about naming your classes since you use utility functions like `flex`, `rounded`, and `my-2`. Also you can still special CSS for those use-cases (usually the 10%) where you need something special like `height: calc(100vh - 60px)`. Now if I move some markup, the styles don't break. If I delete some markup, I don't have to worry that I have unused CSS or that the CSS I just deleted was used elsewhere.

At the end of the day, it helps me move faster without the extra blockers, and helps me abstract when the time is right, which usually isn't until later in the project once you see patterns. Give Tailwind a try, and remember that you can mix it with your other workflow. I like to use CSS Modules for the 10% and Tailwind for the 90%. Tailwind is probably not the ultimate solution, and yes you still need to understand CSS, but it's a step closer to something that helps you create within good limits.
    
    
