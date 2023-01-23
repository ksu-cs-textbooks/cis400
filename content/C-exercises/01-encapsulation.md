---
title: "Encapsulation"
pre: "1. "
weight: 1
date: 2018-08-24T10:53:26-05:00
---

### Part 1

Follow the tutorial in the following video:

{{<youtube y2hEQz3d66w>}}

### Part 2

Then add the remaining static methods to the `VectorMath` class (`Scale`, `DotProduct`, `CrossProduct`, `Magnitude`, `Normalize`) following the structure laid out in this UML class diagram:

![The Encapsulation Exercise Class Diagram](/images/c.1.1.png)

The vector operations these methods should compute are:

```math { align="center" }
$$\vec{a}+\vec{b}= \langle a_x + b_x, a_y + b_y, a_z + b_z \rangle \tag{Vector Addition}$$
$$\vec{a}-\vec{b}= \langle a_x - b_x, a_y - b_y, a_z - b_z \rangle \tag{Vector Subtraction}$$
$$\vec{a} \cdot s= \langle a_x \cdot s, a_y \cdot s, a_z \cdot s \rangle \tag{Vector Scaling}$$
$$\vec{a} \cdot \vec{b} = \langle a_x b_x + a_y b_y + a_z b_z \rangle \tag{Vector Dot Product}$$
$$\vec{a} \times \vec{b} s= \langle 
a_y b_z - a_z b_y, 
a_z b_x - a_x b_z,
a_x b_y - a_y b_x \rangle \tag{Vector Cross Product}$$
$$||\vec{a}|| = \sqrt{a_x^2 + a_y^2 + a_z^2} \tag{Vector Magnitude}$$
$$\hat{u} = \frac{\vec{u}}{||\vec{u}||} \tag{Vector Normalization}$$
```

You can uncomment the tests in the `VectorMathUnitTests` class and then run them to verify your work.

### Submit A Release

[Create a release](<ref "b-git-and-github/11-release/">) of your project code on GitHub and submit its URL.