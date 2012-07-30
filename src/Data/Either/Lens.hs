module Data.Either.Lens
  ( traverseLeft, traverseRight
  ) where

import Control.Applicative
import Control.Lens

-- | A traversal for tweaking the left-hand value in an Either:
--
-- > traverseLeft :: Applicative f => (a -> f b) -> Either a c -> f (Either b c)
traverseLeft :: Traversal (Either a c) (Either b c) a b
traverseLeft f (Left a)  = Left <$> f a
traverseLeft _ (Right c) = pure $ Right c
{-# INLINE traverseLeft #-}

-- | traverse the right-hand value in an Either:
--
-- > traverseRight :: Applicative f => (a -> f b) -> Either c a -> f (Either c a)
-- > traverseRight = traverse
--
-- Unfortunately the instance for 'Traversable (Either c)' is still missing from
-- base, so this can't just be 'traverse'
traverseRight :: Traversal (Either c a) (Either c b) a b
traverseRight _ (Left c) = pure $ Left c
traverseRight f (Right a) = Right <$> f a
{-# INLINE traverseRight #-}
