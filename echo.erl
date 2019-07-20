-module(echo).
-export([go/0, loop/0, sender/0, receiver/0]).
 
go() ->
	Pid2 = spawn(echo, loop, []),
	Pid2 ! {self(), hello},
	receive 
		{Pid2, Msg} ->
			io:format("P1 ~w~n",[Msg])
	end,
	Pid2 ! stop.

loop() ->
	receive
		{From, Msg} -> 
			From ! {self(), Msg};
			% loop();
		stop ->
			true
	end.


sender() ->
  Pid2 = spawn(echo, receiver, [] ),
  % Pid3 = spawn(echo, receiver, [] ),
  Pid2 ! {self(), foo},
  % Pid3 ! {self, bar},
  receive
    {Pid2, Msg} ->
      io:format("P1 ~w~n",[Msg])
    % {Pid3, Msg} ->
    %   io:format("P1 ~w~n",[Msg])
  end.

receiver() ->
  receive 
    {From, Msg} ->
      From ! {self(), Msg}
  end.
