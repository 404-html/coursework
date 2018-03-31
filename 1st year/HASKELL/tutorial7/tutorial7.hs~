-- Informatics 1 - Functional Programming 
-- Tutorial 7
--
-- Week 9 - Due: 13/14 Nov.


import LSystem
import Test.QuickCheck

-- Exercise 1

-- 1a. split
split :: Command -> [Command]
split (x :#: y) = split x ++ split y
split (Sit) = []
split (x) = [x]

-- 1b. join
join' :: [Command] -> Command
join' (x:xs) = x :#: join' xs
join' [] = (Sit)

unsit :: Command -> Command
unsit (x :#: y)|y== Sit = x
               |otherwise = x :#: unsit y

-- 1c  equivalent
equivalent :: Command -> Command -> Bool
equivalent x y = split x == split y

-- 1d. testing join and split
prop_split_join :: Command -> Bool
prop_split_join x = equivalent (join' (split x)) x

prop_split :: Command -> Bool
prop_split x =not(elem Sit (split x))


-- Exercise 2
-- 2a. copy
copy :: Int -> Command -> Command
copy 1 (x) = x
copy i (x) | i >=2 = x :#: copy (i-1) x

-- 2b. pentagon
pentagon :: Distance -> Command
pentagon x = copy 5 (Go x :#: Turn 72)

-- 2c. polygon
polygon :: Distance -> Int -> Command
polygon x y = copy y (Go x :#: Turn (fromIntegral(div 360 y)))



-- Exercise 3
-- spiral
spiral :: Distance -> Int -> Distance -> Angle -> Command
spiral x y z w |y>=2 = Go x :#: Turn w :#: spiral (x+z) (y-1) z w
               |otherwise = Go x :#: Turn w


-- Exercise 4
-- optimise
optimise :: Command -> Command
optimise xs =unsit ( join' ([x|x<-eliminate (split xs), x/=Sit, x/= Turn 0, x/=Go 0]))
 where
  eliminate (Go x:Go y:xs)= eliminate (Go (x+y):xs)
  eliminate (Turn x: Turn y:xs) = eliminate (Turn (x+y):xs)
  eliminate (x:y:ys) = x:eliminate (y:ys)
  eliminate (x) = []


-- L-Systems

-- 5. arrowhead
arrowhead :: Int -> Command
arrowhead x = f x
 where
 f 0 = Go 10
 f x = g (x-1) :#: p :#: f (x-1) :#: p :#: g (x-1)
 g 0 = Go 10
 g x = f (x-1) :#: n :#: g (x-1) :#: n :#: f (x-1)
 n   = Turn 60
 p   = Turn (-60)

-- 6. snowflake
snowflake :: Int -> Command
snowflake x = f x :#: n :#: n :#: f x :#: n :#: n :#: f x :#: n :#: n
 where
 f 0 = Go 10
 f x = f (x-1) :#: p :#: f (x-1) :#: n :#: n :#: f (x-1) :#: p :#: f (x-1)
 n   = Turn 60
 p   = Turn (-60)

-- 7. hilbert
hilbert :: Int -> Command
hilbert x = l x
 where
  l 0 = Go 0
  l x = p :#: r (x-1) :#: f :#: n :#: l (x-1) :#: f :#: l (x-1) :#: n :#: f :#: r (x-1) :#: p
  r 0 = Go 0
  r x = n :#: l (x-1) :#: f :#: p :#: r (x-1) :#: f :#: r (x-1) :#: p :#: f :#: l (x-1) :#: n
  f   = Go 10
  n   = Turn 90
  p   = Turn (-90)

