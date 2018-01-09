type t =
  {
    sender:string;
    receiver:string;
    amount:int
  }

let make sender receiver amount =
  {
    sender=sender;
    receiver=receiver;
    amount=amount
  }


let to_string = function
    {
      sender=sndr; receiver=rcvr; amount=amt
    } -> "[" ^sndr ^";" ^ rcvr ^ ";" ^ (amt |> string_of_int) ^ "]"

