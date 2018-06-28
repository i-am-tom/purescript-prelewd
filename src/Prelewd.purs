module Prelewd where

import Control.Alt (alt)
import Control.Apply as A
import Control.Bind (bind)
import Control.Semigroupoid (compose, composeFlipped)
import Data.Either (Either)
import Data.Function (apply, const)
import Data.Functor (map)
import Data.Functor.Contravariant (cmap)
import Data.Lens.Iso (Iso', iso)
import Data.NaturalTransformation (NaturalTransformation)
import Data.Pair (Pair(..))
import Data.Semigroup (append)
import Data.Show (class Show)
import Data.Tuple (Tuple(..))
import Data.Void (absurd)
import Debug.Trace (trace)
import Partial.Unsafe (unsafePartial)
import Prim.TypeError (class Warn, Text)

-- | I've chosen a train as you might thing of it as the second thing going
-- | through a "magic tunnel" that transforms its passengers. Bear with me: this
-- | will make more sense in a second.
infixl 4 map as 🚂

-- | You may, from time to time, see some code like `f <$> a <*> b <*> c`. What
-- | this does is apply three (specifically `Apply`) *functor-wrapped* values to
-- | `f`, and returns the answer wrapped up in the same `Apply`. To make this
-- | clearer, `Prelewd` would write this as `f 🚂(a)🚋(b)🚋(c)`. We can now see
-- | that what we're actually doing is driving our train through the "magic
-- | tunnel" with some extra passengers. We are effectively combining `a`, `b`,
-- | and `c` using the `f` function to bring them all together.
infixl 4 A.apply as 🚋

-- | Particularly with things like validation, you'll get code sequences like
-- | `isUpper name *> pure name`, where `Either` is the underlying mechanism.
-- | What's going on here is that the values are combined with `\x y -> y`,
-- | which means that any "side-effects" from the first value aren't forgotten.
-- | So, for validation, this means that any validation *failure* is carried
-- | forward. Or, in `Prelewd`, we use the _now-look-at-that-one_ operator.
infixl 4 A.applySecond as 👉

-- | I desperately wanted to use 🌯 for this, and I probably will as soon as the
-- | compiler starts handling the weird emoji set. For now, though, I'm going to
-- | use this explosion thing. The point is that stuff (well, air) goes in one
-- | end, and gets transformed into noise or whatever. _Stretched metaphor_. The
-- | point is that confetti and stuff happens as a side-effect. `>>=` is scary,
-- | but 🎉 is delightful. `readLine 🎉 log` means "pass the input to `log`, and
-- | throw confetti everywhere in the process".
infixl 1 bind as 🎉

-- | In the early days, composition is a confusing thing to read. When we write,
-- | `f <<< g`, what we actually get is `\x -> f (g x)`. When we write something
-- | like, `f <<< g <<< h`, we get `\x -> f (g (h x))`. PureScript's syntax
-- | actually makes this pretty straightforward already, with some pretty clear
-- | direction to these operators, but this is prelewd, so let's bung in some
-- | more emojis.
infixr 9 compose as 🔙

-- | For people coming from Elm and most imperative languages, it probably seems
-- | a bit more familiar to see composition the other way round. Don't worry: we
-- | got your back, friends. At least for iOS, this arrow is labelled `SOON`, so
-- | that's quite exciting!
infixr 9 composeFlipped as 🔜

-- | `$` is waaay less frightening than it looks at first. The idea is that you
-- | take the result of everything on the left, and apply it to the result of
-- | everything on the right. So, `f x $ g x` is actually `(f x) (g x)`. That's
-- | all there is to it! With the exception of brackets/parentheses, this is a
-- | will be the very last thing to evaluate, so you can make the sides as weird
-- | as you like. The gust of wind is to show the sides being "blown apart" to
-- | work separately, before being recombined at the end!
infixr 0 apply as 💨

-- | It's quite a transformation. You'll see `~>` every now and then in types.
-- | For example, `Array ~> Maybe`. Fear not: this expands to the more friendly,
-- | `type NaturalTransformation f g = forall a. f a -> g a`. In other words,
-- | `Array ~> Maybe` is a function that takes an array of *any* type, and turns
-- | it into a `Maybe` of *the same type*. In other words, your scary natural
-- | transformations are just functions that change the functor _around_ a value
-- | without touching the value in the middle! Why is it a caterpillar, though?
-- | Well, when it becomes a butterfly, its outer shell changes a lot, but it's
-- | still the same friendly personality inside 😌
infixr 4 type NaturalTransformation as 🐛

-- | Semigroups aren't too scary. We have a type that lets us "smoosh" values
-- | together and get a new value of that type. The `<>` operator is pretty good
-- | and intuitive, but let's use the "high five": two values coming together to
-- | combine. `[2] 🙏 [3] == [2, 3]`, `"He" 🙏 "llo"` == "Hello", etc.
infixr 5 append as 🙏

-- | The `<|>` operator gets a lot of publicity in parser libraries. When you go
-- | for a rummage in the docs, you find phrases like "monoidal applicative",
-- | which don't help a lot. Basically, we're combining the behavior of two
-- | functor values of the same type. For some functors like `Array`, this is
-- | just the same as 🙏. However, it's often for *fallbacks*: if your functor
-- | is a `Maybe`, `x <|> y <|> z <|> ...` will return the first `Just`, or
-- | `Nothing` if there aren't any.
infixl 3 alt as 🔗

-- | Once in a while, we all need to debug. A lot of programmers from imperative
-- | languages find real trouble with debugging, as they can't just bung in a
-- | `console.log` to see values. *Well*, what if I told you... you *can*! So,
-- | we can cheat a little bit, and use some escape hatches in the `Debug`
-- | package, including `traceShow`, which will log anything `Show`able. With
-- | this function, we can show a value at any point, and return anything!
investigate :: forall a b. Warn (Text "Debug.Trace usage") => Show a => a -> b -> b
investigate x y = trace x 💨 const y

-- | For example, if we have `f x` and want to know what `x` is, we can write
-- | `x 🔍 f x`. This will return the same value as `f x`, but also print the
-- | `x` value (sneaky-like) to the console for us to look at.
infixl 8 investigate as 🔍

-- | Be careful with this! It's a function never to be called. Anyway, since
-- | there are no values of type `Void`, what would you even call it with?
infix 9 absurd as 💣

-- | Sometimes you need to tell the compiler that you know what you're doing,
-- | even though it might not be obvious. That's OK! Maybe you _know_ you have
-- | a `Just` value: `fromJust 🙈 Just 2` will get you that 2 with no trouble!
-- | Beware, though: if you're wrong, PureScript won't save you from runtime
-- | errors!
infix 1 unsafePartial as 🙈

-- | Not only can we compose functions, but also functors! Maybe we want a list
-- | of `Maybe` values, or an `Aff` of a function. Whatever it is, we can write
-- | some "stacks" with `Compose`.
type Compose f g a = f (g a)

-- | Before: `forall a b. Tuple a b -> Tuple a (Array b)`.
-- | After: `forall a. Tuple a 🐛 Tuple a 🍔 Array`.
-- | I'm not saying that you should do this, but it looked funny to write out. A
-- | stack of functors is like a stack of burger ingredients: do as you will.
infixr 9 type Compose as 🍔

-- | `Either` is defined as having two types. The constructors hold one each. So
-- | an `Either Int String` is *either* a `Left Int` or `Right String`. This has
-- | lots of uses, commonly with error-handling. You can use `Left` to carry any
-- | problems, and `Right` to carry success. `Error 🆚 Result`, if you like.
infixl 3 type Either as 🆚

-- | `Pair` bundles two values of the same type together. Name a more famous
-- | twin ... I'll wait.
infixl 3 Pair as ♊

-- | `Tuple` takes two arguments and bundles them together, always together,
-- | both in the type and in the value.
infixl 3 Tuple as 👫
infixl 3 type Tuple as 👫

-- | Make a value presentable! `Contravariant` functors are usually of the form
-- | `F a = a -> X`, where `X` is some fixed type like `Boolean`. When we do a
-- | `cmap`, we say, "I don't have an `a`, but I _do_ have a way to _get to_
-- | `a` from `b`, and we can therefore have an `F b = b -> x`. In a sense, we
-- | need a way to make the value look suitable. What better way to make oneself
-- | presentable than to put on some lipstick?
infixl 9 cmap as 💄

-- | Equivalent things can be exchanged for each other. Like currency! This is
-- | called an isomorphism, see Data.Lens.Iso. Swap an `a` for a `b` anytime!
infix 1 iso as 💱
infix 1 type Iso' as 💱
