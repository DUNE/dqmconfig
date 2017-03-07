# Examples
## Overview
This directory contains snippets of code and configuration
which are not intended for any practical applications
but should only be used for trying things out. Security,
scalability and other important issues are not addressed
in the examples unless otherwise noted. Please don't use
for anything remotely close to production environment.

## basic.cfg
Demonstrates how one configuration file can be used
for both cmsd and xrootd on the server machines as well
as on the redirector. It relies on environment variables
to be properly set, which is pretty obvious in the code.

## example_env.sh
Sets a number of environment variables for the above file (basic.cfg) to work.

## auth_file
A dummy file necessary for these examples for work. Doesn't provide
any security, just a placeholder.




