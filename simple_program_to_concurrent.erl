-module(simple_program_to_concurrent).
-export([fun_area/1,con_area/0, call_area/1, area/0, for/3]).

fun_area({square,X}) ->
  X*X;
fun_area({rectangle,X,Y}) ->
  X*Y.

%%convert to concurrency
%Pid = spawn(simple_program_to_concurrent, con_area, []).
% Pid ! {square,3}
con_area() ->
  receive
    {square,X} ->
      io:format("area of square ~p ~n",[X*X]);
      {rectangle,X,Y} ->
        io:format("area of rectangle ~p ~n",[X*Y])
  end,
  con_area().

%%Return to sender
call_area({Shape,L,B}) ->
  {Shape, L ,B } = {Shape, L, B},
  Pid = spawn(simple_program_to_concurrent, area, []),
  Pid ! {self(), {Shape,L,B}},
  receive 
    {Pid , Area} ->
      Area
  end.

area() ->
  receive 
    {From, {square,X,X}} ->
      From ! {self(), X*X};
    {From , {rectangle, X,Y}} ->
      From ! {self(), X*Y}
  end,
  area().

%%Higher order function which take function as argument or returns functions

for(Max, Max, F) ->
  [F(Max)];
for(I, Max, F) ->
  [F(I) | for(I+1, Max, F)].


%% purpose of link is error propogation path. i.e if process A dies process B will be informed 
%%and vice versa. Process which are linked to each other in the netowrk all will die

%%process_flag(trap_exit,true) becomes a system process which will not die if the other process link to it dies

%% links are created using link(A,B)