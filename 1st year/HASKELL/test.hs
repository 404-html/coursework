-- Informatics 1 - Functional Programming 

import Data.List 
import Data.Char
import Test.QuickCheck
import Network.HTTP (simpleHTTP,getRequest,getResponseBody)

f :: Char -> Bool
f x | isAlpha x == True = elem (toLower x) ['a'..'m']
    | otherwise = error "You fuck"

g :: String -> Bool
g xs = length [x|x<-xs,isAlpha x, f x ==True] > length [x|x<-xs,isAlpha x, f x == False]

h :: String -> Bool
h xs = divide xs > 0
 where
  divide [] = 0
  divide (x:xs) |isAlpha x, f x ==True = 1 + divide xs
                |isAlpha x, f x ==False = -1 + divide xs
                |otherwise  = divide xs

c :: [Int] -> [Int]
c xs = [x|(x,y)<-(zip (tail xs) xs),x == y]

d :: [Int] -> [Int]
d [] = []
d [x] = []
d (x:y:xs) | x==y = x: (d (y:xs))
           |otherwise = d (y:xs)

prop_cd :: [Int] -> Bool
prop_cd xs = null xs ||c xs == d xs

f' :: Char -> Int
f' x | elem x (['0'..'9']++['a'..'f']) = digitToInt x
     | otherwise = error "YouFUCK"

g' :: String -> Int
g' xs = maximum [f' x|x<-xs, elem x ['0'..'9'] || elem (toLower x) ['a'..'f']]

h' :: String -> Int
h' xs = maximum (filtr xs)
 where
  filtr [] = []
  filtr (x:xs) | elem x ['0'..'9'] || elem (toLower x) ['a'..'f'] = f' x : filtr xs
               | otherwise = filtr xs

c' :: [Int] -> Int
c' xs |null xs   = error "error"
      |otherwise = product (zipWith (-) xs (tail xs))

d' :: [Int] -> Int
d' [] = error "error"
d' [x] = 1
d' (x:y:zs) = (x-y)*(d' (y:zs))

prop_cd' :: [Int] -> Bool
prop_cd' xs = null xs || c' xs == d' xs

step (x:y:ys) "+" = (y+x):ys
step (x:y:ys) "*" = (y*x):ys
step (x:ys) "-" = (-x):ys  
step ys "X" = "X":ys
step ys m | all (\c -> isDigit c || c=='-') m = m:ys 
            | otherwise = error "ill-formed RPN"
                          