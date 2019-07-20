-module(state_machine).
-export([start/0, event/2]).

start() ->
  spawn(fun() -> dont_give_a_crap() end).

event(Pid, Event) ->
  Ref = make_ref(),
  Pid ! {self(), Ref, Event},
  receive
    {Ref, Msg} -> {ok, Msg}
  after 5000  ->
    {error, timeout}
  end.
  

dont_give_a_crap() ->
  receive
    {Pid, Ref, Event} -> Pid ! {Ref, meh};
    _ -> ok
  end,
  io:format("Switching to 'dont_give_crap' state~n"),
  dont_give_a_crap().
