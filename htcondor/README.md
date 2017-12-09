# Services

## Logging

p3s has a client "services.py" which interfaces the log database and persists any text message.
The database schema contains (service_name, message, format). Same database can be also written
to by other clients if the "--direct" option is specified.


## Pilot management
* pcalc: see if the number of active pilots in the system is what it's supposed to be according to the configuration, submit the number of pilots according to the difference if such is found.
* pilotclean: detect timed-out pilots, calls the "TO.py" script with "direct" option meaning log to the server.
* pilotpurge: delete the pilots previously marked as timed-out from the database. Calls "purge.py" script with arguments specifying what to delete (pilots) and in what state (timeout) and with the "direct" option.



