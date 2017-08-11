# 🤖 Prelewd 🙋

When newcomers to PureScript see some code for the first time, there's a 90% chance that the first comment will be something like, _"What does `$` do?"_, or _"`f <$> a <*> b`? Wat?"_. This library is for people wondering **exactly that**.

The standard [`Prelude`](https://pursuit.purescript.org/packages/purescript-prelude/3.1.0/docs/Prelude) is _fine_, but it's a bit... well, **monotone**. Wouldn't it look better if they were a little more... **fabulous**? 🦄 Let's look at some of the common operators with more **panache**. 🎩✨

_Below is a table of short explanations. For a more fully-formed write-up (and some explanation as to **why** these symbols were chosen), see the [actual code](https://github.com/i-am-tom/purescript-prelewd/blob/master/src/Prelewd.purs)._

## Operators

| Emoji | Symbol | Explanation |
|  --   |   --   |     --      |
|  🚂   |  `<$>` | Map the function to the left over the [`Functor`](https://pursuit.purescript.org/packages/purescript-prelude/3.1.0/docs/Data.Functor#t:Functor)-wrapped value to the right. |
|  🚋   |  `<*>` | Apply the functor-wrapped function on the left to the functor-wrapped value on the right. |
|  👉   |   `*>` | Combine two [`Apply`](https://pursuit.purescript.org/packages/purescript-prelude/3.1.0/docs/Control.Apply#t:Apply)'s effects, and return the second. |
|  🎉   |  `>>=` | Pass the left-hand "inner value" into the right-hand function. |
|  🔙   |  `<<<` | Return a function that takes a value, applies it to the right-hand function, and then applies it to the left-hand function. |
|  🔜   |  `>>>` | Same as `compose`, but backwards. |
|  💨   |   `$`  | Apply the result of the expression to the left to the expression on the right. |
|  🐛   |   `~>` | `f ~> g` is a function that turns an `f a` to an `g a` for _any_ `a` value. A [**natural transformation**](https://pursuit.purescript.org/packages/purescript-prelude/3.1.0/docs/Data.NaturalTransformation#t:NaturalTransformation). |
|  🙏   |   `<>` | Combine two [`Semigroup` values](https://pursuit.purescript.org/packages/purescript-prelude/3.1.0/docs/Data.Semigroup#t:Semigroup). |
|  🔗   | <code>&lt;&#124;&gt;</code> | Combine two [`Alt`](https://pursuit.purescript.org/packages/purescript-control/3.3.0/docs/Control.Alt#t:Alt) values. A good starting intuition is to think of this as a "chain of **fallbacks**". |
|  💄   |  `>$<` | "Pre-process" a value for a [`Contravariant` functor](https://pursuit.purescript.org/packages/purescript-contravariant/3.0.0/docs/Data.Functor.Contravariant#v:cmap). |

## Utilities

| Emoji | Implementation | Explanation |
|   --  |        --      |      --     |
|  🔍   | `\x y -> traceShow x 💨 const y` | `x 🔍 y` has the exact same value as `y`, but it sneakily prints `x`'s value to the console. _Shh_! |
|  💣   | `absurd` | The emoji should tell you this probably isn't the function you want... |
|  🙈   | `unsafePartial` | Remove the `Partial` constraint, e.g. `fromJust 🙈 Just 2 == 2` |
|  🍔   | - | `(f 🍔 g) a` is a type equivalent to `f (g a)`. This is **composition** for functors. |
|  🆚   | - | An alias for the [`Either` type](https://pursuit.purescript.org/packages/purescript-either/3.0.0/docs/Data.Either#t:Either). |
|  ♊   | - | An alias for the [`Pair` type](https://pursuit.purescript.org/packages/purescript-pairs/5.0.0/docs/Data.Pair#t:Pair). |
|  💱   | - | An alias for the [`Iso` type](https://github.com/purescript-contrib/purescript-profunctor-lenses/blob/v3.2.0/src/Data/Lens/Types.purs#L36-L36) |

Is `f <$> a <*> b` scarier than `f 🚂(a)🚋(b)🚋(c)`? If so, **why**?
The functions may look unfamiliar, especially the infix symbols, but
they're not that scary. Above are all the common symbols, with enough
of an explanation to get you following along with any code you see.

And, of course, if in doubt, ask the community! Send me a tweet, join
an IRC forum, whatever. **Get involved**. This [library's
documentation is available on Pursuit](https://pursuit.purescript.org/packages/purescript-prelewd),
where you'll be able to read some more in-depth explanations of some
of what we've seen.

## Contributing

Have I missed anything you think belongs? **Send a PR!**

---

With ❤️ 💛 💚 💙 💜 🖤 from Tom 🏁
