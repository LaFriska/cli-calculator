module Parser where 
    
data Operator = Plus | Minus | Times | Divide

instance Show Operator where
    show Plus = "+"
    show Minus = "-"
    show Times = "*"
    show Divide = "/"

data Equation = Num Float 
              | Node Operator Equation Equation

data EquationErr = Eq Equation | Err String 
data StringErr = Str String | Err String
              
instance Show Equation where 
    show eq = case eq of 
        Num f             -> show f 
        Node op sub1 sub2 -> (wrap sub1) ++ " " ++ (show op) ++ " " ++ (wrap sub2)
        where
        wrap :: Equation -> String
        wrap subeq = case subeq of 
            Num _      -> show subeq
            Node _ _ _ -> "(" ++ (show subeq) ++ ")"

parse :: String -> EquationErr
parse string = undefined

-- Returns a Maybe EquationErr surrounded by an outher layer of brackets, or error
-- if there is a bracket mismatch, or Nothing if no brackets are found. 
getSubequation :: String -> Int -> Bool -> Maybe StringErr -> 
getSubequation str bracketCount hasBracket currentSub = case (bracketCount, hasBracket) of --TODO
    (0, True)  -> Just (Str currentSub)
    (0, False) -> case str of
        []   -> Nothing 
        x:xs -> undefined 
    (_, True)  -> undefined 