let new_ba num_items =
  Array.create num_items 0.0
;;

let fill_ba ba offset =
  let num_items = Array.length ba in
  let pi = 4.0 *. atan 1.0 in
  for i = 0 to num_items - 1 do
    let x = pi *. (float_of_int i) /. (float_of_int num_items) in
    ba.(i) <- sin (x +. offset)
  done
;;

let sum_ba c a b =
  let num_items = Array.length c in
    for i = 0 to num_items - 1 do
      c.(i) <- a.(i) +. b.(i)
    done
;;

let norm_ba_forloop a =
  let result = ref 0.0 in
  let n = Array.length a in
  let () =
    for i = 0 to n - 1; do
      result := !result +. a.(i)*.a.(i)
    done
  in sqrt (!result /. (float_of_int n))
;;

(*
 * Recursive version of the function above.
 * This is roughly 4 time slower than the for-loop variant.
 *)
let norm_ba_recursive a =
  let rec sum_squares total prev_idx =
    if prev_idx > 0 then
      let idx = prev_idx - 1
      in sum_squares (total +. a.(idx)*.a.(idx)) idx
    else
      total
  in
  let n = Array.length a
  in sqrt ((sum_squares 0.0 n) /. (float_of_int n))
;;

let norm_ba = norm_ba_forloop;;

let () =
  let n = 50*1000*1000 in
  let a = new_ba n in
  let b = new_ba n in
  let c = new_ba n in
  let t0 = Unix.gettimeofday() in
  let () = fill_ba a 1.5 in
  let () = fill_ba b 0.25 in
  let t1 = Unix.gettimeofday() in
  let () = sum_ba c a b in
  let t2 = Unix.gettimeofday() in
  let diff = norm_ba c in
  let t3 = Unix.gettimeofday() in
  begin
    Printf.printf "Diff is %g\n" diff;
    Printf.printf "Fill time %g s\n" (t1 -. t0);
    Printf.printf " Sum time %g s\n" (t2 -. t1);
    Printf.printf "Diff time %g s\n" (t3 -. t2);
  end
;;
