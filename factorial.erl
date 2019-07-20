-module(factorial).
-export([factorial/1,recursive_factorial/1, len/1,acc_resursive/1,
len_acc/1,tail_duplicate/2,sublist/2,tail_sublist/2]).


%%    a base case;
%%    a function that calls itself;
%%    a list to try our function on.


factorial(0) -> 1;
factorial(N) -> N* factorial(N-1).


recursive_factorial(N) when N == 0 -> 1;
recursive_factorial(N) when N >= 0 -> N * recursive_factorial(N-1).

len([]) -> 0;
len([_| T ]) -> 1 + len(T).
  
%% tail recursive program where accumulator is temporary variable
len_acc(L) -> len_acc(L,0).

len_acc([], Acc) -> Acc;
len_acc([_|T], Acc) -> len_acc(T,Acc+1).


acc_resursive(N) -> acc_resursive(N,1).

acc_resursive(0,Acc) -> Acc;
acc_resursive(N,Acc) when N > 0 -> acc_resursive(N-1,N*Acc).


tail_duplicate(N,Term) ->
  tail_duplicate(N,Term,[]).
 
tail_duplicate(0,_,List) ->
  List;
tail_duplicate(N,Term,List) when N > 0 ->
  tail_duplicate(N-1, Term, [Term|List]).

% sublist([1,2,3,4,5,6],3) return [1,2,3]

sublist(_,0) -> [];
sublist([],_) -> [];
sublist([H|T],N) when N > 0 -> [H | sublist(T, N-1)].


% tail recursive sublist

tail_sublist(L, N) -> lists:reverse(tail_sublist(L, N, [])).
 
tail_sublist(_, 0, SubList) -> SubList;
tail_sublist([], _, SubList) -> SubList;
tail_sublist([H|T], N, SubList) when N > 0 ->
tail_sublist(T, N-1, [H|SubList]).