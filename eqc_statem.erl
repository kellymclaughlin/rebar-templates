%%%'   HEADER
%% @author    {{author_name}} <{{author_email}}>
%% @copyright {{copyright_year}} {{author_name}}
%% @doc       Quickcheck eqc_statem test suite for the module {{name}}.
%%            The Quickcheck tests are wrapped in an eunit test
%%            for execution convenience.
%% @end

-module({{name}}_eqc).
-author('{{author_name}} <{{author_email}}>').

-ifdef(EQC).
-include_lib("eqc/include/eqc.hrl").
-include_lib("eqc/include/eqc_statem.hrl").
-include_lib("eunit/include/eunit.hrl").

-define(NOTEST, true).
-define(NOASSERT, true).

-define(MODNAME, {{name}}).
-define(TEST_ITERATIONS, 500).
-define(QC_OUT(P),
        eqc:on_output(fun(Str, Args) -> io:format(user, Str, Args) end, P)).

-export([check/0,
         test/0,
         test/1]).

%%====================================================================
%% eunit test
%%====================================================================

eqc_test_() ->
    {spawn,
     [{setup,
       fun setup/0,
       fun cleanup/1,
       [
        %% Run the quickcheck tests
        {timeout, 60000, % timeout is in msec
         %% Indicate the number of test iterations for each property here
         ?_assertEqual(true, quickcheck(numtests(?TEST_ITERATIONS, ?QC_OUT(prop_{{name}}))))
        }
       ]
      }
     ]
    }.

setup() ->
    %% Remove the logger noise.
    application:load(sasl),
    error_logger:tty(false),
    %% Uncomment the following lines to send log output to files.
    %% application:set_env(sasl, sasl_error_logger, {file, "{{name}}_eqc_sasl.log"}),
    %% error_logger:logfile({open, "{{name}}_eqc.log"}),

    %% @TODO Perform any required setup
    ok.

cleanup(_) ->
    %% @TODO Perform any required cleanup
    ok.

%% ====================================================================
%% eqc property
%% ====================================================================
prop_{{name}}() ->
    false. % @TODO Remove this line after defining the property

%% ====================================================================
%% eqc_statem callbacks
%% ====================================================================

initial_state() ->
    #state{}.

command(_State) ->
    %% @TODO Specify symbolic function calls to be used in test
    %% sequence generation.
    %% e.g.:
    %% {call, M, F, A}
    %%  or
    %% oneof([{call, M, F, A},
    %%        {call, M, F, A}])

next_state(State, _Result, {call,_,_,_}) ->
    State.

precondition(_,_) ->
    true.

postcondition(_,_,_) ->
    true.

%%====================================================================
%% Generators
%%====================================================================

%%====================================================================
%% Helpers
%%====================================================================

test() ->
    test(100).

test(N) ->
    quickcheck(numtests(N, prop_{{name}}())).

check() ->
    check(prop_{{name}}(), current_counterexample()).

-endif. % EQC
