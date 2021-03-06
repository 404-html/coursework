-- INF 1 Functional Programming
-- 
-- Indexed data represented as a tree


module KeymapTree ( Keymap,
                    size, depth,
                    get, set, del,
                    select,
                    toList, fromList,
                    merge, filterLT, filterGT                  
                  )

where

-- Modules for testing

import Test.QuickCheck
import Data.List

-- The data type

data Keymap k a = Leaf
                | Node k a (Keymap k a) (Keymap k a)

-- A test tree

testTree :: Keymap Int Int
testTree = Node 2 20 (Node 1 10 Leaf Leaf)
                     (Node 3 30 Leaf 
                               (Node 4 40 Leaf Leaf ))

-- Exercise 6

size :: Ord k => Keymap k a -> Int
size Leaf = 0
size (Node _ _ left right) = 1 + size left + size right

depth :: Ord k => Keymap k a -> Int
depth Leaf = 0
depth (Node _ _ left right) |depth left >= depth right = 1 + depth left
                            |otherwise = 1 + depth right

-- Exercise 7

toList :: Ord k => Keymap k a -> [(k,a)]
toList (Leaf) = []
toList (Node k a left right) = [(k,a)]++(toList left)++(toList right)

-- Exercise 8

set :: Ord k => k -> a -> Keymap k a -> Keymap k a
set key value x = f x
    where
      f Leaf = (Node key value Leaf Leaf)
      f (Node k v left right) | key == k  = (Node k value left right)
                              | key <= k  = f left
                              | otherwise = f right

-- Exercise 9

get :: Ord k => k -> Keymap k a -> Maybe a
get key testTree | null[y|(x,y)<-(toList testTree),x==key] = Nothing
                 | otherwise = Just (head [y|(x,y)<-(toList testTree),x==key])

prop_set_get :: Int -> Int -> Bool
prop_set_get k v = get k (set k v testTree) == Just v 

-- Exercise 10

fromList :: Ord k => [(k,a)] -> Keymap k a
fromList [] = (Leaf)
fromList xs = (Node (fst(head xs)) (snd(head xs)) (fromList [(x,y)|(x,y)<-xs,x<(fst(head xs))]) (fromList [(x,y)|(x,y)<-xs,x>(fst(head xs))]) )
--fromList ((k,v):xs) = set k v (fromList xs)

prop_toList_fromList :: [Int] -> [Int] -> Bool
prop_toList_fromList xs ys = sort (toList (fromList zs)) == sort zs
    where
      zs = zip (nub xs) ys

prop_toList_fromList_sorted :: [Int] -> [Int] -> Bool
prop_toList_fromList_sorted xs ys = toList (fromList zs) == sort zs
    where
      zs = zip (nub xs) ys

-- Optional Material -----------------------------------

-- Exercise 12

filterLT :: Ord k => k -> Keymap k a -> Keymap k a
filterLT = undefined

filterGT :: Ord k => k -> Keymap k a -> Keymap k a
filterGT = undefined

-- Exercise 13

merge :: Ord k => Keymap k a -> Keymap k a -> Keymap k a
merge = undefined

-- Exercise 14

del :: Ord k => k -> Keymap k a -> Keymap k a
del = undefined

-- Exercise 15

select :: Ord k => (a -> Bool) -> Keymap k a -> Keymap k a
select = undefined 
