-module(what_the_if).
-export([heh_fine/0,if_else/1, animal_sound/1, insert/2]).

heh_fine() ->
  if 1 =:= 1 ->
    works
    end,
  if 1 =:=2; 1 =:= 1 -> 
    works
  end,
  if 1 =:=2, 1 =:= 1 -> %% comma is andalso
    fails
  end.


if_else(N) ->
  if N =:= 2; N =< 1 -> this_is_if;
  true -> this_is_else  %% Erlang's else
 end.

animal_sound(Animal) ->
  Talk = if Animal == cat ->  "moew";
            Animal == beef -> "mooo";
            Animal == dog -> "woof";
            Animal == tree -> "bark";
            true -> "adsafaga"
          end,
   {Animal, "says " ++ Talk ++ "!"}.

%% case statement
