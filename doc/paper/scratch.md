% A formalism for data processing systems
% Timothy Hunter
% December 27, 2017

This article draws on the foundations of measure theory and group theory to offer a formalism of 
large scale data systems. Starting from first principles, we show that most operations on 
datasets can be reduced to a small algebra of operations that are well suited for optimizations
and for composition into much larger systems in a coherent fashion, and in handling streaming data.
We hope that these principles can inform the implementation of future distributed data systems.

# Introduction

The explosion in the collection of data has lead to the rise of diverse frameworks to store and 
manipulate this data accordingly.

The SQL language has enjoyed considerable success as a standard
querying interface for the non-programmers. On the other end of the spectrum of complexity,
engineers in charge of processing such large amounts of data have devised a number of tools to
distribute computations against these large datasets, such as MapReduce and Hadoop.

_(TODO:talk about streaming and fast reaction)_

_(TODO:talk about separating storage from compute)_

If one looks at the landscape of the data processing systems, several trends emerge:

 - unification of different paradigms (streaming, batch processing, interactive analytics)
 
 - separating storage from compute does not work for workloads with high operational intensity like 
   machine learning (see TPUs, GPU processing, John Canny's research).
   
 - big data systems are used as foundations for implementing much larger systems.
 
 - More generally, the same set of challenges that led to handling files with version control systems 
   are now prevalent in continuous systems (TODO: cite matei)


When a system is designed to serve as the substrate on top of which more complex systems are built, 
establishing sound principles and structures is paramount. Without these, complex and unforeseen 
interactions emerge that expose some behavior that on the face of it, is a logical consequences of 
the initial specifications, but yields surprising or confusing results to the user of such a system.

Artificial intelligence is arguably not well captured by current systems because of its roots in
statistics, and its peculiar needs. At a high level, ML is not that different from other data 
processing frameworks: it condenses data into a model (in the case of supervised learning), and 
then applies this model to some unseen data.

Data processing systems are primarily focused on transforming data, and as such reading and writing 
data is a critical, but poorly formalized, part of such systems. For example, from the perspective
of a programmer, to a distributed file system is often considered with the same flexibility as
writing to a local file, even though the possibility - and the cost - of an error is considerably
higher. This is why databases have been developed as data storage 
systems with strong guarantees (TODO: unclear sentence). An important motivation of this article is to 
provide a framework in which reading and writing data is considered a primitive operation, and
on which all sorts of mechanical transforms, checks and optimizations can be applied.

This article is structured as such:

 - it first introduces high-level principles based on observability of data (a prerequisite in 
   distributed systems)

 - it establishes necesary mathematical structure that naturally derives from these first 
    principles
 
 - it discusses possible ways to address temporal aspects and streaming data.
 
 - it offers some hints at implementation and a proof of concept built on top of Spark.

The code examples are done using mathematical notations and Haskell functions, which should be
clear enough in most of the case.


# Introduction (old)

There has been a tremendous explosion in the collection and processing of data of all kind. In order 
to cope with this gathering, several strategies have emerged: adapting old tools or inventing new
data processing engines adapted to the underlying infrastructures and to the choices of 
implementations. As far as traditional tools are concerned, the rise of SQL for handling distributed 
datasets has been remarkable, as this technology was first invented in TODO for single computers. 
SQL is now considered the _lingua franca_ of data processing, and it can be found in various
flavors in all modern industrial systems (BigQuery, Spark, Redshift, ...). That said, SQL is not 
the only computing model in the world of distributed computing. Owing to the then unique needs of 
Google, the MapReduce paradigm has enjoyed considerable success in technical tasks, especially 
through more recent frameworks inspired by its principles, such as Spark or Flink. Unlike SQL though,
these frameworks require more understanding of the implementation in order to be productive: they 
offer a different tradeoff of flexibility and ease of use. 

Data collection hardly happens once in the context of a business, and reactivity to new data is 
considered a critical feature of modern companies. As such, a number of systems have been designed 
to cope with the incoming flux of data as soon as it gets collected. Some examples include Kafka
or Flink. The interfaces of such systems are mostly concerned with expressing some chaining of 
operations between multiple stages and efficiently processing a record as soon as possible, at the 
expense of performance (TODO this is wrong). Because such systems were started by solving
distributed challenges first, they do not have the strong theoretical backing found in other 
frameworks such as SQL.

The major theme in the last two years has been unification. Moving data between each system is 
inefficient for technical and commercial considerations: the data storage is optimized for the
task (streaming, batch, etc.) and in these systems, the architecture of the data storage is key for 
the processing architecture. Furthermore, commercial SQL engines that are tied to a specific 
cloud system such as Google BigQuery or Amazon Redshift/Athena have little incentive to be fully 
compatible with competitors' systems. It is easier to recreate the missing capablity in a walled 
garden rather than adapting the internals and be at the mercy of changes in a dependent system. The 
cost of coordination is too high.

This is why most popular systems nowadays offer multiple capabilites under one umbrella: batch 
processing of data, streaming processing, high-level processing with SQL or other structured
interfaces. This is mostly the case for Spark and Flink. Unification is achieved through a common 
interface that is capable and expressive enough to address the needs of high-level interfaces such 
as SQL, but that also abstracts enough of the _modus operandi_ so as to give flexibility to 
run and distribute the computations. Without this flexibility, taking automated decisions is 
either impossible or inefficient. These interfaces need to find a tradeoff between expressivity 
and abstraction.

These intermediate interfaces are usually rather ad-hoc and built around the low-level system. 
This is why we propose here a description of interfaces for data systems that is not bound to 
a particular implementation but rather that derives from principles in programming languages and 
statistics. Why should we bother? As data systems grow in complexity, the possibilities offered by
a loose interface hamper the construction of more complex, task-specific abstractions. We hope that 
the considerations below can guide in the implementation of a computing system that can serve as a 
basis for more complex systems built on top of it.



# General principles

This section is concerned with some ideas that hold no matter the type of system:

 0. Perspective of the observer, only reductions can be observed.
 
 1. The data representation is not observable 
 
 2. The flow of computations follows the structure of the data.
 
 3. Reductions are deterministic
 
 4. Failures are not observables
 

This paper starts from a few general principles and shows how can reconstruct some commonly used
constructs in big data systems.

_Observer perspective_ A dataset is a collection of values. Two operations can be done on a 
dataset:

 - transforming it into another dataset.
 - condensing the dataset into a single value. This is also what is called _reducing_ the dataset
   into an observable (value).

The observer principle states that the user (the observer) only has access to observables, and not 
to the dataset itself. This idea is familiar to physicists, who have long considered adopted a
similar posture in quantum physics, in which the measure of the physical system itself (a wave 
function) is integral part of the design.

_Abstraction of data representation_ In this setting, the data structure that backs the dataset is 
not observable and has no incidence on the results (the values of the observables). This is not
respected by current systems: for 
example in SQL, the order of the results is not specified. More insidious, in Spark and Flink, 
results depend on the partitioning scheme of the data, sometimes with confusing results. This 
principle guarantees that making observations against a dataset yield a unique and well-defined
value in all cases. (TODO: this is up to numerical precision issues).
There are a variety of data structures to represent a collection of values, backed by an equally 
large number of implementations (B-Trees, sequences, lists, lists of lists, maps, etc.). This 
principle ensures that implementation details do not percolate through the interface, and we will
see a few implementations in Section TODO. An additional motivation
is the ability to tie some formal statistical concepts such as distributions to justify and 
explain some choices.

The next principle is specific to data systems, and probably the most restrictive in terms of the 
structure that it imposes on the computation model. Yet, it covers a very wide variety of 
reductions that users would consider on data systems.

_Distributed computations_ The flow of computations follows the structure of the data.

This naturally follows from the abstraction of the data representation: in the trade-off between 
separating compute from storage, or tying compute and storage, operations performed on the data
should not depend on specific choice. Computations can either be run close to the data or require 
data movement. That last principle ensures that the programming model is oblivious to this 
implementation choice.

_Deterministic observables_ Given the same inputs of datasets and observables, any observable shall 
yield the same results. (TODO: up to numerical precision).
This is a natural assumption, yet it is often not respected by implementations. In this formalism,
because we will consider operations of reading ang writing as observables, this will lead to 
important restrictions on the kind of input and output operations that can be performed.

_Failures are not observable_ It is common to experience failure in large, distributed systems. 
TODO: have a principle that says that trying to access the value of an observable can yield a bottom
value (error, exception, failure, etc.). However, the changes to the environment caused by producing
a bottom value are not observable. Practically, this means that repeatedly trying to write a dataset 
to a file (possibly distributed), however many failures occur in the process, will not be observed.
This is not respected in current systems for example, when the append mode is used, or at great cost
in performance. 
TODO: this is pretty weak and unjustified.

The rest of this section explores in more details how this formalism applies to abstract data 
representations.


## Datasets

We consider operations over some sets of values, in which we want to apply the basic principles 
outlined above.
All the operations perform either on values or sets of values, and data processing consists in 
writing some functions that transform sets into other sets, or into values.
As mentioned before, here are a couple of assumptions that we will work on:
 - the exact representation of the data is not observable. This is often not verified in such
 systems.
 - the data is considered static. It does not change over time. This will be addressed in Section TODO.

We consider here a simple formalism: call $\mathcal{U}$ the set of all the values, called 
the _universe_. We assume that the universe is countable and separable.
Subsets of 
the set of all values can be tagged with _types_. A type is essentially a subset of all the values.
Types are mostly useful when writing programs and for clarity, not so much for our mathematical 
derivations.

_Definition: dataset_ A dataset is a _finite measure_ over the set of values. 
$d:\mathcal{U}\rightarrow\mathbb{N}$ with the restriction: 
$$
\sum_{x\in\mathcal{U}}d\left(x\right)<\infty
$$
In terms of types, a simple dataset could be defined as such:
```hs
type Dataset a = a -> Nat
```

__Note__ Basic arithmetic over sets ensures that the function defined above is a measure in the 
sense of distributions (TODO: add link to definition of measures). Since we work with a countable 
and separable set, we do not need the 
technical conditions that would be found in more more complex normed spaces. A part of this work is 
dedicated to working out the sufficient conditions that would hold in all generality.

## Basic operations over distributions

We now define a number of common operations that will be present throughout the rest of the paper.

__Union__ The union of two datasets is a dataset:
$$(d_1 \cup d_2)(x) = d_1(x) + d_2(x)$$

```hs
union :: Dataset a -> Dataset a -> Dataset a
union d1 d2 = \x -> d1 x + d2 x
```

This operation is of course symmetric, associative, commutative and has a zero element (the
empty set). This is the most important of all the general operations, because it conveys some 
useful structure over datasets (a monoid and a semi-group).

__Dirac__ The dirac of a dataset is the extraction of a single value at a given point. The name 
`dirac` comes from the theory of measures, which itself comes from physics. As is customary, we
denote it $\delta_a$.

```hs
dirac :: a -> Dataset a
dirac x y = if x == y then 1 else 0
```
TODO: fix in the paper: it is a distribution.

One trivial consequence is the fact that a dataset is the (finite) sum of diracs. This fact will 
have its importance later.

To simplify the notations, we introduce the following shorthands:


\begin{align*}
n\cdot\left\{ x\right\}  & =\left\{ x\right\} \cup\left(\left(n-1\right)\cdot\left\{ x\right\} \right)\\
0\cdot\left\{ x\right\}  & =\left\{ \right\} 
\end{align*}


__Mass__ The mass $\mu$ of a dataset is the count of all its points. The name sounds related to physics
and we will see the intuition behind it later.

$$
\mu\left(x\right) = \sum_{x\in\mathcal{U}}d\left(x\right)
$$


```hs
mass :: Dataset a -> Nat
```

## Point transforms

With this structure, there is not much we can do so far, apart from querying the value of a dataset
at various points. We are going to add many more operations now. One of the simplest and yet most
effective ways to transform a dataset is to apply some operation to all its points individually.
We are going to characterize the transforms that are the most regular with respect to the 
Distribution principle: if a dataset 
is a union, we would like the transform to respect this union.

_Definition: regular transform_ A function `f :: Dataset a -> Dataset b` is said to be _regular_
if the following applies:

$$
\forall d_{1},d_{2}\in\mathbb{D},\,f\left(d_{1}\cup d_{2}\right)=f\left(d_{1}\right)\cup f\left(d_{2}\right)
$$


It turns out that this adds a lot of structure to all the possible point transforms; in particular
the transforms have to be automorphisms over the dataset monoid.

__Proposition: neutral element__: The empty set is a neutral element:
```hs
f {} = {}
```

The following proposition justifies the programming interfaces of most distributed systems:

__Proposition: characterization__: All the point transforms can be uniquely characterized by their
operations on elements. More precisely, by the point function:
```hs
point_f :: a -> [b]
```
(up to a permutation of the elements in the return list).

TODO: proof

The last proposition shows that regular transforms are fully described by transforming 
individual points, and that each point can only get mapped to a collection of other points.
We can now fully qualify transforms about how many points they produce for each point: exactly one
(mass-preserving), at most once (mass-shrinking) or arbitrary.

_Definition: Mass-preserving transform_ A mass-preserving transform obeys the following invariant:
$$
\forall d\in\mathbb{D},\,\mu\left(f\left(d\right)\right)=\mu\left(d\right)
$$

It is fully characterized by a function `point_f :: a -> b`. Conversely, any such function defines
a mass-preserving transform. This is the functional `fmap` familiar to functional 
programmers:

```hs
map :: (a -> b) -> Dataset a -> Dataset b
```

_Definition: Shrinking transform_ A mass-shrinking transform (or shrinking transform in short) reduces the 
mass of a dataset:
$$
\forall d\in\mathbb{D},\,\mu\left(f\left(d\right)\right)\leq\mu\left(d\right)
$$
Similarly, it is fully characterized by its 
optional return on each point:

```hs
mapMaybe :: (a -> Maybe b) -> Dataset a -> Dataset b
```

_Definition: k-regular transform_ A regular transform is said to be k-regular if for all dataset $d$:
$$\mu\left(f\left(d\right)\right)\leq k\mu\left(d\right)$$

Note that k can always be chosen a natural integer, since the description of a transform is 
equivalent to the description of its effect on each data point (which produces a finite number of 
outputs).

Transforms that are bounded and regular are the most desirable from the perspective of a computing 
model: the computation model is highly predictable with respect to the distribution of computations.
We will see how some common operations can be rewritten as bounded transform for more efficent 
processing in a distributed fashion.

## Reductions

Reductions correspond to the action of taking a dataset and condensing its information into 
a single value. This is the second fundamental operation one can do on a dataset.

```hs
r :: Dataset a -> b
```

Again, we would like this transform to obey some distribution principle: reducing a dataset 
to a single value should be done independently from the structure of the dataset, and it should be
run in parallel if the dataset is the union of subsets. This is expressed through the following 
definition:

_Definition: monoidal reductions_ A reduction $r$ is said to be _monoidal_, or _universal_, 
if there exists a function $+_{r}\,:\,\mathcal{D}\rightarrow\mathcal{D}\rightarrow\mathcal{D}$
 that obeys the following distributivity rule:

$$
r\left(d_{1}\cup d_{2}\right)=r\left(d_{1}\right)+_{r}f\left(d_{2}\right)
$$

A monoidal reduction can be interpreted as carrying over through computations of the underlying
structure of the dataset. It turns out that the property above is quite strong and imposes a 
lot of constraints on the definition of $+_r$:


__Proposition: Monoid structure__ The relation $\left(\text{Im}\left(r\right),+_{r}\right)$
describes a monoid over $\text{Im}\left(r\right)$. The neutral element
of this monoid is $r(\{\})$.

 - __Characterization__ This morphism is fully described by the values of `r` over diracs and `{}`.

 - __Unicity__ This monoidal law is unique over $\text{Im}\left(r\right)$

__Composition__ This trivial proposition has important consequences for optimizations:
If `r` and `s` are both monoidal reductions, then the pair reduction: `\(x,y) -> (r x, s y)`
is also a monoidal reduction. This allows arbitrary merging of various reductions against the same
dataset into a single reduction, whil preserving the semantics of the program. We will see more 
examples of this proposition in action in section TODO.

How justified is this framework? It turns out that such computation generalize the notion of integration
outside the ordinary ring of the reals. For any morphism between the set of distributions and some
other monoid, one can define the integral as follows. Given a distribution $d$ and a reduction $r$,
the integral:

$$
\int r\text{d}d=\int_{\mathcal{U}}r\text{d}\left(d\right)=\sum_{x}r\left(d\left(x\right)\cdot\left\{ x\right\} \right)
$$

In particular, we recover the usual properties of distributivity of the integral.

$$
\int\left(r\oplus s\right)\text{d}d=\int r\text{d}d\oplus\int s\text{d}d
$$

One key intutive 
difference with the usual understanding of integration is that in the context of data manipulation,
the emphasis is on the measure, not the reductor. Which is why we propose to introduce a different
terminology to make this change more palatable:

$$
\ointop d\text{d}r=\intop r\text{d}d
$$

which leads for example to the more natural distributivity property:

$$
\ointop\left(d\cup e\right)\text{d}r=\ointop d\text{d}r+_{r}\ointop e\text{d}r
$$

### Reductions - examples

Here are a couple of fundamental examples of reductions.

__count__ In this case, `+_count` is the regular addition over naturals.

__sum__ `+_sum` is the regular addition over reals.

__max__ `+_max` is the maxium over 2 values.

__dirac__ The existence of a point. TODO

__top-K__ Given an order on a dataset, computing the top K values with respcet to this ordering is 
a common operation. `+_topk :: b^k -> b^k -> b^k` takes the top K values out of the union of 
2 lists.

__variance, higher order moments__ Based on sum and count, one can also obtain all the higher order moments.

Here are some less common operations, but that still shows the power of this abstract representation.

__bloom filter__ Given 2 bloom filters with the same parameters, the monoidal reduction is the 
point-wise `OR` operation over each bit of the bloom filter.

__sketches__ This is the same idea with sketches, by taking pointwise sums of values.

__approximate quantiles__ It turns out that the algorithms used to build quantiles rely on intermediate
data structures that are much amenable to be distributed. These data structures can the be post-processed
to obtain approximate quantiles.

__Naive bayes models__ and more generally models that rely on sufficient statistics.

__Approximate top K__ TODO

The most important composition property of monoids is that a pair of monidal reductions is also 
a monoidal reduction itself.

### Reductions - counter examples

A few operations do not enjoy such strong properties however.

Machine learning models, in all generality. These models usually rely on solving a convex optimization
problem, and convexity does not carry over the union.

Modes of distributions. This is intuitive: it relies on counting point wise, which cannot be done
with a single summary.

### Reductions - applications

How to build observables from reductions? As we will see, a large number of observables are built 
from reductions in the form $f\left(r_{1}\left(d\right),r_{2}\left(d\right),\cdots\right)$ , in 
which the final function $f$ is pretty simple. A classic example is of course the mean, which is 
the sum divided by the count:

$$
\text{mean}\left(d\right)=\frac{\ointop d\text{d}\left(\text{sum}\right)}{\ointop d\text{d}\left(\text{count}\right)}
$$

Such a decomposition is very useful from the perspective of the 
computational model.

 - it is common that data comes in batches $d_1, d_2, \cdots$. With such a decomposition, it is 
 trivial to compute the update, as it is simply the application the reduction to the last batch.
 In that sense, these distributivity laws are akin to derivation in real analysis. More on that 
 later.
 
 - for data that is ordered, and for which we want to perform an operation such as windowing,
 or cumulative sums, this structure dramatically speeds up computations without requiring any 
 input from the user. We will see in the subsequent sections how butterfly schemes can be built
 up on arbitrary monoidal reductions, hence the name universal.

## Joins

```hs
join :: Dataset (k, a) -> Dataset (k, b) -> Dataset (k, Maybe a, Maybe b)
```

It follows some distributivity law, as we would expect:

```hs
join (a1 U a2) b == (join a1 b) U (join a2 b)
join a b = join b a
mass (join a b) == max (mass (key a1 U key a2))
```

TODO: is it enough to define the union through axioms?

## Groups

A group corresponds to the notion that data points can somehow be associated together. It allows
to express transforms on potentially many datasets all at once.

__Definition: group__ A group is a function from datasets to datasets:

```hs
type Group k v = k -> Dataset v
```

Of course, this is a very high-level definition, and we will see how it works out in practice.
A practical implementation of a group may be done as follow, thanks to Currification: a group 
is the type `k -> v -> Nat`, or through Currying: `(k, v) -> Nat`, which suggest an alternative 
representation for groups:

```hs
type Group k v = Dataset (k, v)
```

We will use one representation or the other according to the situation.

Reductions over groups. Define the following operator:

```hs
shuffle :: Reduce a b -> Group k a -> Dataset (k, b)
```

```hs
groupBy :: (v -> k) -> Dataset v -> Group k v
```

__Distributivity of shuffle__

This distributivity law shows the power of the universal reductions.

```hs
shuffle f (g1 `union` g2) = map (+_f) (join (shuffle f g1) (shuffle f g2))
```

### Filter

```hs
filter :: (a -> Bool) -> Dataset a -> Dataset a
```

This is a simple example of contraction.

### Ordered reductions

```
orderedReduce :: Ord a => Dataset (a, b) -> [b]
```

### Canonical representation

```hs
shuffle count . groupBy id 
```

### Indexing and counting

Here are a couple of operations one can do to as substitutes for usual operations in SQL, using the
basic transforms outlined above.

### Substitutes for random operations

It is common to associate a random value $x_i$ to each value $z_i$ of a dataset. What does random mean in that 
respect? It means that the random value $x_i$ is not correlated in a statistical sense to the 
original value $z_i$: knowing one does not convey information about the other. I argue here that 
there are two ways to construct such random values, either by building a carefully constructed 
suite of values independently from the values of the dataset (the classical way), or using 
one-way functions (TODO: proper names), such as cryptographic functions, based on the values 
of the dataset.

In the classic way of building random values, one uses a seeded series. This is what Spark does. 
TODO: explain more how it works. This approach is inconvenient in the context of distributed datasets,
though, since any repartitioning of the dataset can lead to inconsistencies, or even worse, to 
different results.

I argue that a cryptographic scheme should be the default in distributed datasets. It stems from 
the following observation: if each of the value in a dataset is unique (distinct from all other
values), then applying a one-way function $\kappa$ will construct values that uncorrelated from both
the original values and the other random values. If a dataset $d$ is max-entropic, then the 
dataset $\left(d,\kappa\left(d\right)\right)$ has random values.

This scheme can be extended to non-distinct datasets, using the `enumerate` operation, which 
we will discuss below. Such an approach has the advantage of generating values in a way that respects
all the dataset axioms. Generating random values is not a special operation, but simply yet another 
dataset transform.

# Time series and streaming

_Definition: Stream_ A stream is a growing series of dataset:
```hs
type Stream a = Nat -> Dataset a
```
such that $s_{t} \in s_{t+1}$. 

The intuition behind a stream is that of a collection that is observed incrementally.
Because it is essentially a dataset, most of the results over datasets carry 
naturally over.
TODO: using category theory to define the results?

One of the main considerations when dealing with streams is about stability and
convergence: are results obtained for one part of the stream still valid in the 
future? We introduce a notion of stability that is common in the context of 
measures and distribution. It stems from the idea that a stream is the incremental 
observation of a distribution.

_Definition: stable stream_: A stream $s$ is stable if there exists an integrable function
$g:\mathbb{U}\rightarrow\mathbb{R}$ and a constant $K>0$ so that for all elements:

$$
s_{t}\left(x\right)\leq\text{mass}\left(s_{t}\right)g\left(x\right)
$$

$$
\text{mass}\left(s_{t-1}\right)-\text{mass}\left(s_{t}\right)\leq K
$$

(And recall that $g$ is integrable if:)
$\text{mass}\left(g\right)<\infty$

This is enough to define the limit of a stream using the 

### Distances in data space

TODO: introduce a notion of distance between 2 elements of the same type. It is natural for any
element:
 - edit distance for strings (or vector distance)
 - edit distance for arrays and maps
 - usual L1 distance for the rest 

TODO: build a norm based on that.
 
## convergence properties of streams

### Notion of convergence

TODO: introduce the notion of limit using the o() notation instead of usual limit. Use distance.
 
_Definition: stable reduction and signature_: A reduction is stable if for any stable stream s, 
there exists a value u(s) so that:

f(s_n) ~ f(count(s_n) . {u(s)})

This function is called the signature of the reduction: sig(f)(s).

_Definition: expectation of a stream_ This is the signature. 

### Examples of stable reductions

Some examples: max, mean, sum, count, quantiles, bloom filters, top-K, moments, mode

Some counter-examples: the following are not stable: hash (by design)

### Main theorem

TODO: this is pretty intuitive, but it should be formalized: if $s$ is a stable stream and $f$ is a 
regular data function, then f(s) converges.

# Implementation notes: datasets as an applicative functor

It is common to think of operations on datasets as monadic, and indeed this is how they are 
represented usually (CITE spark). In this section, we propose an alternative semantic
that is strictly 
more general than monads and that we believe provides strong benefits in practice, in terms of 
usability and performance. Based on the formalism above, a dataset is an example of applicative 
functor. While this nuance may seem subtle at first, it offers a lot of advantages in practice.
In effect, it allows a strict 
separation of a _data program_ against arbitrary sources from the runtime. At the end of this
section, we will show that all that has been discussed above can be implemented on top of three different 
runtimes: Spark, a generic SQL database, and the Pandas framework.

## Generalities: dataset, the applicative

Spark (or for that matter, the other map-reduce based frameworks) make a distinction between 
_transforms_ and _actions_. This distinction is inspired by the difference between the pure (functional)
transforms and the effects, which are captured in the runtime monad of the underlying system. We 
propose to treat all the effects of a data systems as observables, and this is the essence of making
dataset an applicative.

Recall that an applicative functor has the following laws:

 1. `map`, the functional map.
 
 2. `lift`, which takes a value and lifts it

In our case, `lift` takes either a value or a function and wraps it as a dataset or observable. 
This works nicely. TODO.

The essence of applicative functors is that _the transformation on the data can be described independently from the data itself_.
This is a crucial point for distributed systems, in which the datasets can be huge. This approach 
is different from the current implementations, which explicitly or implictly rely on an outer 
monad. Take the example of the following Spark snippet, in which a dataset gets written and then
some other operations are perfomed:

```scala
val data: Dataset[Int] = ???
data.write.parquet("file")
data.write.parquet("file")
```

This code performs two consecutive actions (writing the data twice).
Because these actions are imperative in the Spark programming models, they cannot be reorganized. 
Arbitrary operations could be performed between the two calls, in the Spark interactive model. This
is a well known limitation of the monadic semantics in computation models, in which effects cannot 
be optimized automatically, even though the programmer may have additional insights into the program.

The question of I/O will be dealt with in more depth in the next section, but consider as an example
the following optimization that is already possible with applicative semantics:

```scala
val data: Dataset[Int] = ???
val theMin: Int = data.min
data.write("/mydata")
val theMax: Int = data.max
val theSpread: Int = theMax - theMin
```

This sort of code would trigger two successive jobs in Spark, because Spark cannot infer in all 
generality that no effect takes place between the calls. If the side effects such as I/O are 
modeled as observables, the code above can be written with some slight modifications as following
(as before, the type annotations are here for the clarity of discussion and are not necessary in 
practice)

```scala
val data: Dataset[Int] = ???
val theMin: Observable[Int] = data.min
val theMax: Observable[Int] = data.write("/mydata").then(data.max)
val theSpread: Int = sparkContext.run(theMax - theMin)
```

This code gets translated by the engine as the following:

```scala
data.cache()
val resultObservable: Observable[Int] = sql("select max(*) - min(*) from data")
val theSpread: Int = sparkContext.run(resultObservable)
sparkContext.write(data, "/mydata")
data.uncache()
```

A number of operations has happened:
 - the operation of writing the dataset has been identified has independent from the other reductions.
   In fact, some extra caching logic is automatically inserted if necessary.
 - both reductions were subsumed into a single pass over the data. This can significantly speed up
   computations and is accomplished through elementary graph analysis.
 - the final difference is pushed into the same query.
 - finally, getting the result needs to be explicitly called out to run. With the proper assistance 
   of the interactive system, this is hardly an issue in practice.


## The case of inputs and outputs

Inputs and outputs are the most important effects when datasets are concerned. As far ar our 
formalism is concerned, they are treated as an observable. Indeed, the signature of the writing 
function in Haskell is:

```hs
writeData :: WriteConfig -> HdfsPath -> Dataset a -> Observable ()
```

This gives the program a large amount of flexibility in reoarganizing the computations if necessary,
and in providing a consistent way to deal with effects. Some current capabilites include automatic 
checks on permissions and overwriting. Furthermore, in the context of streaming data, the code 
can handle streaming data with no change. As mentioned above, if the program detects that a write 
is not necessary (such as a place being overwritten later but never read in between), it removes 
such a write and all the dependent operations.

As an interesting application, a number of seemingly incorrect programs now make sense, owing to
the uniform treatment of all side effects as observations. Consider the following trivial function that 
takes a dataset, writes it and then returns the count of observations:

```scala
def function(d: Dataset[a]): Observable[Long] = {
  d.write("/path").andThen(d.count)
}
```

This is an aggregation, and as such it can be used in groups:

```scala
val data: Dataset[(Int, a)] = ???
val data2: Dataset[Long] = data.group().reduce(function)
```

What happens when evaluating `data2`? A set of files gets created, following the grouping convention
of the underlying implementation of the file system. In the case of Spark, the following files would
get created:

```
/path/key=value1/record0000.parquet
/path/key=value1/record0001.parquet
...
/path/key=value2/record0000.parquet
...
```

More generally, inputs and outputs can be treated in a composable manner within programs: one can 
assemble functions that contain reads and writes in a way that is safe and composable. From 
experience, significant amounts of effort are spent in practice on understanding the data flow. 
Making data writes and reads a first class citizen provides much more visibility for the programmer 
and the runtime on the actions of the system.

As an other example, the runtime can checks some invariants, the departure of which are much maligned
in practice. Consider the following (simplified code):

```scala
val data: Dataset[a] = ???
val o = data.write("/path")
val o2 = data.read("/path").count
context.run(o, o2)
```

This would be valid code in a monadic setting, but at the expense of not exploiting parallelism to 
the fullest extent. Because the two effects are clearly not commutative (a common situation for 
interesting applicatives), our current prototype will refuse to run this program and detect that 
some additional ordering must be introduced by the user.

### Writing modes

Owing to the genearl philopophy of determinism, some operations have retstricted semantics compared to
existing systems. In particular, there is no `append` mode when writing, as this would violate the principle
that observables are deterministic given the same inputs. We propose an alternative though, using groups. 
As mentioned, groups are written in a partitioned way, based on the key of the dataset. It is common 
for new data to be associated to a separate key. Also, because of the strong associativity laws of the 
datasets, for common, simple operations, the framework can detect if the update is incremental, and 
only update the required parts of the files.

Writing presents interesting challenges when trying to use distributed file systems that offer fairly 
weak forms of consistency. This has been covered in other pices of literature, so we will not cover it here.

## User-defined inputs

A critical components for modern data processing systems is the ability to extend the system with additional 
processing facilities.

## Miscellani

Some operations do not carry over with this scheme, for example when the schema depends on the data.
This is the case in a few operations:

 - pivot: the columns depend precisely on the value of the data, so arguably it does not work. In 
 our paradigm though, there are a few ways to emulate this behavior.
 
 - schema discovery with unstructured sources (for example JSON or CSV). It is common when starting 
 with a new source to discover its schema. In that case there is indeed not much that can be done.
 In practice though, one usually separates the phase of complete discovery, in which nothing in 
 known _a priori_ about the dataset, and the phase of manipulation, in which some content of the 
 data is at least expected (for example, we expect a feature columns with arrays of doubles).
 This is where a functional style can help by clearly delineating the expected schema from the other
 parts.
