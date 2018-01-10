open Core;;

let () =
  let tr1 = Transaction.make "Clem" "Andrey" 42 in
  let tr2 = Transaction.make "Chrystal" "Andrey" 42 in
  let tr3 = Transaction.make "Andrey" "Clem" 42 in
  let blk = Block.start_block "123" "456" in
  let blk = blk |> (Block.add_transaction tr1) in
  let blk = blk |> (Block.add_transaction tr2) in
  let blk = blk |> (Block.add_transaction tr3) in
  let blk1 = Block.update_block_id blk "457" in
  blk |> Block.to_string |> print_endline;
  blk |> Block.hash_of_block |> print_endline;
  blk1|> Block.to_string |> print_endline;
  blk1|> Block.hash_of_block |> print_endline;
  
  

