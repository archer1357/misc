
module Hello where

{-
aaa = [x | x <- [1 .. 15], mod x 2 == 0]
aa x = 1 + x
bb y = 2 + y
cc = aa . bb
getLine2 = do x <- getChar
              if x == '\n' then
                return []
              else
                do xs <- getLine
                   return (x:xs)


llen = do putStr "Enter:"
          xs <- getLine
          putStrLn (show (length xs))

data Shape = Circle | Square deriving (Show)
--instance Show Shape where
--  show(Circle) = "aCircle"
--  show(Square) = "aSquare"
--main = putStrLn "Hello world!"
main = print(- 4)
-}




partition _ [] = ([],[])

partition x (y:ys)
  | y <= x = (y:qs,rs)
  | otherwise = (qs,y:rs)
  where (qs,rs) = partition x ys

qsort [] = []

qsort (x:xs) =
  qsort ls ++ [x] ++ qsort rs
  where --(ls,rs) = partition x xs
        ls = [y | y <- xs, y <= x]
        rs = [y | y <- xs, y > x]
        --ls = filter (<= x) xs
        --rs = filter (x <) xs

-- split [] (ys,zs) = (ys,zs)

-- split (a:b:xs) (ys,zs) =
--   split xs (a:ys, b:zs)

-- split [x] (ys,zs) =
--   (x:ys, zs)

split [] = ([],[])

split [x] = ([x],[])

split (a:b:xs) = (a:as,b:bs) where (as, bs) = split(xs)


merge xs [] = xs

merge [] ys = ys

merge xx@(x:xs) yy@(y:ys)
  | x <= y = x : merge xs yy
  | otherwise = y : merge xx ys

msort [] = []

msort [x] = [x]

msort xs =
  merge (msort ls) (msort rs)
  where (ls,rs) = split xs

ordered [] = True

ordered [x] = True

ordered (a:b:xs) =
  a <= b && ordered (b:xs)

shift [] = []

shift [x] = [x]

shift (a:b:xs)
  | a <= b = a:(shift (b:xs))
  | otherwise = b:(shift (a:xs))

bsort [] = []

bsort [x] = [x]

bsort xs =
  if ordered xs then xs
  else bsort (shift xs)


  -- where l = filter (<= x) xs
  --       r = filter (> x) xs

-- myadd x y = x + y

myfun l r = (l,r)
--main=print ((myfun 1) 2)
main = print $ (qsort [5,8,4,3,1,2,9,3] :: [Int])
--main = print [1:2]

-- main = print (part 5 [] :: [Int])
-- --main = print (myadd 5 6)
--bla x y = x <= y

--main = print (filter (<= 3)  [1,2,3,4,5])

--main = print (split2 [1,2,3,4,5,6,7])

--main = print (bsort [7,5,2,1,2,3] :: [Int])

--main = print (q 5 [2,6,5,4,1,2,3,9] :: ([Int],[Int]))
