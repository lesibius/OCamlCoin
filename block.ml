type t =
  | STARTOFBLOCK of string * string
  | LINK of Transaction.t * t

(* Initiate a new block using the previous block ID and a new block ID *)
let start_block prev_id this_id =
  STARTOFBLOCK (prev_id, this_id)

(* Add a transaction to a block *)
let add_transaction transaction = function
  | STARTOFBLOCK (id1,id2) -> LINK (transaction, STARTOFBLOCK (id1,id2))
  | link -> LINK (transaction,link)

(* String representation of a block
   Also used to generate the hashcode of the block *)
let to_string blk =
  let rec aux acc = function
    | STARTOFBLOCK (prev_id, this_id) -> acc ^ "BLK" ^ this_id ^ "PREV" ^ prev_id
    | LINK (tr, rest) -> aux ((tr |> Transaction.to_string) ^ "\n" ^ acc) rest in
  aux "" blk

(* *)
let hash_of_block blk =
  let str_blk = to_string blk in
  let hash_fun = Cryptokit.Hash.sha3 256 in
  str_blk |> (Cryptokit.hash_string hash_fun)

let get_hashes blk =
  let rec aux = function
    | STARTOFBLOCK (prev_hash, this_hash) -> (prev_hash, this_hash)
    | LINK (tr, rest) -> aux rest in
  aux blk

let to_transaction_list blk =
  let rec aux acc = function
    | STARTOFBLOCK (h1, h2) -> acc
    | LINK (tr, rest) -> aux (tr :: acc) rest in
  aux [] blk

let update_block_id blk new_id =
  let prev_id, curr_id = blk |> get_hashes in
  let transaction_list = blk |> to_transaction_list in
  let new_blk = start_block prev_id new_id in
  let rec aux acc = function
    | [] -> acc
    | h :: t -> aux (add_transaction h acc) t in
  aux new_blk transaction_list
      
