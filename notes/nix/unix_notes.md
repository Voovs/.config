###### Process priority
Since the processor must decide priority, it uses a scale from -20 through 20 to
rank what has priority, with -20 being the highest priority. By default,
processes launched by the user start with a niceness of 0
    # nice --10 ./start_qemu.sh
    # nice -n -10 ./start_qemu.sh
Starts the process, in this case `start_qemu.sh`, with a given niceness level,
in this case `-10`. The `-n` option increments from the base value, usually 0
    # renice -2 1244
    # renice -n -2 1244
Changes the niceness of a running process via process id, in this case 1244.
`-n` increments niceness from the current value, in this case by `-2`
    $ ps -fl -C 1244
Check the niceness of process with id 1244

###### Job Control in Shell
You should not use jobs if you can help it! Especially when it comes to
input/output jobs are terribly unclear. Only use them for tasks that will never
ask for input or give an output
    $ python -m SimpleHTTPServer 3000 &
Starts a process, in this case the python server, in the background. Just append
a `&` at the end

*Oh no, I didn't launch the process in the background*
    ^z
If you want to move suspend the current process, `^z` will suspend and stop it
    $ bg %2
    $ bg 2
    $ %2 &
Continues the stopped job in the background. In this case, we use job identifier
1, which will start that specific job. You can omit the `%` with `bg`
    $ fg %2
Bring a job back to the foreground. Uses identifiers much like `bg`
    $ jobs -l
List all background jobs running. `-l` shows their process id
    $ kill %2
Kills a background job, via identifiers. The `%` is not optional here!
    $ wait %2
Waits for job identifier `2` to finish. Passing no arguments waits for all
background jobs
