-module(functions).
-compile(export_all).

head([H | _ ]) ->
  H.
second([_ , X | _ ]) ->
  X.

%% when first value is passed to function the value to bound to that varible when second value
%% is passed if its same as X the statement is true
same(X,X) ->  
  true;
%%If the two values aren't the same, this will fail and go to the second function clause,
%% which doesn't care about its arguments
same(_,_) ->
  false.

%% This will work even we pass atom as input to function ..this where we use guard to check 
valid_time({Date={Y,M,D}, Time= {H,Min,S}}) ->
  io:format("The Date tuple (~p) says today is: ~p/~p/~p,~n",[Date,Y,M,D]),
  io:format("The time tuple (~p) indicates: ~p:~p:~p.~n", [Time,H,Min,S]);
valid_time(_) ->
io:format("Stop feeding me wrong data!~n").

%Guards are additional clauses that can go in a function's head to make pattern matching more expressive