-- Informatics 1 Functional Programming
-- Mock exam
--
-- PLEASE ENTER YOUR DETAILS HERE
--
-- Name:  Jianmeng Yu   
-- Matric:  s1413557


import Data.Char
import Data.List
import Control.Monad
import Test.QuickCheck


-- Question 1
-- 1a.

f :: String -> Bool
f xs = and [if (elem x "234567890") == False then True else False|x<-xs]

testf = f "ABCDE" == True 
     && f "none here" == True
     && f "4 Aces" == False
     && f "01234" == False
     && f "" == True
     && f "1 Ace" == True

-- 1b.

g :: String -> Bool
g [] = True
g (x:xs) | elem x "234567890" = False
         | otherwise = True && g xs

testg = g "ABCDE" == True 
     && g "none here" == True
     && g "4 Aces" == False
     && g "01234" == False
     && g "" == True
     && g "1 Ace" == True


-- 1c.

h :: String -> Bool
h xs = foldr (&&) True (map (\x -> False) (filter (\x -> elem x "234567890") xs))

testh = h "ABCDE" == True 
     && h "none here" == True
     && h "4 Aces" == False
     && h "01234" == False
     && h "" == True
     && h "1 Ace" == True

propfgh :: String -> Bool
propfgh xs = (f xs == g xs) && (g xs == h xs)
checkfgh = quickCheck propfgh

-- Question 2
-- 2a.

t :: [a] -> [a]
t xs = concat [if even i then replicate 2 x else x:[]|(x,i)<-(zip xs [1..])]

testt = t "abcdefg" == "abbcddeffg"
     && t [1,2,3,4] == [1,2,2,3,4,4]
     && t "" == ""

-- 2b.

u :: [a] -> [a]
u xs = u' (zip xs [1..])
 where 
  u' [] = []
  u' ((x,i):xs)|even i = (replicate 2 x) ++ u' xs
               |otherwise  = x : u' xs

testu = u "abcdefg" == "abbcddeffg"
     && u [1,2,3,4] == [1,2,2,3,4,4]
     && u "" == ""

proptu :: String -> Bool
proptu xs = t xs == u xs
checktu = quickCheck proptu

-- Question 3

data  Proposition  =   Var String
		   |   F
		   |   T
		   |   Not Proposition
		   |   Proposition :|: Proposition
		   |   Proposition :&: Proposition
		   deriving (Eq, Ord, Show)

instance Arbitrary Proposition where
  arbitrary = sized expr
    where
      expr 0 =
        oneof [return F,
               return T,
               liftM Var (elements ["p", "q", "r", "s", "t"])]
      expr n | n > 0 =
        oneof [return F,
               return T,
               liftM Var (elements ["p", "q", "r", "s", "t"]),
               liftM Not (expr (n-1)),
               liftM2 (:&:) (expr (n `div` 2)) (expr (n `div` 2)),
               liftM2 (:|:) (expr (n `div` 2)) (expr (n `div` 2))]

-- 3a.

isNorm :: Proposition -> Bool
isNorm (x :|: y) = isNorm x && isNorm y
isNorm (x :&: y) = isNorm x && isNorm y
isNorm (Not (Var x)) = True
--isNorm (Not T) = False
--isNorm (Not F) = False
--isNorm (Not (x :&: y)) = False
--isNorm (Not (x :|: y)) = False
isNorm (Not x) = False
isNorm x = True

test3a = isNorm (Var "p" :&: Not (Var "q")) == True
      && isNorm (Not (Var "p" :|: Var "q")) == False
      && isNorm (Not (Not (Var "p")) :|: Not T) == False
      && isNorm (Not (Var "p" :&: Not (Var "q"))) == False

-- 3b.

norm :: Proposition -> Proposition
norm (x :|: y) = norm x :|: norm y
norm (x :&: y) = norm x :&: norm y
norm (Var x) = Var x
norm (Not F) = T
norm (Not T) = F
norm (Not (Not x)) = norm x
norm (Not (x :|: y)) = norm (Not x :&: Not y)
norm (Not (x :&: y)) = norm (Not x :|: Not y)
norm x = x

test3b = norm (Var "p" :&: Not (Var "q"))
         == (Var "p" :&: Not (Var "q"))
      && norm (Not (Var "p" :|: Var "q"))
         == Not (Var "p") :&: Not (Var "q")
      && norm (Not (Not (Var "p")) :|: Not T)
         == (Var "p" :|: F)
      && norm (Not (Var "p" :&: Not (Var "q")))
         == Not (Var "p") :|: Var "q"

prop3 :: Proposition -> Bool
prop3 xs = isNorm (norm xs)
check3 = quickCheck prop3