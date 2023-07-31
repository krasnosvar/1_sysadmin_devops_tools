#убить процессы пользователя toor (например, для его удаления)
ps aux | awk '/^toor/ {print $2}' | xargs kill -9
---------------------------------------------------------------------------------------------


#PS
#short summary of the active processes
ps aux
#shows exact command that was used to start process
ps -ef
#shows hierarchical relationships between parent and child processes
ps fax
#Displaying top CPU_consuming processes:
ps aux | head -1; ps aux | sort -rn +2 | head -10
#Displaying top 10 memory-consuming processes:
ps aux | head -1; ps aux | sort -rn +3 | head
#look top-10 processes by mem-usage
ps aux --sort=-%mem | awk 'NR<=10{print $0}'
#Displaying process in order of being penalized:
ps -eakl | head -1; ps -eakl | sort -rn +5
#Displaying process in order of priority:
ps -eakl | sort -n +6 | head
#Displaying process in order of nice value
ps -eakl | sort -n +7
#Displaying the process in order of time
ps vx | head -1;ps vx | grep -v PID | sort -rn +3 | head -10
#Displaying the process in order of real memory use
ps vx | head -1; ps vx | grep -v PID | sort -rn +6 | head -10
#Displaying the process in order of I/O
ps vx | head -1; ps vx | grep -v PID | sort -rn +4 | head -10
#Displaying WLM classes
ps -a -o pid, user, class, pcpu, pmem, args
#Determinimg process ID of wait processes:
ps vg | head -1; ps vg | grep -w wait
#Wait process bound to CPU
ps -mo THREAD -p <PID>

#не совсем ps но тоже относится к процессам
#запустить графическую программу из консоли чтобы она отпустила консоль при запуске
sudo pac  > /dev/null 2>&1 &

#Cpu usage with priority levels
topas -P

#PGREP
#pgrep looks through the currently running processes and lists the process IDs which match the selection criteria to stdout
#Use pgrep dd to get a list of all PIDs that have a name containing the string dd
pgrep tmux
#only list the processes called sshd AND owned by root
pgrep -u root sshd
#list the processes owned by root OR den
pgrep -u root,den sshd
#pstree - display a tree of processes
pstree

#NICE-RENICE
#start process with manually set niceness
nice -n 5 dd if=/dev/zero of=/dev/null &
#decrease the priority of the process to 10( to 19 max)
renice -n 10 p 1310
#increase the priority of the process to -10( to -20 max), only root can increace niceness
sudo renice -n -10 p 1310
# https://www.tecmint.com/set-linux-process-priority-using-nice-and-renice-commands/
# renice created sleep to 15
( sleep 10000 & echo $! >&3 ) 3>pid | renice -n 15 -p $(<pid)

#KILL
#Sending Signals to Processes with kill, killall, and pkill
# The signal SIGTERM (15) is used to ask a process to stop.
# The signal SIGKILL (9) is used to force a process to stop.
# The SIGHUP (1) signal is used to hang up a process.
kill "PID" #This sends the SIGTERM signal to the process, which normally causes the process to cease its activity
kill -9 #sends the SIGKILL signal to the process. SIGKILL signal cannot be ignored, it forces the process to stop, but you also risk losing data while using this command
kill -l #show a list of available signals that can be used with kill

# How to get pid of just started process
# https://serverfault.com/questions/205498/how-to-get-pid-of-just-started-process
go run main.go & echo $!

#INODES
#check inodes usage
df -i
#https://www.digitalocean.com/community/questions/best-way-to-clear-inodes
#check by dir
for i in /*; do echo $i; find $i |wc -l; done
for i in /var/*; do echo $i; find $i |wc -l; done

#move process to another CPU core
# * https://www.xmodulo.com/run-program-process-specific-cpu-cores-linux.html
# https://www.redhat.com/sysadmin/tune-linux-tips
#install in ubuntu
sudo apt install util-linux
# create sleep in backgroud, fetch pid and move to CPU0 core
( sleep 10000 & echo $! >&3 ) 3>pid && taskset -cp 0 $(<pid)
