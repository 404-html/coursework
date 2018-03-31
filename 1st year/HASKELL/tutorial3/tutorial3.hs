-- Informatics 1 - Functional Programming 
-- Tutorial 3
--
-- Week 5 - Due: 16/17 Oct.

import Data.Char
import Data.List
import Test.QuickCheck



-- 1. Map
-- a.
uppers :: String -> String
uppers xs = map toUpper xs

-- b.
doubles :: [Int] -> [Int]
doubles xs = map (*2) xs
               --(\x -> x * 2)

-- c.        
penceToPounds :: [Int] -> [Float]
penceToPounds xs = map (/100) (map fromIntegral xs)

-- d.
uppers' :: String -> String
uppers' xs = [toUpper x|x<-xs]

prop_uppers :: String -> Bool
prop_uppers xs = uppers xs == uppers' xs



-- 2. Filter
-- a.
alphas :: String -> String
alphas xs = filter isAlpha xs

-- b.
rmChar ::  Char -> String -> String
rmChar x xs = filter (x/=) xs

-- c.
above :: Int -> [Int] -> [Int]
above x xs = filter (>x) xs

-- d.
unequals :: [(Int,Int)] -> [(Int,Int)]
unequals xs = filter (\(x,y)-> x/=y) xs
--            filter nsame            xs
--                   where nsame (x,y) = x /= y

-- e.
rmCharComp :: Char -> String -> String
rmCharComp k xs = [x|x<-xs,x/=k]

prop_rmChar :: Char -> String -> Bool
prop_rmChar x xs = rmChar x xs == rmCharComp x xs



-- 3. Comprehensions vs. map & filter
-- a.
upperChars :: String -> String
upperChars s = [toUpper c | c <- s, isAlpha c]

upperChars' :: String -> String
upperChars' s = map toUpper (filter isAlpha s)

prop_upperChars :: String -> Bool
prop_upperChars s = upperChars s == upperChars' s

-- b.
largeDoubles :: [Int] -> [Int]
largeDoubles xs = [2 * x | x <- xs, x > 3]

largeDoubles' :: [Int] -> [Int]
largeDoubles' xs = map (*2) (filter (>3) xs)

prop_largeDoubles :: [Int] -> Bool
prop_largeDoubles xs = largeDoubles xs == largeDoubles' xs 

-- c.
reverseEven :: [String] -> [String]
reverseEven strs = [reverse s | s <- strs, even (length s)]

reverseEven' :: [String] -> [String]
reverseEven' xs = map reverse (filter (\x -> even(length x)) xs)
                             --where evenLength x = even(length x)

prop_reverseEven :: [String] -> Bool
prop_reverseEven strs = reverseEven strs == reverseEven' strs



-- 4. Foldr
-- a.
productRec :: [Int] -> Int
productRec []     = 1
productRec (x:xs) = x * productRec xs

productFold :: [Int] -> Int
productFold xs = foldr (*) 1 xs

prop_product :: [Int] -> Bool
prop_product xs = productRec xs == productFold xs

-- b.
andRec :: [Bool] -> Bool
andRec [] = True
andRec (x:xs) = x && andRec xs

andFold :: [Bool] -> Bool
andFold xs = foldr (&&) True xs

prop_and :: [Bool] -> Bool
prop_and xs = andRec xs == andFold xs 

-- c.
concatRec :: [[a]] -> [a]
concatRec [] = []
concatRec (x:xs) = x ++ concatRec xs

concatFold :: [[a]] -> [a]
concatFold xs = foldr (++) [] xs

prop_concat :: [String] -> Bool
prop_concat strs = concatRec strs == concatFold strs

-- d.
rmCharsRec :: String -> String -> String
rmCharsRec [] str = str
rmCharsRec (k:kstr) str = rmChar k (rmCharsRec kstr str)

rmCharsFold :: String -> String -> String
rmCharsFold kstr str = foldr (rmChar) str kstr

prop_rmChars :: String -> String -> Bool
prop_rmChars chars str = rmCharsRec chars str == rmCharsFold chars str

type Matrix = [[Int]]

-- 5
-- a.
uniform :: [Int] -> Bool
uniform xs = all (\x -> head xs == x) xs

-- b.
valid :: Matrix -> Bool
valid xs = uniform [length x|x<-xs] && xs/=[] && xs/=[[]]

-- 6.

--a)18
--b)zipWith f xs ys = [f x y|x<-xs,y<-ys]
--c)zipWith f xs ys = map (uncurry f) (zip xs ys)

-- 7.
plusM :: Matrix -> Matrix -> Matrix
plusM xs ys |(valid xs && valid ys && length xs == length ys && length (head xs) == length (head ys))==True = plusMa xs ys
            |otherwise = error "invalid input"
 where
  plusMa xs ys = zipWith (zipWith (+)) xs ys

-- 8.
timesM :: Matrix -> Matrix -> Matrix
timesM xs ys |valid xs && valid ys == True  = map (alldot (transpose ys)) xs
             |otherwise = error "Not valid, stupid."
 where 
   alldot xs ys = map (dot ys) xs
     where
       dot xs ys = sum (zipWith (*) xs ys)
       
-- Optional material
-- 9.
