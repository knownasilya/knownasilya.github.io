---
title: Sharing Components with Engines
authors:
  - ilya
date: Mon Mar 19 2018 17:50:59 GMT+0100 (IST)
tags:
  - ember
---
## Is this what I'm looking for?

You have at least one engine and you want to share components from your parent app without having an in-repo-addon to share the common components. You might also want fine-grain control over how the components are setup and what data comes over. Most likely these are not UI-only components, but they deal with your app data and business logic.

I'm hear to tell you that it's possible, but it's a manual process that involves using some "advanced" concepts that Ember introduced in v2. So lets dig in and see what that looks like.

## What it looks like

I'm going to jump to the end and show you the result, then we'll go back and cover how to implement this in your app.

We start with the template in your engine:

![carbon--4-](/content/images/2018/03/carbon--4-.png)

It looks very simple, notice that the above is a component, and it's being rendered using dot notation off of a `share` service.

Now that we see how it's used, lets see how it's setup in our parent app.

![carbon--3-](/content/images/2018/03/carbon--3-.png)

The above uses a custom component called `share-ui` which acts like a proxy to our `share` service. Then we use the built-in `hash` helper which basically just creates an object and passes it as an "argument" to our component.

You should alos notice that we use the `component` helper, which lets us dynamically setup a component without calling it. In the above example we passed the `user` from our parent application template context.

## Lets implement it

We need two things to make this work, a `share` service and the `share-ui` component. Lets start with the service.

> I make an assumption that you have already setup your app and engine, since those two steps are documented elsewhere, I'll skip them for brevity.

### `share` service

We'll create our service first:

![carbon--5-](/content/images/2018/03/carbon--5-.png)

It should look like so:

![carbon--6-](/content/images/2018/03/carbon--6-.png)

This is all that needs to be done for the service. Make sure to share the service with your engine:

![carbon--7-](/content/images/2018/03/carbon--7-.png)

Then in our engine we also define it:

![carbon--8-](/content/images/2018/03/carbon--8-.png)

### `share-ui` component

Now that we have our service, lets create our component and
wire it all together.

![carbon--9-](/content/images/2018/03/carbon--9-.png)

We'll start by injecting our service into the `share-ui` component:

![carbon--10-](/content/images/2018/03/carbon--10-.png)

Notice that we also have `tagName` set, that is to prevent adding an unneeded div element into the DOM, since we aren't rendering any UI with this component. Now that our component can communicate with our service, we need to set the `component` argument on our service, so lets do that:

![carbon--11-](/content/images/2018/03/carbon--11-.png)

We should now have the functionallity that we presented above. The on thing we missed is actually using the service in our engine, so just inject it
in your component or controller, depending on where you use your shared components.

> Note: Make sure to use the `share-ui` component in a parent template that will always be visible when the engine is used. I recommend the `application` template.

## What now?

The above example is powerful enough to support additional sharing, like helper and data. You can also share items from addons in your parent application, preventing duplication of addons between parent and engines.

If you want to go further, you can even build a theming system ontop of this setup by defining UI components for each theme and having an attribute on the `share-ui` component that toggles between the different component sets.

Feel free to connect via Twitter if you have any comments/suggestions.