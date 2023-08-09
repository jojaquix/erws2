-module(erws2_wshandler).

-behaviour(cowboy_websocket).

-export([init/2, terminate/3]).
-export([
    websocket_init/1, websocket_handle/2,
    websocket_info/2, websocket_terminate/3
]).

init(Req, State) -> 
    {cowboy_websocket, Req, State}.

websocket_init(State) ->
    %lager:debug("init websocket"),
    %using Deprecated tuple
    {ok, State}.


websocket_handle({text, Msg}, State) ->
    %lager:debug("Got Data: ~p", [Msg]),
    {reply, {text, << "responding to ", Msg/binary >>}, State, hibernate };

websocket_handle(_Any, State) ->
    {reply, {text, << "whut?">>}, State, hibernate }.


websocket_info({timeout, _Ref, Msg}, State) ->
    {reply, {text, Msg}, State};

websocket_info(_Info, State) ->
    %lager:debug("websocket info"),
    {ok, State, hibernate}.

websocket_terminate(_Reason, _Req, _State) ->
    ok.

terminate(_Reason, _Req, _State) ->
    ok.
