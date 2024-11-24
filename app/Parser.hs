module Parser where 
    
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