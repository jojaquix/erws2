%%%-------------------------------------------------------------------
%% @doc erws2 public API
%% @end
%%%-------------------------------------------------------------------

-module(erws2_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    {ok, Pid} = erws2_sup:start_link(),
    Routes = [ {
        '_',
        [
            {"/root", erws2_root, []},
            {"/", cowboy_static, {priv_file, erws2, "index.html"}},
            {"/websocket", erws2_wshandler, []}
        ]
    } ],
    Dispatch = cowboy_router:compile(Routes),

    TransOpts = [ {ip, {0,0,0,0}}, {port, 2938} ],
    ProtoOpts = #{env => #{dispatch => Dispatch}},

    {ok, _} = cowboy:start_clear(my_http_listener,
         TransOpts, ProtoOpts),

    {ok, Pid}.    

stop(_State) ->
    ok.

%% internal functions
