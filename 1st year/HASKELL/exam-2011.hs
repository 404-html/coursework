-- Informatics 1 Functional Programming
-- December 2011

import Test.QuickCheck
import Control.Monad -- defines liftM, liftM2, used below

-- 1

-- 1a

f :: [Int] -> Int
f =  undefined

-- 1b

g :: [Int] -> Int
g =  undefined

-- 2

-- 2a

p :: [Int] -> Int
p =  undefined

-- 2b

q :: [Int] -> Int
q =  undefined

-- 2c

r :: [Int] -> Int
r =  undefined

-- 3

data Expr = Var String
          | Expr :+: Expr
          | Expr :*: Expr
          deriving (Eq, Show)

-- code that enables QuickCheck to generate arbitrary values of type Expr

instance Arbitrary Expr where
  arbitrary = sized arb
    where
    arb 0          =  liftM Var arbitrary
    arb n | n > 0  =  oneof [liftM Var arbitrary,
                             liftM2 (:+:) sub sub, 
                             liftM2 (:*:) sub sub] 
      where
      sub = arb (n `div` 2)

-- 3a

isTerm :: Expr -> Bool
isTerm (xs :+: ys) = False
isTerm (xs :*: ys) = True && isTerm xs && isTerm ys
isTerm (Var xs) = True

isNorm :: Expr -> Bool
isNorm (xs :+: ys) = isNorm xs && isNorm ys
isNorm a = isTerm a

-- 3b
