-module(fizzbuzz).
-export([what_is_it/1]).

what_is_it([]) ->
  io:format("Enter a number ");
what_is_it(Number) ->
  case Number rem 15 =:= 0 of
    true -> io:format("FizzBuzz ");
    false ->
      case Number rem 3 =:= 0 of
        true -> io:format("Fizz ");
        false -> io:format("Buzz ")
      end
  end.

