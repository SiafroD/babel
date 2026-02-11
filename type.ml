type typ = Byte, Short, Int, Long, Float, Double, Boolean, Char

let string_of_type t =
  match t with
  | Byte -> "Byte"
  | Short -> "Short"
  | Int -> "Int"
  | Long -> "Long"
  | Float -> "Float"
  | Double -> "Double"
  | Boolean -> "Boolean"
  | Char -> "Char"

