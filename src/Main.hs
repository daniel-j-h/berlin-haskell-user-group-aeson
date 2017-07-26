{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Main where

import qualified Control.Lens as Lens
import Data.Aeson
import Data.Aeson.Types
import Data.Aeson.Lens
import Data.Monoid
import Data.Text
import GHC.Generics

--instance FromJSON T where
--  parseJSON (Object v)
--  parseJSON _ = mzero

--instance ToJSON T where
--  toJSON (T a b) = object [ .. ]

-- encode :: ToJSON a   => a          -> ByteString
-- decode :: FromJSON a => ByteString -> Maybe a 

--data Value
-- = Object HashMap Text Value
-- | Array Vector Value
-- | String Text
-- | Number Scientific
-- | Bool Bool
-- | Null


-- object :: [Pair] -> Value

obj :: Value
obj = object [
    "a" .= True
  , "b" .= (5.1 :: Double) ]

-- Parser a

-- parseMaybe :: (a -> Parser b) -> a -> Maybe b 

-- withObject :: String -> (Object -> Parser a) -> Value -> Parser a


data Person = Person
  { name :: String
  , age  :: Int }
  deriving (Show)

instance FromJSON Person where
  parseJSON (Object o) = Person <$>
    o .: "name" <*>
    o .: "age"

instance ToJSON Person where
  toJSON (Person name age) = object [
      "name" .= name
    , "age"  .= age ]


data Book = Book
  { isbn    :: String
  , summary :: Maybe String }
  deriving (Show, Generic)

instance FromJSON Book
instance ToJSON Book



main :: IO ()
main = do
  let encoded = encode ([2, 4, 6] :: [Int])
  let decoded = decode encoded :: Maybe [Int]

  print decoded

  print $ encode $ Person "Daniel" 27
  print $ (decode "{\"name\": \"Daniel\", \"age\": 27}" :: Maybe Person)

  --print $ (("{\"name\": \"Daniel\", \"age\": 27}" Lens.^? key "name" . _String) :: Maybe String)
  print $ ("1.3" :: String) Lens.^? _Number
  print $ ("{\"name\": \"Daniel\", \"age\": 27}" :: String) Lens.^? key "name" . _String
  print $ ("[{\"id\": 2}, {\"id\": 3}]" :: String) Lens.^? nth 0 . key "id" . _Integer

  putStrLn "bye"


