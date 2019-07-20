-module(guards).
-export([andalso_orelse/1]).

%% comma(,) is used as an AND operator
%% semicolen is used as and ELSE operator
andalso_orelse(X) when X >=16, X=< 109->
  true;
andalso_orelse(_) ->
  false.
