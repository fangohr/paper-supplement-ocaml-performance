(*
 * Create an array of rank-3 tensors, populate them and compute their norm.
 * In this example, the tensors are all stored inside a single bigarray.
 *)

(* Optimize OCaml performance:
   - Use specialization of bigarrays to 3 dimensions.
   - Annotate functions with concrete bigarray type so that the compiler knows
     it need not generate polymorphic code (allows more inlining, etc.).
   - Compile with -unsafe to disable array bounds checking.
*)

type tensor_array =
  (float, Bigarray.float64_elt, Bigarray.c_layout) Bigarray.Array3.t array

let pi = 4.0 *. atan 1.0;;

(* Create one array of n 3-rank tensors of size d*d*d. *)
let create_tensors n d =
  Array.init n
    (fun _ -> Bigarray.Array3.create Bigarray.float64 Bigarray.c_layout d d d)
;;

(* Initialise a tensor. *)
let init_tensors (tensors : tensor_array) =
  let n = Array.length tensors in
  let d = Bigarray.Array3.dim1 tensors.(0) in
  let fd3 = float_of_int (d*d*d) in
  let omega = 0.2*.pi in
  for i = 0 to n - 1; do
    let x = (float_of_int i)/.(float_of_int n) in
    for j = 0 to d - 1; do
      for k = 0 to d - 1; do
        for l = 0 to d - 1; do
          (*
           * dx goes from 0 to 1 while going through the tensor components.
           * x goes from 0 to 1 while going from first to last tensor.
           *)
          let dx = (float_of_int (l + (k + j*d)*d)) /. fd3 in
          tensors.(i).{j, k, l} <- sin (omega*.(x +. dx));
        done
      done
    done
  done
;;

let sum_all (tensors : tensor_array) =
  let result = ref 0.0 in
  let n = Array.length tensors in
  let d = Bigarray.Array3.dim1 tensors.(0) in
  let () =
    for i = 0 to n - 1; do
      for j = 0 to d - 1; do
        for k = 0 to d - 1; do
          for l = 0 to d - 1; do
            let v = tensors.(i).{j, k, l} in
            result := !result +. v*.v;
          done
        done
      done
    done
  in sqrt (!result /. (float_of_int (n*d*d*d)))
;;

let () =
  let d = 3 in
  let n = 1000*1000 in
  let t0 = Unix.gettimeofday() in
  let tensors = create_tensors n d in
  let t1 = Unix.gettimeofday() in
  let () = init_tensors tensors in
  let t2 = Unix.gettimeofday() in
  let result = sum_all tensors in
  let t3 = Unix.gettimeofday() in
  begin
    Printf.printf "Sum is %g\n" result;
    Printf.printf "Create time %g s\n" (t1 -. t0);
    Printf.printf "  Init time %g s\n" (t2 -. t1);
    Printf.printf "   Sum time %g s\n" (t3 -. t2);
  end
;;
