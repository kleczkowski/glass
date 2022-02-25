{- |
Module      : Glass.Types
Copyright   : (c) 2022 Konrad Kleczkowski
License     : MIT
Maintainer  : konrad.kleczkowski@gmail.com
Stability   : experimental
Portability : POSIX

General types of optics with re-exported
modules commonly used across library.
-}
module Glass.Types
  ( -- * General types
    Optic
  , OpticK
  , Optic'
  , OpticK'
    -- ** Special optic cases
  , OpticRep
  , LensLike
    -- * Re-exports
  , module Data.Profunctor
    -- $profunctor
  ) where

import Data.Profunctor

{- |
General type of optic based on concrete profunctor @p@.

Basically a function that embeds contextful transformation of @a@ values
to @b@ values into transformation from structure @s@ to structure @t@
in which @a@ and @b@ lives. Meaning of the transformation is fully
determined by given profunctor.

@since 0.1.0
-}
type Optic p s t a b = p a b -> p s t

{- |
Type of optic where profunctor is constrained
by type class @c@.

Used as a definition of type of optic.

@since 0.1.0
-}
type OpticK c s t a b = forall p. c p => Optic p s t a b

{- |
Simple 'Optic', when @s = t@ and @a = b@.

@since 0.1.0
-}
type Optic' p s a = Optic p s s a a

{- |
Simple 'OpticK', when @s = t@ and @a = b@.

@since 0.1.0
-}
type OpticK' c s a = forall p. c p => Optic' p s a

{- |
Special case of 'Optic' where 'Star' is profunctor.

This optics representation is called van Laarhoven optics.

@since 0.1.0
-}
type LensLike f s t a b = Optic (Star f) s t a b

{- |
Type used for passing concrete type of optics to functions.

This type is isomorphic to some optic represented by
profunctor @rep@.

@since 0.1.0
-}
type OpticRep rep s t a b = Optic (rep a b) s t a b

{- $profunctor
Module re-exported for necessary type classes of profunctors
used among definitions of optics.
-}
