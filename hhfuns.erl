%% higher order functions
-module(hhfuns).
-compile(export_all).

one() -> 1.
two() -> 2.

add(X,Y) -> X() +Y().



increment([]) -> [];
increment([H|T]) -> [H+1| increment(T)].

decrement([]) -> [];
decrement([H|T]) -> [H-1|decrement(T)].


%% above function does the same thing increment or decrement we can make this higher order function.
map(_, []) -> [];
map(F, [H|T]) -> [F(H)| map(F,T)].

incr(X) -> X+1.
decr(X) -> X-1.


%% scope
a() ->
Secret = "pony",
fun() -> Secret end.
 
b(F) ->
"a/0's password is "++F().


even(L) -> lists:reverse(even(L,[])).
 
even([], Acc) -> Acc;
even([H|T], Acc) when H rem 2 == 0 ->
even(T, [H|Acc]);
even([_|T], Acc) ->
even(T, Acc).


%% higher order abstract function
%% hhfuns:filter(fun(X) -> X rem 2 == 0 end, Numbers).
%% People = [{male,45},{female,67},{male,66},{female,12},{unknown,174},{male,74}].

% hhfuns:filter(fun({Gender,Age}) -> Gender == male andalso Age > 60 end, People).
filter(Pred, L) -> lists:reverse(filter(Pred,L, [])).

filter(_, [], Acc) -> Acc;
filter(Pred, [H|T], Acc) ->
  case Pred(H) of 
    true -> filter(Pred, T, [H| Acc]);
    false -> filter(Pred, T, Acc)
  end.

% PrepareAlarm = fun(Room) ->
%     io:format("Alarm set in ~s.~n",[Room]),
%     fun() -> 
%       io:format("Alarm tripped in ~s! Call Batman!~n",[Room])
%     end
%   end.


case "Unexpected Value" of
  expected_value -> ok;
  other_expected_value -> 'also ok'
end.