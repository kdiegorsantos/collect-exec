collect-exec.sh - My personal operation system report
----------------

About one year i developed a shell script to collect important information about operation system, software and hardware in TIM Telecom at Brazil, there they have applications running on Alpha, Solaris, HP-UX, AIX and obvious in the mighty and glorious Linux.

And for this purpose the collect-exec.sh shell script was born, i also developed two ansible tasks, one for deploy cron jobs and other to collect the compressed data that was generate by this little monster that saved me a some times.

The shell script collects a lot of information about the running system and save the output of each commands in a text file, and saves copies of important files in a directory named files. At the end of the script everything is compressed with and saved in the global directory.

Tested with
----------------
+ Red Hat Enterprise Linux
+ Solaris
+ HP-UX
+ AIX
+ Alpha

Install and configure collect-exec
----------------

Clone the project, give right permission and configure a cron job.

```sh
$ git clone https://github.com/kdiegorsnatos/collect-exec.git /var/tmp
$ chmod u+x /var/tmp/kdiegorsantos.collect-exec/bin/collect-exec.sh
$ cat <<EOF>> /var/spool/cron/root
00 22 * * * timeout 60m /var/tmp/kdiegorsantos.collect-exec/bin/collect-exec.sh
EOF
```

License
-------

This project is licensed under the MIT license. See included LICENSE.md.


Author Information
-------

* Diego R. Santos
* [github.com](https://github.com/kdiegorsantos)
