type t =
  | STARTOFBLOCK of string * string
  | LINK of Transaction.t * t

val start_block: string -> string -> t

val to_string: t -> string

val add_transaction: Transaction.t -> t -> t
