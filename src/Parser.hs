module Parser (getSubequation) where 
    
data Operator = Plus | Minus | Times | Divide

instance Show Operator where
    show Plus = "+"
    show Minus = "-"
    show Times = "*"
    show Divide = "/"

data Equation = Num Float 
              | Node Operator Equation Equation

              
instance Show Equation where 
    show eq = case eq of 
        Num f             -> show f 
        Node op sub1 sub2 -> (wrap sub1) ++ " " ++ (show op) ++ " " ++ (wrap sub2)
        where
        wrap :: Equation -> String
        wrap subeq = case subeq of 
            Num _      -> show subeq
            Node _ _ _ -> "(" ++ (show subeq) ++ ")"

parse :: String -> Maybe Equation 
parse string = undefined


getSubequation :: String -> Maybe String 
getSubequation str = recurseSubequation str 0 False ""


-- Returns a Maybe EquationErr surrounded by an outher layer of brackets, or error
-- if there is a bracket mismatch, or Nothing if no brackets are found. 
recurseSubequation :: String -> Int -> Bool -> String -> Maybe String
recurseSubequation str bracketCount hasBracket currentSub = case (bracketCount, hasBracket) of --TODO
    (0, True)  -> Just currentSub
    (0, False) -> case str of
        []   -> Just currentSub 
        x:xs
            | x == '('  -> recurseSubequation xs (bracketCount + 1) True ""
            | x == ')' -> Nothing
            | otherwise -> recurseSubequation xs 0 False (currentSub ++ [x])
    (_, True)  -> case str of 
        [] ->  Nothing
        x:xs
            | x == '(' -> recurseSubequation xs (bracketCount + 1) True (currentSub ++ [x])
            | x == ')' -> if bracketCount == 1 then recurseSubequation xs (bracketCount - 1) True currentSub
                                               else recurseSubequation xs (bracketCount - 1) True (currentSub ++ [x])
            | otherwise -> recurseSubequation xs bracketCount True (currentSub ++ [x])
    (_, False) -> Nothing 