import qualified Data.ByteString.Char8 as C8
import Data.Char (toUpper)

main :: IO ()
main = do
  let inputString = "Hello, ByteString!"
  let byteString = C8.pack inputString

  -- Display the original ByteString
  putStrLn "Original ByteString:"
  print byteString

  -- Convert ByteString to String, perform operations, and convert back to ByteString
  let modifiedString = map toUpper (C8.unpack byteString)
  let modifiedByteString = C8.pack modifiedString

  -- Display the modified ByteString
  putStrLn "Modified ByteString:"
  print modifiedByteString
