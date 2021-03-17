# Shell
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

###### Vim editing for shell
    set -o vi
Makes bash use vi key binds. Note, this uses `vi` not `vim` bindings. Generally
this isn't recommended, even for complete vim users

    EDITOR='vim'
Bash will run the specified command when looking for an editor

    <C-x><C-r>
Open current shell line in editor. Really powerful for long lines

## Apple corner
    $ echo 'hello' > pbcopy
Copies pipe to system clipboard. Very helpful to paste text into other apps
    $ say 'something'
Says string with system voice. Not too useful, tho can be quite amusing


## Awk the programming language
    cat input.txt | awk 'length($0) > 2 { print $1 }' > output.txt
Basic structure of a one line awk program. It starts with some sort of filtering
mechanism, here a conditional that the line is longer than 2 characters, then
runs anything in the `{}` if the match succeeds. It's Unix-pipe ready

    BEGIN
Key word to run `{}` before processing in any lines. Goes in place of a
filtering mechanism
    END
Exactly like begin, except after all the lines have been read

#### Built in functions
    match($0, /string/)
Searches for regex `/string/` in `$0` and returns the field number of the match
or a 0. When it matches something, it'll also set `RSTART` and `RLENGTH` vars

    substr($0, 2, 3)
Returns a string of the second through fourth character of `$0`

#### Built in variables
    NR
Current line's number. Literally "number of reads". Starts at 1
    NF
Number of fields in this line. `$NR` expands to the last field's value
    RSTART
Field number of last `match()`
    RLENGTH
How many characters long the last `match()` was

#### Recipes
    awk -F '\t' '{ print $0 }' demo.txt
Searches goes through each tab-separated string in `demo.txt` and prints it to
stdout out, which can be used in a pipe

    ls -a | awk 'match($NF, /[0-9]+/) { print substr($NF, RSTART, RLENGTH) }' >
    coffees.nh
Takes the output of `ls` and checks that the last argument of each line matches
one or more consecutive numbers. If it does, it'll put those consecutive numbers
into a file called `coffees.nh`

    awk '!unique[$0]++' duplicates.txt > uniques.txt
Looks through all the lines in `duplicates.txt` and puts all of them in
`uniques.txt`, with no duplicate lines being piped
