-module(erlyup_server).

-behaviour(gen_fsm).

-export([start_link/0]).

-export([init/1, recheck_server/2, recheck_server/3, handle_event/3,
         handle_sync_event/4, handle_info/3, terminate/3, code_change/4]).

-define(SERVER, ?MODULE).
-define(HOSTS, ["www.google.com", "www.twitter.com", "www.github.com"]).
%-define(RETRY_INTERVAL_MS, 5000).
 
start_link() ->
  gen_fsm:start_link({local, ?SERVER}, ?MODULE, [], []).

init([]) ->
  {ok, recheck_server, {[]}, 1000}.

recheck_server(_Event, State) ->
    [ping(Host) || Host <- ?HOSTS],
    {next_state, recheck_server, State, 5000}.

recheck_server(_Event, _From, State) ->
    [ping(Host) || Host <- ?HOSTS],
    Reply = ok,
    {reply, Reply, recheck_server, State, 5000}.

ping(Host) ->
    try
	{ok, Socket} = gen_tcp:connect(Host, 80, [binary, {packet, 0}]),
	gen_tcp:close(Socket),
	io:format("."),
	ok
    catch
	error:Error -> io:format("-~s~n~s\n",[Host, Error]);
        _:_ ->
            usage()
    end.

usage() ->
    io:format("usage: ping host1,host2,etc. \n"),
    halt(1).


%% callbacks

handle_event(_Event, StateName, State) ->
    {next_state, StateName, State}.


handle_sync_event(Event, From, StateName, State) ->
  Reply = ok,
  {reply, Reply, StateName, State}.

handle_info(_Info, StateName, State) ->
  {next_state, StateName, State}.

terminate(_Reason, _StateName, _State) ->
  ok.

code_change(_OldVsn, StateName, State, _Extra) ->
  {ok, StateName, State}.
