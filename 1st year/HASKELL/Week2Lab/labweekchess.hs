-- Informatics 1 - Functional Programming 
-- Lab week tutorial part II
--
--

import PicturesSVG
import Test.QuickCheck

-- Exercise 9:

pic1 :: Picture
pic1 = above (beside knight (invert knight)) (beside (invert knight) knight)
pic2 :: Picture
pic2 = above (beside knight (invert knight)) (flipV (beside knight (invert knight)))


-- Exercise 10:
-- a)

emptyRow :: Picture
emptyRow = repeatH 4 (beside whiteSquare blackSquare)

-- b)

otherEmptyRow :: Picture
otherEmptyRow = repeatH 4 (beside blackSquare whiteSquare)

-- c)

middleBoard :: Picture
middleBoard = repeatV 2 (above emptyRow otherEmptyRow)

-- d)
wRow :: Picture
wRow = beside rook (beside knight (beside bishop (beside queen (beside king (beside bishop (beside knight rook))))))

ePawn :: Picture
ePawn = repeatH 8 pawn

whiteRow :: Picture
whiteRow = over wRow otherEmptyRow

blackRow :: Picture
blackRow = over (invert wRow) emptyRow

-- e)

populatedBoard :: Picture
populatedBoard = above blackRow (above (over (invert ePawn) otherEmptyRow) (above middleBoard (above (over ePawn emptyRow) whiteRow)))



-- Functions --

twoBeside :: Picture -> Picture
twoBeside x = beside x (invert x)


-- Exercise 11:

twoAbove :: Picture -> Picture
twoAbove x = above x (invert x)

fourPictures :: Picture -> Picture
fourPictures x = twoAbove (twoBeside x)