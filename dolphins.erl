-module(dolphins).
-compile(export_all).

%% receving a function
dolphin1() ->
  receive
    do_a_flip ->
      io:format("How about no?~n");
    fish ->
      io:format("So long and thanks for all the fish!~n");
    _ ->
      io:format("Heh, were smarter than you humans.~n")
  end.


% Then it should be noted that if the first message we sent worked, 
% the second provoked no reaction whatsoever from the process because this is due to the fact once our function output,
% its terminated and so did the process. We'll need to restart the dolphin

%The only manner to know if a process had received a message is to send a reply


dolphin2() ->
  receive 
    {From, do_a_flip} ->
      From ! "How about no?";
    {From, fish} ->
      From ! "So long and thanks for all the fish";
    _ ->
       io:format("Heh, were smarter than you humans.~n")
  end.


dolphin3() ->
  receive
    {From, do_a_flip} ->
      From ! "How about no?",
      dolphin3();
    {From, fish} ->
      From ! "So long and thanks for all the fish!";
    _ ->
      io:format("Heh, we're smarter than you humans.~n"),
      dolphin3()
  end.


