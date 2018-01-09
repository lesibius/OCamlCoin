type t =
  {
    sender:string;
    receiver:string;
    amount:int
  }

val make: string -> string -> int -> t

val to_string: t -> string



                                  
      
