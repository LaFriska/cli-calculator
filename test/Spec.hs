import System.Exit (exitFailure)
import Test.HUnit
import Parser (getSubequation)

--cabal test --test-show-details=always


main :: IO ()
main = do
  counts <- runTestTT seSimples
  print counts
  if failures counts > 0 || errors counts > 0
    then exitFailure
    else return ()
    
str1 = "The quick brown fox jumped over the lazy dog."

seSimple1 = TestCase (assertEqual "for strings with no brackets." str1 (se str1))

seSimple2 = TestCase (assertEqual "for one bracket pair." 
                                  "fox jumped over" 
                               (se "The quick brown (fox jumped over) the lazy dog."))

seSimple3 = TestCase (assertEqual "for two bracket pairs." 
                                  "quick" 
                               (se "The (quick) brown (fox jumped over) the lazy dog."))

seSimple4 = TestCase (assertEqual "for nested bracket pairs." 
                                  "fox (jumped over)" 
                               (se "The quick brown (fox (jumped over)) the lazy dog."))

seSimple5 = TestCase (assertEqual "for mismatched brackets." 
                                  "Nothing" 
                               (se "The quick brown ((fox (jumped over)) the lazy dog."))

seSimple6 = TestCase (assertEqual "for mismatched brackets." 
                                  "Nothing" 
                               (se "The quick brown (fox (jumped over)) the la)zy dog."))
                               
seSimple7 = TestCase (assertEqual "for trivial brackets" 
                                  "" 
                               (se "()"))
                               
seSimple8 = TestCase (assertEqual "for mismatched brackets." 
                                  "Nothing" 
                               (se "The quick ) (fox (jumped over)) the lazy dog."))

seSimples = TestList [
    TestLabel "Subequation Simple 1" seSimple1,
    TestLabel "Subequation Simple 2" seSimple2,
    TestLabel "Subequation Simple 3" seSimple3,
    TestLabel "Subequation Simple 4" seSimple4,
    TestLabel "Subequation Simple 4" seSimple5,
    TestLabel "Subequation Simple 4" seSimple6,
    TestLabel "Subequation Simple 4" seSimple7,
    TestLabel "Subequation Simple 4" seSimple8
    ]

se :: String -> String 
se str = maybeToString (getSubequation str)

maybeToString :: Maybe String -> String 
maybeToString x = case x of 
    Just a -> a
    Nothing -> "Nothing"
