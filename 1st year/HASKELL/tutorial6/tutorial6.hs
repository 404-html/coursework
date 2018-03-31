-- Informatics 1 Functional Programming
-- Tutorial 6
--
-- Due: 6/7 November

import System.Random


-- Importing the keymap module

import KeymapTree


-- Type declarations

type Barcode = String
type Product = String
type Unit    = String

type Item    = (Product,Unit)

type Catalogue = Keymap Barcode Item


-- A little test catalog

testDB :: Catalogue
testDB = fromList [
 ("0265090316581", ("The Macannihav'nmor Highland Single Malt", "75ml bottle")),
 ("0903900739533", ("Bagpipes of Glory", "6-CD Box")),
 ("9780201342758", ("Thompson - \"Haskell: The Craft of Functional Programming\"", "Book")),
 ("0042400212509", ("Universal deep-frying pan", "pc"))
 ]


-- Exercise 1

longestProductLen :: [(Barcode, Item)] -> Int
longestProductLen xs = maximum [length a +length b +length c|(a,(b,c))<-xs]

formatLine :: Int -> (Barcode, Item) -> String
formatLine l (x,(y,z)) = x ++ "..." ++ addto l y ++ "..." ++ z
 where
  addto l x |length x >= l = x
            |otherwise = x ++ replicate (l-(length x)) '.'

showCatalogue :: Catalogue -> String
showCatalogue xs = unlines [formatLine (maxlength xs) x | x <- (toList xs)]
 where
  maxlength xs = maximum [length y|(x,(y,z))<-(toList xs)]
     
-- Exercise 2

--2(a) Four items and Nothing.

maybeToList :: Maybe a -> [a]
maybeToList (Nothing) = []
maybeToList (Just xs) = [xs]

listToMaybe :: [a] -> Maybe a
listToMaybe [] = Nothing
listToMaybe xs = Just (head xs)

catMaybes :: [Maybe a] -> [a]
catMaybes xs = concat (map maybeToList xs)

-- Exercise 3

getItems :: [Barcode] -> Catalogue -> [Item]
getItems xs ys = catMaybes [get x ys|x<-xs]

--4(a)1.47secs
---(b)0.02s 0.22s
--    0.02s 0.09s
--    0.03s 0.32s
--    0.02s 0.00s
--    0.02s 0.05s
--    0.02s 0.02s
--    0.02s 0.03s
--    0.02s 0.03s
--    0.02s 0.02s
--    0.02s 0.00s
-- ave0.02s 0.08s
---(c)will double

--5 Not in scope

--11 (a)15.85secs
--   (b)0.25s 0.31s
--      0.27s 0.37s
--      0.25s 0.25s
--      0.19s 0.06s
--      0.33s 0.42s
--      0.25s 0.34s
--      0.34s 0.55s
--      0.31s 0.44s
--      0.23s 0.22s
--      0.22s 0.14s
--ave   0.26s 0.31s
--   (c)104651records

-- Input-output ------------------------------------------

readDB :: IO Catalogue
readDB = do dbl <- readFile "database.csv"
            let db = fromList (map readLine $ lines dbl)
            putStrLn (size db >= 0 `seq` "Done")
            return db

readLine :: String -> (Barcode,Item)
readLine str = (a,(c,b))
    where
      (a,str2) = splitUpon ',' str
      (b,c)    = splitUpon ',' str2

splitUpon :: Char -> String -> (String,String)
splitUpon _ "" = ("","")
splitUpon c (x:xs) | x == c    = ("",xs)
                   | otherwise = (x:ys,zs)
                   where
                     (ys,zs) = splitUpon c xs

getSample :: Catalogue -> IO Barcode
getSample db = do g <- newStdGen
                  return $ fst $ toList db !! fst (randomR (0,size db - 1) g)
