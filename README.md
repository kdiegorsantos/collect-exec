# collect-exec.sh

About one year I’ve developed a shell script to collect important information about operation system, software and hardware in TIM Telecom, there they have applications running on Alpha, Solaris, HP-UX, AIX and obvious in the mighty Linux.

And for this purpose the collect-exec.sh was born, i’ve also developed two ansible tasks, one for deploy cron jobs and other to collect the compressed data that was generate by this little monster that saved me a some times.

In this shell script there is a lot of *nix commands to collect information about OS and InfoScale/Veritas Cluster Server.

The script collects a lot of information about the running system and save the output of each commands in a text file, and saves copies of important files in a directory named files. At the end of the script everything is compressed with tar in the global directory.

The function to run on AIX it’s incomplete, if you like AIX please make your contribution.

# License
collect-exec.sh is licensed under the MIT license. See included LICENSE.md.