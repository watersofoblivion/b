# The CPU and Instructions

Up until now, we have described the physical resources available to programs:
main memory and registers.  This is the "world" in which programs run.  What we
have not described how to write programs that manipulate this world.  That's
what we'll do now.

We'll start by describing what a program is and how it is executed, then we'll
go through the instructions available to write programs.

## What Is A Program?

A program is a finite ordered list of instructions.  Each instruction
manipulates the world in some way: by reading from or writing to main memory, by
performing an operation on values in registers, or by changing the instruction
pointer `ip`.

For example, here is a program that (rather awkwardly) multiplies two numbers.
Don't worry about understanding it yet; we'll come back to it at the end once
we've explained more.  (Do take your best guess at how it works though!)  For
now, let's just focus on the structure.

```assembly
; This is a comment
      add   x1, x0, x0
step: beq   x0, x2, done
      add   x1, x1, x3
      sub.i x2, x2, 1
      jal   x0, step      ; This is also a comment
done: halt
```

The program is written as a list of instructions, one per line.  Each
instruction starts with an "opcode" (such as `add`, `beq`, or `jal`) followed by
zero or more "operands" separated by commas (such as `x1, x0, x0`, `x0, x2,
done`, or `x0, step`.)  The space before/after an instruction or between the
opcode, the operands, and the commas is insignificant as long as there is at
least one space between the opcode and the first operand.  (For example, `add
x1,x0,x0` and `    add    x1  ,    x0   ,x0   ` are both valid and the same
instruction.)

Anything following a semicolon `;` to the end of the line is a "comment" and is
ignored by the computer.  This is for humans to write notes in their source code
to help themselves and other humans understand what the code is doing at a
higher level.  Blank lines are ignored by the computer, but often helpful for
humans to group instructions into logically related blocks so a program is
easier to read.

Finally, there are labels.  Any line can start with a human-readable name
followed by a colon (`:`).  This is a named point in the code that you will use
for specific oprations.  It always labels the instruction immediately following
the label, regardless of intervening whitespace, blank lines, and comments.
(I.e., a label can be on a line by itself and will label the next instruction in
the program.)  A "human-readable" name is a name consisting of numbers, letters,
and the underscore character (`_`), starting with a letter.  Names like `step`,
`done`, `begin_loop`, and `label42` are all valid.  Names like `42_label` and
`jump here` are not.  The label can be used in place of an instruction address
anywhere in the code (the meaning of this will become clearer later.)

Because of these syntax rules, you will often see assembly programs formatted
like the following, equivalent program that is much easier to read:

```assembly
  add   x1, x0, x0

step:
  beq   x0, x2, done
  add   x1, x1, x3
  sub.i x2, x2, 1
  jal   x0, step

done:
  halt
```

## How Is A Program Executed?

The CPU ("Central Processing Unit") of your computer is what actually executes
("runs") your program.  It is the all the circuitry that implements the digital
logic to turn instructions into actions that manipulate the values in registers
and main memory.

How does it do this?  This is where the special "instruction pointer" register
`ip` comes in.  But to understand the `ip` register, you first need to know this
one, weird trick.

The program (the list of instructions) is stored in main memory.  How exactly it
gets there and the precise address in main memory where it is stored is not
important for our purposes.  Just know that it is far enough away from the part
of main memory we are manipulating during the execution of our program that it
won't overlap and interfere: we won't ever explicitly read from or write to this
area of main memory.  Also note that we never know the actual address where the
program resides.  (This will become important.)

It may seem strange that the program itself is stored in main memory, given that
we said main memory is storage space for numbers.  This is a bit of a
sleight-of-hand: every instruction can actually be represented as a unique
number, and so can be stored in main memory.  The hardware knows how to read
these special numbers as instructions and execute them; that's literally the
*only* thing that the hardware can do.  This can be exploited in a real computer
to do some very, very interesting things, though we won't be doing that here.

Each instruction is a single number, so each instruction stored in a single cell
of main memory.  The entire program is stored in-order in adjacent cells.  So,
if a program is 5 instructions long and it is stored starting at address `k`,
the individual instructions are stored at addresses `k` (or, equivalently,
`k + 0`), `k + 1`, `k + 2`, `k + 3`, and `k + 4`.

This means that instructions are implicitly numbered, starting at zero and
ignoring all blank lines and other whitespace as well as labels.  From the point
of view of the CPU the example program from the last section is effectively
(being a little loose with the labeling rules):

```assembly
k + 0: add   x1, x0, x0
k + 1: beq   x0, x2, (k + 5)
k + 2: add   x1, x1, x3
k + 3: sub.i x2, x2, 1
k + 4: jal   x0, (k + 1)
k + 5: halt
```

(Notice the labels, both on the lines and in the instructions, have become `k +
something`.  This "translation" is what I meant earlier when I said "The label
can be used in place of an instruction address anywhere in the code".)

The `ip` exploits the fact that the program is stored in main memory.  The value
in this register is the address in main memory of the instruction to execute.
Hence the name "instruction pointer": it "points to" the current instruction.

There are two main types of instructions.  There are "normal" instructions that
manipulate the values in the registers or main memory ("Add two numbers", "store
this number in memory", etc.)  Then there are "special" instructions which
manipulate the `ip` (instruction pointer) register.  There is also a third
"type", which is the instruction to `halt`, which tells the comuter the program
has completed and it should stop processing.

When your program starts, the `ip` is automatically set to the address of the
first instruction in your program.  The CPU then enters a loop, repeatedly
performing the following sequence of steps until it is told to stop:

* It reads the value at the address stored in `ip` from memory, decodes it into
  an instruction, then executes that instruction by performing that operation
  against the values currently in the registers and main memory.
* It then makes a decision:
  * If the instruction is a "normal" instruction, it increments the `ip` by `1`.
  * If the instruction is a "special" instruction that manipulated the `ip`, it
    leaves the `ip` at its current value.
  * If the instruction is `halt`, the CPU exits the loop.

We can infer couple a few things from this.

First, unless a special instruction occurrs, the CPU will just blindly execute
the sequence of instructions in memory in-order.  The first instruction will be
executed, the `ip` incremented, then the next instruction will be executed, the
`ip` will be incremented, etc.  When a special, `ip`-manipulating instruction
does occur, we will "jump" to a different point in the list of instructions,
then return to blindly executing those instructions in-order.  It is the
interplay between these two mechanisms that makes programs "work".  It also
highlights that the CPU is truly an unthinking machine: it does exactly what the
instructions tell it to do.  No more, no less.

The second is a not-necessarily-obvious consequence of a few things: a) our
program being an ordered list of instructions, b) each instruction being exactly
one cell in size, c) being the human writing the program, and d) *not* knowing
in advance the exact address that that list of instructions will be stored at in
main memory.  The practical upshot of all these combined is that every "special"
instruction that manipulates the `ip` will do so in a *relative* way.  We won't
ever set the `ip` to a specific address; instead we will add or subtract values
from it, effectively saying "jump forward/back `n` instructions".  So, *really*,
the CPU sees our example program as:

```assembly
add   x1, x0, x0
beq   x0, x2, 4  ; Special instruction, jump forward 4 instructions if the value in register x0 equals the value in register x2
add   x1, x1, x3
sub.i x2, x2, 1
jal   x0, -3     ; Special instruction, always jump backwards 3 instructions
halt
```

(With those comments, it should now be clearer how this program works, even
without knowing the details of the individual instructions.)

This is where the labels from above become handy.  Instead of having to manually
inspect our code and count the number of instructions we want to jump, we can
just label the position in the code we want to jump to and use that label at the
place where we want to take the jump.  If we didn't have labels, every time we
changed our code, we'd also have to go through and make sure that our jump
offsets were correct since we may have added or removed instructions between the
where the jump happens and where we want to jump to.  There *are* some special
cases where using hard-coded offsets ("jump ahead 3 instructions") is useful,
but generally labels are the way to go.  They also serve as ad-hoc documentation
if we picked good, meaningful names instead of `label_42` or something.
