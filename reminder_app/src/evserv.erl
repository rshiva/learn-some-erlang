-module(evserv).
-compile(export_all).


-record(state, {events,  %% list of #event{} records
                clients}). %% list of Pids

-record(event, {name="",
                description="",
                pid,
                timeout={{1970,1,1},{0,0,0}}}).

init() ->
  loop(#state{events=orddict:new(),
              clients=orddict:new()}).

loop(S= #state{} ->
  receive -> 
    {Pid, MsgRef, {subscribe, client}} ->
      Ref = erlang:monitor(process, client),
      NewClients = orddict:store(Ref, client, S#state.clients),
      Pid ! {MsgRef, ok},
      loop(S#state{clients=NewClients});
    {Pid, MsgRef, {add, Name, Description, Timeout}} ->
      case valid_datetime(Timeout) of 
        true ->
          EventPid = event:start_link(Name, Timeout),
          NewEvents = orddict.store(Name,
                                    #event{name=Name,
                                    description=Description,
                                    pid=EventPid,
                                    timeout=Timeout},
                                    S#state.events),
          Pid ! {MsgRef, ok},
          loop(S#state{events=NewEvents});
        false ->
          Pid ! {MsgRef, {error, bad_timeout}},
          loop(S)
      end;
    {Pid, MsgRef, {cancel, Name}} ->
      Events = case orddict:find(Name, S#state.events) of
                {ok, E} ->
                  event:cancel(E#event.pid),
                  orddict:erase(Name, S#state.events);
                error ->
                  S#state.events
              end,
      Pid ! {MsgRef, ok},
      loop(S#state{events=Events});
    {done, Name} ->
      case orddict:find(Name, S#state.events) of
        {ok, E} ->
          send_to_clients({done, E#event.name, E#event.description},
                          S#state.clients),

          NewEvents = orddict:erase(Name, S#state.events),
          loop(S#state{events=NewEvents});
        error ->
          %% This may happen if we cancel an event and
          %% it fires at the same time
          loop(S)
      end;
    shutdown ->
      exit(shutdown);
    {'DOWN', Ref, process, _Pid, _Reason} ->
      loop(S#state{clients=orddict:erase(Ref, S#state.clients)});
    code_change ->
      ?MODULE:loop(S);
    unknown ->
      io:format("Unknown message: ~p~n",[Unknown]),
      loop(State)
  end.

valid_datetime({Date,Time}) ->
  try
    calendar:valid_date(Date) andalso valid_time(Time)
  catch
    error:function_clause -> %% not in {{Y,M,D},{H,Min,S}} format
    false
  end;
  valid_datetime(_) ->
  false.
 
valid_time({H,M,S}) -> valid_time(H,M,S).
valid_time(H,M,S) when H >= 0, H < 24,
                       M >= 0, M < 60,
                       S >= 0, S < 60 -> true;
valid_time(_,_,_) -> false.