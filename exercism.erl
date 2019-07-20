-module(exercism).
-compile(export_all).

square([]) -> [];
square(L) ->
  [X*X || X <- L].


hello_world() ->
  io:format("Hello World! ~n").

leap_year(N) when N rem 4 =:= 0 ->
  case N rem 100 =:= 0 of
    true -> 
      case N rem 400 =:= 0 of 
        true -> io:format("Leap year ~n");
        false -> io:format("Not Leap year ~n")
      end;
    false -> io:format("Not Leap year ~n")
  end.
  
steps(N) when N =< 0 -> {error, "Only positive numbers are allowed"};
steps(N) -> steps_helper(N, 0).

steps_helper(1, Steps) -> Steps;
steps_helper(N, Steps) when (N rem 2 =:= 0) ->
  steps_helper(N div 2, Steps+1);
steps_helper(N, Steps) when (N rem 2 =/= 0) ->
  steps_helper(3*N+1, Steps+1).