# A formalism for data systems

This is considerations for formalizing some ideas found in modern data systems.

The code examples are done using mathematical notations and Haskell functions, which should be
clear enough in most of the case.

## Setting

We consider operations over some sets of values, in which we want to follow some basic principles.
All the operations operate either on values or sets of values, and data processing consists in 
writing some functions that transform sets into other sets, or into values.
Here are a couple of assumptions that we will work on:
 - the exact representation of the data is not observable. This is often not verified in such
 systems.
 - the data is considered static. It does not change over time.

The first point has profound implications, in that datasets do not have first or last elements.
They do not behave like regular collections, which are usually sequential in nature. However,
this provides a lot of advantages in the case of big data processing.

We consider here a simple formalism: call $\mathcal{U}$ the set of all the values, called 
the _universe_. We assume that the universe is countable and separable.
Subsets of 
the set of all values can be tagged with _types_. A type is essentially a subset of all the values.
Types are mostly useful when writing programs and for clarity, not so much for our mathematical 
derivations.

A dataset is a _finite measure_ over the set of values. $d:U\rightarrow\mathbb{N}$ with the 
restriction: 
$$
\sum_{x\in\mathcal{U}}d\left(x\right)<\infty
$$

__Note__ Basic set arithmetic ensures that the function defined above is a measure in the 
sense of distributions. In a sense, we consider here some easy subset of distributions.

### Basic operations over distributions:

__Union__ The union of two datasets is straightforward:

```hs
union :: Dataset a -> Dataset a -> Dataset a
(union d1 d2) x = d1 x + d2 x
```

This operation is of course symmetric, associative, commutative and has a zero element (the
empty set). This is the most important of all the general operations, because it conveys some 
useful structure over datasets (a monoid and a semi-group).

__Dirac__ The dirac of a dataset is the extraction of a single value at a given point. The name 
`dirac` comes from the theory of measures, which itself comes from physics.

```hs
dirac :: a -> Dataset a
dirac x y = if x == y then 1 else 0
```

One trivial consequence is the fact that a dataset is the (finite) sum of diracs. This fact will 
have its importance later.

__Mass__ The mass of a dataset is the count of all its points. The name sounds related to physics
and we will see the intuition behind it later.

```hs
mass :: Dataset a -> Nat
```

### Point transforms

With this structure, there is not much we can do so far, apart from querying the value of a dataset
at various points. We are going to add many more operations now. One of the simplest and yet most
effective ways to transform a dataset is to apply some operation to all its points. This is the 
functiorial `fmap`:

```hs
map :: (a -> b) -> Dataset a -> Dataset b
map f d = ...
```

From the definition, the result is clearly a dataset, and the `map` operation follows the 
laws of the functors.

Prop: Mass conservation: forall f, `mass (map f d) == mass d`.

The point transform is also called the mass-preserving transform, because it is the only 
transform that conserves the mass for any functon `f`. TODO: prove.

### Reductions

A monoidal reduction, or reduction, is a function `f` that takes a dataset and returns a
scalar value, in a way that it also maps the structural properties of a dataset. It is 
a function:

```hs
f :: Dataset a -> b
```

with the additional restriction that there exists another function `+_f` that describes a monoid
structure over the set `S_b`. More precisely, `f` and `+_f` are linked through the following:

```hs
f (d1 union d2) = (f d1) +_f (f d2)
```

A couple of useful properties can be derived:

__Monoid structure__ The relation `(Im f, +_f)` describes a monoid over `Im f`. The neutral element
of this monoid is `f {}`.

__Characterization__ This morphism is fully described by the values of `f` over diracs and `{}`.

__Unicity__ This monoidal law is unique. TODO

### Groups and joins

### Ordered reductions

### Substitutes for random operations