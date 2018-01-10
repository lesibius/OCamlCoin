type t =
  | STARTOFBLOCK of string * string
  | LINK of Transaction.t * t

val start_block: string -> string -> t

val to_string: t -> string

val add_transaction: Transaction.t -> t -> t

val hash_of_block: t -> string

val get_hashes: t -> string * string

val to_transaction_list: t -> Transaction.t list

val update_block_id: t -> string -> t
