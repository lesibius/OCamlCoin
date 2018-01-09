type t =
  | STARTOFBLOCK of string * string
  | LINK of Transaction.t * t

let start_block prev_hash this_hash =
  STARTOFBLOCK (prev_hash, this_hash)

let add_transaction transaction = function
  | STARTOFBLOCK (h1,h2) -> LINK (transaction, STARTOFBLOCK (h1,h2))
  | link -> LINK (transaction,link)

let to_string blk =
  let rec aux acc = function
    | STARTOFBLOCK (prev_hash, this_hash) -> acc ^ "BLK" ^ this_hash
    | LINK (tr, rest) -> aux ((tr |> Transaction.to_string) ^ "\n" ^ acc) rest in
  aux "" blk
