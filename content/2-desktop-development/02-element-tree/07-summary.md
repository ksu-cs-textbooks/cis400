---
title: "Summary"
pre: "7. "
weight: 70
date: 2018-08-24T10:53:26-05:00
---

In this chapter, we saw how WPF applications are organized into a tree of controls.  Moreover, we discussed how WPF uses this tree to perform its layout and rendering calculations.  We also saw how we can traverse this tree in our programs to find parent or child elements of a specific type.  

In addition, we saw how declaring _resources_ at a specific point in the tree makes them available to all elements descended from that node.  The resources we looked at included `<Style>` elements, which allow us to declare setters for properties of a specific type of element, to apply consistent styling rules.  

We also saw how we could declare resources with a `x:Key` property, and bind them as static resources to use in our controls - including strings and other common types.  Building on that idea, we saw how we could embed images and other media files as resources.  

We also explored how `<ControlTemplates>` are used to compose complex controls from simpler controls, and make it possible to swap out that implementation for a custom one.  We also briefly discussed when it may make more sense to compose the _content_ of a control differently to get the same effect.

When we explore events and data binding in later chapters, we will see how these concepts _also_ interact with the element tree in novel ways.