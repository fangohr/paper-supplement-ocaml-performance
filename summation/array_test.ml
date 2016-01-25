let pi = 4.0 *. atan 1.0;;

let mysin value =
  let x = value -. (floor (value/.pi))*.pi
  in (x -. x*.x*.x/.6. +. x*.x*.x*.x*.x/.120.
      -. x*.x*.x*.x*.x*.x*.x/.5040.)
;;

let sum_ba offset1 offset2 num_items =
  let result = ref 0.0 in
  let () =
    for i = 0 to num_items - 1 do
      let a1 = mysin (pi *. (float_of_int i) /. (float_of_int num_items) +. offset1) in
      let a2 = mysin (pi *. (float_of_int i) /. (float_of_int num_items) +. offset2) in
      result := !result +. (a1 +. a2)*.(a1 +. a2);
    done
  in sqrt (!result /. (float_of_int num_items))
;;

let () =
  let n = 50*1000*1000 in
  let t1 = Unix.gettimeofday() in
  let diff = sum_ba 1.5 0.25 n in
  let t2 = Unix.gettimeofday() in
  begin
    Printf.printf "Diff is %g\n" diff;
    Printf.printf "Sum time %g s\n" (t2 -. t1);
  end
;;
