Wolfpack Empire Docker Container
================================
Docker container for running an Wolfpack Empire server with terminal
based clients. More information about Wolfpack Empire can be found at
http://wolfpackempire.com/

There are two directories within the container that are used to persist
the configuration and game data. These directories should be mounted
through the docker command line to store the configuration and game
data outside the container in case the container restarts.

* Game configuration: /empire/etc/empire
* Game data: /empire/var/empire

When the container starts up if the configuration directory does not have
the configuration files, then the default configuration files will be copied
into the directory. The files may then be edited for the game that one 
wishes to run.

Container Specific Commands
---------------------------

* info, info topics, info *topic*

    This will access the Empire info pages without needing to be connected
    through a client. Using just the info command will display the top level
    info page which is generally used as a entry point to the info topics.
    Using info topics will print a list of all available topics. Finally
    providing a topic to the info command will print that info page for the
    specified topic. Note many of the topics are quite lengthy and it may be
    necessary to pipe the output into less.

* readme

    Display this README file to the screen.

* man *term*

    Display the man page for the Empire server commands. If the term is not
    specified, then all the available man pages are displayed.

* updates [*num*]

    Print the timestamps for upcoming updates. By default if a number is not
    specified, then 16 timestamps will be printed. By specifying a number,
    that number of timestamps will be printed.

* create-world *args for fairland*

    This is a way to bootstrap the world into existence. Be fore warned that
    executing this command will destroy any existing world--even if a game is
    in progress.

    The arguments allow one to control the creation of the world. Please
    reference the fairland command line in the Empire Server Commands
    section below. At a minimum one must supply two numbers to create a
    world: the number of continents and the size of the continents. The
    remaining arguments have default values that are documented in the 
    fairland entry below. Also note that the command line switches are also
    valid, but they must come before the number of continents.

* emp_server, empserver, server

    This is the Empire server is normally started (or if no command is
    specified). Once started the server process will wait for connections
    from clients. 

* empire *empire client args*, client *empire client args*

    Start the Empire client and connect to a server as specified by the
    arguments. Most notibly the host and port along with the country and
    password are usually specified.

* pei, pei2

* pei3

* version

    This will print out the version of Empire server in the container.


Empire Client Commands
======================

empire
------
```
Usage: empire [OPTION]...[COUNTRY [PASSWORD]]
  -2 FILE         Append log of session to FILE
  -k              Kill connection
  -r              Restricted mode, no redirections
  -s [HOST:]PORT  Specify server HOST and PORT
  -u              Use UTF-8
  -h              display this help and exit
  -v              display version information and exit
```


Empire Server Commands
======================

emp_server
----------
```
Usage: emp_server [OPTION]...
  -d              debug mode, implies -E abort
  -e CONFIG-FILE  configuration file
                  (default /empire/etc/empire/econfig)
  -E ACTION       what to do on oops: abort, crash-dump, nothing (default)
  -p              threading debug mode, implies -d
  -s              enable stack checking
  -R RANDOM-SEED  random seed
  -h              display this help and exit
  -v              display version information and exit
```


fairland
--------
```
Usage: fairland [OPTION]... NC SC [NI] [IS] [SP] [PM] [DI] [ID]
  -a              airport marker for continents
  -e CONFIG-FILE  configuration file
                  (default /empire/etc/empire/econfig)
  -i              islands may merge
  -o              don't set resources
  -q              quiet
  -R SEED         seed for random number generator
  -s SCRIPT       name of script to create (default newcap_script)
  -h              display this help and exit
  -v              display version information and exit
  NC              number of continents
  SC              continent size
  NI              number of islands (default NC)
  IS              average island size (default SC/2)
  SP              spike percentage: 0 = round, 100 = snake (default 10)
  PM              percentage of land that is mountain (default 0)
  DI              minimum distance between continents (default 2)
  ID              minimum distance from islands to continents (default 1)
```

empdump
-------
```
Usage: empdump [OPTION]...
  -c              use complete export format
  -e CONFIG-FILE  configuration file
                  (default /empire/etc/empire/econfig)
  -i DUMP-FILE    import from DUMP-FILE
  -m              use machine-readable format
  -n              dry run, don't update game state
  -x              export to standard output
  -h              display this help and exit
  -v              display version information and exit
```

empsched
--------
```
Usage: empsched [OPTION]... [FILE]
Print the Empire update schedule.

  -e CONFIG-FILE  configuration file
                  (default /empire/etc/empire/econfig)
  -n NUMBER       print at most NUMBER updates (default 16)
  -h              display this help and exit
  -v              display version information and exit

If FILE is given, print the schedule defined there instead of
the current schedule.
```

files
-----
```
Usage: files [OPTION]...
  -e CONFIG-FILE  configuration file
                  (default /empire/etc/empire/econfig)
  -f              force overwrite of existing game
  -h              display this help and exit
  -v              display version information and exit
```

pconfig
-------

