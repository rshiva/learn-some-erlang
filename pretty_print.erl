-module(pretty_print).
-compile(export_all).


print({num, N}) ->
  integer_to_list(N);
print({var, A}) ->
  atom_to_list(A);
print({add, E1, E2}) ->
  "(" ++ print(E1) ++ "+" ++ print(E2) ++ ")";
print({mult, E1, E2}) ->
  "(" ++ print(E1) ++ "*" ++ print(E2) ++ ")";
print({divi, E1, E2}) ->
  "(" ++ print(E1) ++ "/" ++ print(E2) ++ ")";
print({sub, E1, E2}) ->
  "(" ++ print(E1) ++ "-" ++ print(E2) ++ ")".



%%pretty_print:print({add, {num,2},{mult, {num,3}, {num,4}}}).