---
title: >
  Magic Link Auth with Supabase & Ember
authors:
  - ilya
date: '2021-08-31T02:20:00.386Z'
tags: 
image: 
---
I've started working a bit with Supabase, which if you haven't heard is a hosted opensource alternative to Firebase that uses Postgres, which is a pretty nice and battle-tested database. One of my favorite things about Firebase was the easy access to authentication, so that was the first thing I wondered about with Supabase. I want to show how easy it is to get basic magic link auth working in your Ember app.

I'll skip most of the things that are already documented on the Supabase website, and just get to the relevant code for your Ember app. Magic links are basically a password-less authentication method which uses your email address and sends you a login link. The security lies in keeping your email account secure, which we should all be doing.

## Register


    