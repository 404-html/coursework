-- Informatics 1 - Functional Programming 
-- Tutorial 2
--
-- Week 4 - due: 9/10 Oct.

import Data.Char
import Data.List
import Test.QuickCheck


-- 1.
rotate :: Int -> [Char] -> [Char]
rotate n xs | n >=0 && n <= length xs = drop n xs ++ take n xs
            | otherwise = error "error"

-- 2.
prop_rotate :: Int -> String -> Bool
prop_rotate k str = rotate (l - m) (rotate m str) == str
                        where l = length str
                              m = if l == 0 then 0 else k `mod` l
--(a) it tests backwards after a test to make sure it returns to original value.
--(b) it uses two function to deal with large or negative numbers.

-- 3. 
makeKey :: Int -> [(Char, Char)]
makeKey x = zip alp (rotate x alp)
 where
   alp = ['A'..'Z']
-- 4.
lookUp :: Char -> [(Char, Char)] -> Char
lookUp key string = head ([ y | ( x , y ) <- string , x == key ] ++ [key])

lookUpRec :: Char -> [(Char, Char)] -> Char
lookUpRec key [] = key
lookUpRec key (x:xs)|key == fst x = snd x
                    |otherwise = lookUpRec key xs

prop_lookUp :: Char -> [(Char, Char)] -> Bool
prop_lookUp x y = lookUp x y == lookUpRec x y

-- 5.
encipher :: Int -> Char -> Char
encipher x y = lookUp y (makeKey x)

-- 6.
normalize :: String -> String
--normalize [] = []
--normalize (x:xs)|isAlpha x = toUpper x : normalize xs
--                |isDigit x = x :normalize xs
--               |otherwise = normalize xs
normalize xs = [toUpper x|x<-xs,isAlpha x||isDigit x]
-- 7.
encipherStr :: Int -> String -> String
encipherStr w xs = [encipher w x | x <- normalize xs]

-- 8.
reverseKey :: [(Char, Char)] -> [(Char, Char)]
reverseKey xs = [(y,x)|(x,y)<-xs]

reverseKeyRec :: [(Char, Char)] -> [(Char, Char)]
reverseKeyRec [] = []
reverseKeyRec (x:xs) = rev x : reverseKeyRec xs
 where
   rev (a,b) = (b,a)

prop_reverseKey :: [(Char, Char)] -> Bool
prop_reverseKey xs = reverseKey xs == reverseKeyRec xs

-- 9.
decipher :: Int -> Char -> Char
decipher k x = lookUp x (reverseKey (makeKey k))

decipherStr :: Int -> String -> String
decipherStr k xs = [decipher k x | x <- normalize xs]

-- 10.
contains :: String -> String -> Bool
--contains str substr = [s| s <- suffixes str, (isPrefixOf substr s)==True] /= []
-- where
--  suffixes xs = [drop i xs|i<-[0..length xs]]
contains _ []      = True
contains [] substr = False
contains str substr |isPrefixOf substr str = True
                    |otherwise = contains (tail str) substr

-- 11.
candidates :: String -> [(Int, String)]
candidates xs = [(key,decipherStr key xs)|key<-[1..26],contains (decipherStr key xs) "THE" ||
                                                       contains (decipherStr key xs) "AND" ]



-- Optional Material

-- 12.
splitEachFive :: String -> [String]
splitEachFive []=[]
splitEachFive xs |length xs >= 5 = take 5 xs : splitEachFive (drop 5 xs)
                 |otherwise  = [xs ++ (replicate (5-(length xs)) 'X')]

-- 13.

prop_transpose :: [String] -> Bool
prop_transpose str = transpose (transpose str)==str

--It is False when a list is shorter than the next one.
--e.g.["1","22","333"]

-- 14.
encrypt :: Int -> String -> String
encrypt x str = concat (transpose (splitEachFive (encipherStr x str)))

-- 15.
codeLength :: String -> Int
codeLength xs = div (length xs) 5 
splitHelpA :: Int -> String -> [String]
splitHelpA l [] = []
splitHelpA l xs |length xs >= l = take l xs : splitHelpA l (drop l xs)
                |otherwise      = []
splitHelp :: String -> [String]
splitHelp xs = splitHelpA (codeLength xs) xs

decrypt :: Int -> String -> String
decrypt x str = decipherStr x (concat (transpose (splitHelp str)))

-- Challenge (Optional)

-- 16.
countFreqs :: String -> [(Char, Int)]
countFreqs = undefined

-- 17
freqDecipher :: String -> [String]
freqDecipher = undefined
