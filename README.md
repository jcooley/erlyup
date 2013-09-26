erlyup
======

The simplest useful program that uses Erlang/OTP features I could think of. Website monitoring needs concurrency (Erlang) and reliability (OPT) . This OTP server monitors a list of sites and shows a heartbeat when all is well and a warning when one goes down. It's mean to be basic but email, twitter and lava lamp support may follow :)

It works with the [rebar pre-built binary version](https://github.com/rebar/rebar/wiki/rebar) and erlang r14. Use [Kerl](https://github.com/spawngrid/kerl) to install particular versions of Erlang/OTP. It is like Erlang's answer to virtualenv from the Python world.  

To try this out just clone this repo, cd to the /rel directory and do a 

      rebar -v clean compile generate

Rebar packages everything into a single binary

      rel/erlyup/bin/erlyup 

run it by doing a 

      rel/erlyup/bin/erlyup  console

The only files that are of interest (non-boilerplate) are the server that does the work 

      src/erlyup_server.erl	

and the OTP supervisor that manages it

      src/erlyup_sup.erl

Rebar does have some issues working with particular versions of Erlang but I can do a version of this for the major versions of Erlang if someone is interested. [Some useful coverage of rebar](http://erlang-as-is.blogspot.ie/2011/04/erlang-app-management-with-rebar-alan.html). 