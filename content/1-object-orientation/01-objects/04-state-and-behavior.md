---
title: "State and Behavior"
pre: "4. "
weight: 4
date: 2018-08-24T10:53:26-05:00
---

The data stored in a program at any given moment (in the form of variables, objects, etc.) is the *state* of the program.  Consider a variable:

```csharp
int a = 5;
```

The state of the variable **a** after this line is **5**.  If we then run:

```csharp
a = a * 3;
```

The state is now **15**. Consider the Vector3 struct we defined in the last section:

```csharp
public struct Vector3 {
    public double x;
    public double y;
    public double z;

    // constructor
    public Vector3(double x, double y, double z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }
}
```

If we create an instance of that struct in the variable `b`:

```csharp
Vector3 b = new Vector3(1.2, 3.7, 5.6);
```

The state of our variable `b` is {{<math>}}$\{1.2, 3.7, 5.6\}${{</math>}}.  If we change one of `b`’s fields:

```csharp
b.x = 6.0;
```

The state of our variable `b` is now {{<math>}}$\{6.0, 3.7, 5.6\}${{</math>}}.

We can also think about the state of the *program*, which would be something like: {{<math>}}$\{a: 5, b: \{x: 6.0, y: 3.7, z: 5.6\}\}${{</math>}}, or a state vector like: {{<math>}}$|5, 6.0, 3.7, 5.6|${{</math>}}.  We can therefore think of a program as a *state machine*. We can in fact, draw our entire program as a state table listing all possible legal states (combinations of variable values) and the transitions between those states. Techniques like this can be used to reason about our programs and even prove them correct!

This way of reasoning about programs is the heart of [Automata Theory](https://en.wikipedia.org/wiki/Automata_theory), a subject you may choose to learn more about if you pursue graduate studies in computer science.

What causes our program to transition between states?  If we look at our earlier examples, it is clear that *assignment* is a strong culprit.  Expressions clearly have a role to play, as do control-flow structures decide which transformations take place.  In fact, we can say that our program code is what drives state changes - the *behavior* of the program.

Thus, programs are composed of both state (the values stored in memory at a particular moment in time) and _behavior_ (the instructions to change that state).  

Now, can you imagine trying to draw the state table for a large program?  Something on the order of EPIC?  

On the other hand, with encapsulation we can reason about state and behavior on a much smaller scale.  Consider this function working with our `Vector3` struct:

```csharp
/// <summary>
/// Returns the the supplied vector scaled by the provided scalar
/// </summary>
public static Vector3 Scale(Vector3 vec, double scale) {
    double x = vec.x * scale;
    double y = vec.y * scale;
    double z = vec.z * scale;
    return new Vector3(x, y, z);
}
```

If this method was invoked with a vector {{<math>}}$\langle4.0, 1.0, 3.4\rangle${{</math>}} and a scalar {{<math>}}$2.0${{</math>}} 
our state table would look something like:

<table>
  <tr>
    <th>step</th>
    <th>vec.x</th>
    <th>vec.y</th>
    <th>vec.z</th>
    <th>scale</th>
    <th>x</th>
    <th>y</th>
    <th>z</th>
    <th>return.x</th>
    <th>return.y</th>
    <th>return.z</th>
  <tr>
  <tr>
    <td>0</td>
    <td>4.0</td>
    <td>1.0</td>
    <td>3.4</td>
    <td>2.0</td>
    <td>0.0</td>
    <td>0.0</td>
    <td>0.0</td>
    <td>0.0</td>
    <td>0.0</td>
    <td>0.0</td>
  </tr>
  <tr>
    <td>1</td>
    <td>4.0</td>
    <td>1.0</td>
    <td>3.4</td>
    <td>2.0</td>
    <td>8.0</td>
    <td>0.0</td>
    <td>0.0</td>
    <td>0.0</td>
    <td>0.0</td>
    <td>0.0</td>
  </tr>
  <tr>
    <td>2</td>
    <td>4.0</td>
    <td>1.0</td>
    <td>3.4</td>
    <td>2.0</td>
    <td>8.0</td>
    <td>2.0</td>
    <td>0.0</td>
    <td>0.0</td>
    <td>0.0</td>
    <td>0.0</td>
  </tr>
  <tr>
    <td>3</td>
    <td>4.0</td>
    <td>1.0</td>
    <td>3.4</td>
    <td>2.0</td>
    <td>8.0</td>
    <td>2.0</td>
    <td>6.8</td>
    <td>0.0</td>
    <td>0.0</td>
    <td>0.0</td>
  </tr>
  <tr>
    <td>4</td>
    <td>4.0</td>
    <td>1.0</td>
    <td>3.4</td>
    <td>2.0</td>
    <td>8.0</td>
    <td>2.0</td>
    <td>6.8</td>
    <td>8.0</td>
    <td>2.0</td>
    <td>6.8</td>
  </tr>
</table>

Because the parameters `vec` and `scale`, as well as the variables `x`, `y`, `z`, and the unnamed `Vector3` we return are all defined only within the scope of the method, we can reason about them and the associated state changes _independently_ of the rest of the program. Essentially, we have encapsulated a portion of the program _state_ in our `Vector3` struct, and encapsulated a portion of the program behavior in the static `Vector3` library.  This greatly simplifies both writing and debugging programs.

However, we really will only use the `Vector3` library in conjunction with `Vector3` structures, so it makes a certain amount of sense to define them in the same place.  This is where _classes_ and _objects_ come into the picture, which we'll discuss next.