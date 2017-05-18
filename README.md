# wolfpack_empire_container
Docker container for running an Wolfpack Empire server


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

