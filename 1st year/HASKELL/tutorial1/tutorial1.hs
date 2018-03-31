-- Informatics 1 - Functional Programming 
-- Tutorial 1
--
-- Due: the tutorial of week 3 (2/3 Oct.)

import Data.Char
import Data.List
import Test.QuickCheck



-- 1. halveEvens

-- List-comprehension version
halveEvens :: [Int] -> [Int]
halveEvens xs = [ div x 2 | x <- xs , mod x 2 == 0 ]

-- Recursive version
halveEvensRec :: [Int] -> [Int]
halveEvensRec []                    = []
halveEvensRec (x:xs) | mod x 2 == 0 = div x 2 : halveEvensRec xs
                     | otherwise    = halveEvensRec xs
-- Mutual test
prop_halveEvens :: [Int] -> Bool
prop_halveEvens xs = halveEvens xs == halveEvensRec xs



-- 2. inRange

-- List-comprehension version
inRange :: Int -> Int -> [Int] -> [Int]
inRange lo hi xs = [ x | x <- xs , x >= lo , x <= hi ]

-- Recursive version
inRangeRec :: Int -> Int -> [Int] -> [Int]
inRangeRec lo hi []                          = []
inRangeRec lo hi (x:xs) | x >= lo && x <= hi = x : inRangeRec lo hi xs
                        | otherwise          = inRangeRec lo hi xs

-- Mutual test
prop_inRange :: Int -> Int -> [Int] -> Bool
prop_inRange lo hi xs = inRange lo hi xs == inRangeRec lo hi xs



-- 3. sumPositives: sum up all the positive numbers in a list

-- List-comprehension version
countPositives :: [Int] -> Int
countPositives xs = length [ x | x <- xs , x > 0 ]

-- Recursive version
countPositivesRec :: [Int] -> Int
countPositivesRec []                 = 0
countPositivesRec (x:xs) | x > 0     = 1 + countPositivesRec xs
                         | otherwise = countPositivesRec xs

-- Mutual test
prop_countPositives :: [Int] -> Bool
prop_countPositives xs = countPositives xs == countPositivesRec xs

-- 3(d) Just because the function length itself is a recursion function?

-- 4. pennypincher

-- Helper function
discount :: Int -> Int
discount x = round ( 0.9 * fromIntegral (x))

-- List-comprehension version
pennypincher :: [Int] -> Int
pennypincher xs = sum [ discount x | x <- xs , discount x <= 19900 ]

-- Recursive version
pennypincherRec :: [Int] -> Int
pennypincherRec []                           = 0
pennypincherRec (x:xs) | discount x <= 19900 = discount x + pennypincherRec xs
                       | otherwise           = pennypincherRec xs

-- Mutual test
prop_pennypincher :: [Int] -> Bool
prop_pennypincher xs = pennypincher xs == pennypincherRec xs



-- 5. sumDigits

-- List-comprehension version
multDigits :: String -> Int
multDigits xs = product [ digitToInt x | x <- xs , isDigit x == True ]

-- Recursive version
multDigitsRec :: String -> Int
multDigitsRec []                         = 1
multDigitsRec (x:xs) | isDigit x == True = digitToInt x * multDigitsRec xs
                     | otherwise         = multDigitsRec xs

-- Mutual test
prop_multDigits :: String -> Bool
prop_multDigits xs = multDigits xs == multDigitsRec xs



-- 6. capitalise

-- List-comprehension version
capitalise :: String -> String
capitalise (x:xs) = toUpper x : [ toLower x | x <- xs ]

-- Recursive version

capitaliseRec :: String -> String
capitaliseRec (x:xs) = toUpper x : helperRec xs
helperRec :: String -> String
helperRec [] = []
helperRec (x:xs) = toLower x : xs

-- Mutual test
prop_capitalise :: String -> Bool
prop_capitalise xs = capitalise xs == capitaliseRec xs



-- 7. title

-- List-comprehension version
title :: [String] -> [String]
title (xs:xss) = capitalise xs : [if length xs >= 4 then capitalise xs else [toLower x | x <- xs] | xs <- xss]

-- Recursive version
titleHelper :: [String] -> [String]
titleHelper []                        = []
titleHelper (xs:xss) | length xs >= 4 = capitalise xs : titleHelper xss
                     | otherwise      = helperRec xs : titleHelper xss
titleRec :: [String] -> [String]
titleRec (xs:xss) = capitalise xs : titleHelper xss

-- mutual test
prop_title :: [String] -> Bool
prop_title xs = title xs == titleRec xs




-- Optional Material

-- 8. crosswordFind

-- List-comprehension version
crosswordFind :: Char -> Int -> Int -> [String] -> [String]
crosswordFind c w l xss = [ xs | xs <- xss, length xs == l && c == xs !! w ]

-- Recursive version
crosswordFindRec :: Char -> Int -> Int -> [String] -> [String]
crosswordFindRec letter pos len []                                                 = []
crosswordFindRec letter pos len (xs:xss) | length xs == len && xs !! pos == letter = xs : crosswordFindRec letter pos len xss
                                         | otherwise                               = crosswordFindRec letter pos len xss

-- Mutual test
prop_crosswordFind :: Char -> Int -> Int -> [String] -> Bool
prop_crosswordFind = undefined 



-- 9. search

-- List-comprehension version

search :: String -> Char -> [Int]
search string goal = [ i | (char,i) <- zip string [0..] , char == goal ]

-- Recursive version
searchRec :: String -> Char -> [Int]
searchRec string goal = searchAux string goal 0
  where
    searchAux [] goal i = []
    searchAux (x:xs) goal i | x == goal  = i : searchAux xs goal (i+1)
                            | otherwise  = searchAux xs goal (i+1)

-- Mutual test
prop_search :: String -> Char -> Bool
prop_search = undefined


-- 10. contains

suffixes :: String -> [String]
suffixes xs = [drop i xs | i <- [0..length xs]]

-- List-comprehension version
contains :: String -> String -> Bool
contains str substr = [] /= [True|s<-suffixes str, isPrefixOf substr s]

-- Recursive version
containsRec :: String -> String -> Bool
containsRec _ [] = True
containsRec [] _ = False
containsRec str substr = isPrefixOf substr str || containsRec (tail str) substr

-- Mutual test
prop_contains :: String -> String -> Bool
prop_contains = undefined

