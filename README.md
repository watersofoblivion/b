An Impractical Introduction to Computer Science
===

This is a "tutorial" of sorts on Computer Programming to help non-programmers
get the feel of how computers.  It is not meant to be a practical introduction
that will get you programming today.  It is intentionally impractical: the
things covered here are things you'd never actually use to write "real" computer
programs.

Instead, it is meant to introduce you to "how computers work" at a couple of
different levels of abstraction --one very low level (Assembly) and one very
high level (λ Calculus)-- so that you can understand the very fundamentals. It
strips away some of the "magic" that computers sometimes seem to be doing.  The
things presented here are the "lingua franca" of computers.  Once you understand
this, everything else is just a variant of it and translates to it.

One thing I will explicitly avoid doing is making physical analogies.  While
they can be helpful, they can also lead you down the wrong path when the analogy
between the physical object and the computer breaks down.  Instead, I will
present things as a set of rules that both you and the computer must obey.
These rules are explicit, absolute, and unchanging.  Everything you need is
either explicitly in the rules or a logical consequence of (derivable from) the
rules.  There's a great essay by Edsger W. Dijkstra called ["On the Cruelty of
Really Teaching Computer
Science"](https://www.cs.utexas.edu/~EWD/transcriptions/EWD10xx/EWD1036.html),
where he calls out how badly physical analogies fail.  Computers are
mathematical machines and they behave following mathemtatical rules, which do
not necessarily map to the ways the physical world works.  So I present them as
such: a set of rules that must be followed and the logical consequences of those
rules.

One analogy you *should* make in your mind, though, is to spreadsheets.
Spreadsheets are a surprisingly powerful tool that combines notions present in
both the low-level and high-level views of computers presented here, and also
exposes them in a very naked and unadorned fashion.  Be forewarned, like the
physical analogy it's not exact.  But it is much, much closer.

I give helpful questions for you to answer and exercises you can do.  You can
think of them as "logic puzzles" to solve.  Some of the exercises will be
surprisingly challenging, but they all have solutions.  Don't get frustrated.
Just think through the "rules of the game" and what they imply and you can find
it.  I encourage you to *not* try to do this "in your head".  Grab a sheet of
paper and a pencil, draw diagrams, write expressions, etc.  It's usually very
helpful.  I also try to structure the exercises as one that should be immediate,
one that should take a little thought or just be less trivial, and then some
that require you to read between the lines and possibly make some decisions on
your own.

Also note that this is a "first draft" of sorts, so it's pretty unevenly edited.
Feedback on flow, clarity, and all those other non-technical aspects of this is
always appreciated.  It's also Work-in-Progress, so there's several "TODO"s that
will be written later.

So, without further ado, let's get into the first view of computers: Assembly
Language.

Table Of Contents
===

* [Assembly Language](#assembly-language)
  * [Numbers](#numbers)
  * [Main Memory](#main-memory)
  * [Registers](#registers)
    * [Special Registers](#special-registers)
  * [The CPU and Instructions](#the-cpu-and-instructions)
    * [What Is A Program?](#what-is-a-program)
    * [How Is A Program Executed?](#how-is-a-program-executed)
    * [Instructions](#instructions)
      * [Arithmetic](#arithmetic)
        * [Register-Register Arithmetic](#register-register-arithmetic)
        * [Register-Immediate Arithmetic](#register-immediate-arithmetic)
      * [Load-Store](#load-store)
        * [Load](#load)
        * [Store](#store)
      * [Flow Control](#flow-control)
        * [Unconditional Jumps](#unconditional-jumps)
        * [Conditional Branches](#conditional-branches)
  * [Structured Data](#structured-data)
  * [Arrays](#arrays)
  * [Linked Lists](#linked-lists)
  * [Stacks](#stacks)
  * [Queues](#queues)
  * [Trees](#trees)
  * [Graphs](#graphs)

Assembly Language
===

This section is based on a simple Assembly Language, loosely based on RISC-V
(pronounced "Risk Five") Assembly but stripped of all the fiddly quirks that are
present in a *real* assembly languages.  This is the lowest-level, most concrete
view of a computer possible from a software perspective.  In a very real sense,
this describes the most fundamental way that software "works".  You will write
some very simple programs to get the idea of how how computers operate in this
mechanical sense.

The explanation of the model and the instructions is long and can be rather
dense at times.  I've tried to make it accessible as possible.  Take it one
section at a time, draw any diagrams you may need, play around with the rules,
and ask yourself questions to explore the limits of what is presented (and try
to answer them yourself!)  In general, try to get comfortable with one section
before moving on to the next.  In several places I've said "Convince yourself
that ...".  Like solving any math problem, take the time and write out an actual
sequence of operations using the rules to show that the example does what it's
supposed to do, showing the intermediate steps.

The Machine
---

At the level of assembly language, a computer is a very simple device with three
main components: main memory, registers, and a CPU.  We'll tackle each one in
turn.  But first, let's talk about numbers.

### Numbers

Everything in a computer is a number.  *Everything*.  And not just any number.
We're specifically interested in two kinds of numbers: the Natural Numbers and
Integers.  *Natural numbers* are the positive whole numbers and zero, so
`0, 1, 2, 3, ...` all the way to positive infinity.  *Integers* are the same,
except extended to include negative whole numbers, so from negative infinity
through `..., -3, -2, -1, 0, 1, 2, 3, ...` to positive infinity.

In our code, all numbers will technically be integers and we will never
explicitly differentiate between the integers and natural numbers.  But we will
often implicitly want to think of certain numbers as being natural numbers.  For
example, we will want to think about the "sizes" of things and "indexes" into
large lists of things.  These numbers are implicitly non-negative since you
can't have something of size `-42`.  In these cases, it's often helpful to
remember that you're working with a natural number and treat the `0` as somewhat
"special": you'll start at zero and count up until you reach some number, or
start at some number and count down until you reach zero.  Or you'll want to
remember the answers to the following:

* **[Question, Especially Useful]** What is `0 + x`?  `x + 0`?
* **[Question, Especially Useful]** What is `0 * x`?  `x * 0`? (We use the `*`
  character to mean multiplication, since it's easier to read than `0 × x`)

It is important to notice that the natural numbers are a *subset* of the
integers.  That is, anything that can in some sense "hold" or "use" an integer
value can also hold a natural number value.  We will exploit this loophole in
important ways, so it is vital to *not* think of them as two completely separate
things.

* **[Question, Especially Useful]** Anything that can hold or use an integer can
  also hold or use a natural number.  Can anything that can hold or use a
  natural number also hold or use an integer?  Why or why not?

### Main Memory

*Main memory* is storage space for numbers.  It is organized as a linear array
of cells, and contains an aribitrarily large number of cells.

Each cell is storage for exactly one integer value.  You can write a value
to/overwrite the current value of any particular cell, or you can read the
current value (most recently written value) of any particular cell.  Precisely
*how* to do this will be covered later.

Each cell has a unique (natural) number as an identifier, called its *address*.
You can think of them as being lined up in a row and numbered from left to
right, starting with cell `0`, then cell `1`, then cell `2`, etc., extending on
forever.

For example, in the diagram below, address `0` contains the value `327`, address
`1` contains the value `9`, address `2` contains the value `42`, address `3`
contains the value `4`, and addresses `4` and `5` both contain the value `0`.

```
+-------+-------+-------+-------+-------+-------+----
|       |       |       |       |       |       |
|  327  |   9   |   42  |   4   |   0   |   0   |  ...
|       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+----
    0       1       2       3       4       5      ...
```


Unless explicitly stated otherwise in a problem, main memory starts out
"uninitialized."  That is, unless you have explicitly written a value to an
address, the value at that address is unspecified.  It is random in that it
could be any integer, but it is also not random in that if you read from an
unitialized address multiple times, it will return the same unspecified value
every time.  To put it a different way, it is "arbitrary" instead of "random".

### Registers

*Registers* are a small, fixed set of cells storing integer values.  There are
precisely 32 registers, and they are addressed using names: `x0` - `x31` (so,
`x0`, `x1`, `x2`, ..., `x29`, `x30`, `x31`).

* **[Question, Especially Useful]** Are these addresses natural numbers?
  Integers?  Something else?  In terms of the "loophole" discussed above, are
  the registers a subset of the integers or natural numbers?  What effect could
  that have?

There a real, physical engineering reasons why registers are separate from main
memory, but those reasons are less important than the conceptual reason
registers are separate from main memory.  Registers are separate because they
are where the "real" computation happens.  Like main memory, you can read and
write values to registers, but you can do other things: you can load a value
from main memory into a register, store a value from a register into main
memory, or perform arithmetic on and comparisons between values in registers.
Again, precisely *how* to do these things will be covered later.

#### Special Registers

There are two "special" registers you need to be aware of: the zero register
`x0` and the instruction pointer `ip`.

The `x0` register is hard-coded to the value `0`.  That is, if you read the
value in this register, it will *always* be `0`.  If you write a value to this
register, the value written will be ignored and the value in the register will
remain `0`.  While this may seem odd, it is not nearly as useless as it seems.
Be on the lookout for uses of `x0` in the examples below to understand how to
exploit this register.  Also, remember this when we get to instructions; think
of what instructions are *not* present and how using this register with other
instructions fills that role.

The intruction pointer `ip` is a special register, separate from the `x...`
registers.  It always stores the address of the currently executing instruction.
We will discuss instructions in the next section, but know that this register
exists, is separate from the other registers, and has special behavior that we
will elaborate on as we talk about instructions.  You cannot read or write to
this register --at least, not directly-- but it is critically important to how
programs run.

### The CPU and Instructions

Up until now, we have described the physical resources available to programs:
main memory and registers.  This is the "world" in which programs run.  What we
have not described how to write programs that manipulate this world.  That's
what we'll do now.

We'll start by describing what a program is and how it is executed, then we'll
go through the instructions available to write programs.

#### What is a Program?

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

#### How is a Program Executed?

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

#### Instructions

There are a handful instructions available to use when writing programs.  I've
divided them up into 3 categories to make them more digestable: Arithmetic,
Load-Store, and Flow Control.

Additionally, there is the special instruction `halt`.  This instruction simply
tells the CPU to stop executing and marks the end of a program.  It is written:

```assembly
halt
```

##### Arithmetic

The simplest instructions are arithmetic.  There are two sub-categories of
arithmetic: "register-register" arithmetic, and "register-immediate" arithmetic.

These are "normal" instructions that do not alter the `ip` register.

###### Register-Register Arithmetic

There are 5 "register-register" arithmetic instructions, one corresponding to
each main arithmetic operation: addition, subtraction, multiplication, integer
division, and modulus.  Their opcodes are, intuitively, `add`, `sub`, `mul`,
`div`, and `mod`.

I'll present addition and integer division/modulus explicitly.  The others
follow in the obvious way.

The addition instruction adds the values in two registers and stores the results
into a third register.  It is written as `add rd, rs1, rs2`, where `rd` is the
name of the destination register (where the result of the addition is stored)
and `rs1` and `rs2` are the two source registers containing the left and right
operands to the addition.

For example, to add the values in registers `x4` and `x7` and store the result
into register `x9` (what could informally be written `x9 := x4 + x7`,) the
instruction would look like:

```assembly
add x9, x4, x7
```

Since all numbers in our computer are integers or natural numbers (i.e., *whole*
numbers) the division instruction is *integer division* and there is a *modulus*
("remainder") instruction.  Integer division works like long division or
compound fractions.  If you need to divide `38 / 5`, you'd normally come up with
a decimal value of `7.6`.  Instead, think of it as the compound fraction `7 3/5`
("seven and three-fifths").  The `div` instruction will return the whole number
part of the compound fraction (`7`, the "quotient"), and the `mod` instruction
will return the numerator of the fractional part (`3`, the "remainder").  The
quotient is also the number "on top" after long division and the remainder the
number at the bottom of the arithmetic after long division.

For example, to divide the value in register `x4` by the value in register `x7`,
storing the quotient into `x9` (informally, `x9 := x4 / x7`) and the remainder
into `x10` (informally, `x10 := x4 % x7`, where `%` is the modulus operator), we
would write: 

```assembly
div x9, x4, x7
mod x10, x4, x7
```

**One important note**: The source and destination registers are not required to
be different.  For example, to double the value in register `x4`, I can write:

```assembly
add x4, x4, x4
```

* **[Exercise]** Write a program that multiplies the values in registers `x24`
  and `x19` and stores the result into `x5`.
* **[Exercise]** Write a program that computes the value of the quadratic
  polynomial `ax^2 + bx + c`.  Assume that the value of `x` is stored in
  register `x2`, the value of `a` in `x3`, the value of `b` in `x4`, and the
  value of `c` in `x5`.  Store the final value into register `x1`.
* **[Exercise]** Extend your program to compute the value of cubic polynomials
  (`ax^3 + bx^2 + cx + d`), quartic polynomials (
  `ax^4 + bx^3 + cx^2 + dx + e`), and quintic polynomials (
  `ax^5 + bx^4 + cx^3 + dx^2 + ex + g`).
  * What patterns emerge?
  * How few registers can you do it in?
  * How few instructions can you perform it in?

###### Register-Immediate Arithmetic

Register-immediate arithmetic is nearly identical to register-register
arithmetic.  The difference is that that the second source value is not a
register, but instead a literal hard-coded number.  There is one
register-immediate version of each register-register arithmetic instruction:
`add.i`, `sub.i`, `mul.i`, `div.i`, `mod.i`.  The instructions have a `.i`
appended to their names and take the immediate value as their secound source
argument, but are otherwise identical to their register-register counterparts.

For example, to add `42` to the value in register `x4` and store the result into
register `x9` (what could informally be written `x9 := x4 + 42`,) the
instruction would look like:

```assembly
add.i x9, x4, 42
```

* **[Exercise]** Write a program that computes the value of the quadratic
  polynomial `ax^2 + bx + c` with fixed coefficients.  (I.e., hard-code
  immediate values for `a`, `b`, and `c`.)  Assume that the value of `x` is
  stored in register `x2` and pick any arbitrary values for your coefficients
  you want.  Store the final value into register `x1`.
* **[Exercise]** Extend your program to compute the value of cubic polynomials
  (`ax^3 + bx^2 + cx + d`), quartic polynomials (
  `ax^4 + bx^3 + cx^2 + dx + e`), and quintic polynomials (
  `ax^5 + bx^4 + cx^3 + dx^2 + ex + g`) with fixed coefficients.
  * What patterns emerge?
  * How few registers can you perform it in?
  * How few instructions can you perform it in?
* **[Exercise]** Write a program that multiplies the numers `24` and `19` and
  stores the result into `x5`.

##### Load-Store

Load-Store instructions are deceptively simple.

At first glance, they do exactly what they say: they either load a value from an
address in main memory into a register ("load") or store a value in a register
to an address in main memory ("store").  They have a few bells and whistles
beyond that, but they're pretty straightforward.  They're necessary because of
how our computer is structured.  We need the "load" operation because can't do
"real" computation (arithmetic) on data in memory; we have to load it into a
register first.  We need the "store" operation because we only have a limited
number of registers; we have to free up register space my moving data into main
memory.  Without these, our computer would only be able to store 32 numbers at a
time, which wouldn't be very useful.

These instructions have a hidden depth, though.  Main memory is storage for
*numbers*, and it is addressed by *numbers*.  This gives us the power of
"indirection".  We can store the *address* of a location in main memory in main
memory itself.  And since addresses are just numbers, we can do arithmetic *on
addresses themselves*, then use the results to read from or write to *different*
locations in memory.  We can also follow *chains* of addresses by loading an
address from main memory which itself contains an address in main memory, then
loading *that* address which again contains an address in main memory, etc.,
etc., etc.  Combining this with Flow Control instructions (next section) which
also support this indirect way of using addresses as data unlocks the full power
of computers.

The problem is that it can be very confusing to use this indirection trick.  You
often need to keep multiple layers of "what is going on" in your head and reason
about what it going on in all the different layers simultaneously.  You also
often need to follow these chains of addresses "blindly", not knowing in advance
where they end.  It is very, very easy to make a mistake.  This difficulty is
one of the main source of bugs and security holes in software.  Most modern
languages go to great lengths to prevent this from being a footgun without
nerfing it completely.  (In non-tech speak, to limit how you can use this trick
so that you can't shoot yourself in the foot but without limiting it so much
that it becomes a toy instead of a tool.)  We, on the other hand, are going to
expose it raw and unfiltered.

###### Load

The `load` instruction is straightforward.  It loads a number from an address in
main memory into a register.  The address to load from (the "base" address) is
itself stored in a register.  The main wrinkle is that we also include an
"offset" from the "base" address that is added to the address to compute the
actual address to read from.

The format of the instruction is `load rd, offset(rs)`, where `rd` is the
register to write the loaded value into, `rs` is the register containing the
"base" address, and `offset` is an immediate value with the offset from the base
address.

For example, to load the value stored in main memory at an address four beyond
the address stored in register `x1` into register `x2`, the instruction would
be:

```assembly
load x2, 4(x1)
```

To give concrete values to this, assume that register `x1` contained the value
`10`.  Starting at memory address `10`, the next 5 memory addresses contained
the values `3`, `19`, `99`, `42`, and `1`.  The following sequence of
instructions would load the values `1`, `3`, `19`, `42`, and `99` into registers
`x20`, `x21`, `x22`, `x23`, and `x24`, respectively.

```assembly
load x20, 4(x1)
load x21, 0(x1)
load x22, 1(x1)
load x23, 3(x1)
load x24, 2(x1)
```

* **[Exercies]** Write a program that takes two addresses, stored in registers
  `x2` and `x3`, loads numbers from those addresses, and writes their sum to
  register `x1`.
* **[Exercise]** Write a program that loads 10 values from main memory at
  consecutive addresses, starting at the address stored in `x2`, and writes
  their product into register `x1`.
* **[Exercise]** Revisit your polynomial program(s) from the previous section.
  Rewrite them to take their input as addresses in registers, load the values
  from main memory, and then perform the computation.
* **[Exercise]** Rewrite your polynomial program(s) to take a single base
  address in register `x2`.  At that base address, the value of `x` and the
  values of the coefficients are stored at consecutive memory addresses.
  * How does this affect the number of instructions?
  * How does this affect the number of registers needed?  What's the fewest
    number of registers you can do it in?
* **[Exercise]** Rewrite your polynomial program(s) to take a single base
  address in register `x2`.  At that base address, the address of value of `x`
  and the address (singular) of the coefficients are stored at consecutive
  memory addresses.  At the address of the coefficients, the addresses of the
  values of the coefficients are stored at consecutive memory addresses.
  * How does this affect the number of instructions?
  * How does this affect the number of registers needed?  What's the fewest
    number of registers you can do it in?

###### Store

The `store` instruction is the mirror image of the `load` instruction.  It
stores a value from a register into an address in main memory, also with an
offset.

The format of the instruction is `store rs2, offset(rs1)`, where `rs1` is the
register containing the value to write into main memory, `rs1` is the register
containing the "base" address, and `offset` is an immediate value with the
offset from the base address.

For example, to store the value in register `x2` into main memory at an address
four beyond the address stored in register `x1`, the instruction would be:

```assembly
store x2, 4(x1)
```

* **[Exercise]** Write a program that adds the values in registers `x1` and `x2`
  and stores the result into the address in register `x3`.
* **[Exercise]** Write a program that multiplies the values stored in adjacent
  "pairs" of registers and stores them in consecutive addresses in memory,
  starting at the address in register `x31`.  That is, store the product of
  registers `x1` and `x2` into the address in register `x31`, store the product
  of registers `x2` and `x3` into the address one beyond the address in register
  `x31`, store the product of registers `x3` and `x4` into the address two
  beyond the address in register `x31`, etc.
  * How many pairs of registers can you store this way?  What's the limiting
    factor?
  * If you had a finite amount of main memory, could you "run out" of memory?
* **[Exercise]** Revisit your polynomial program(s).  Rewrite them to take an
  address in `x1` to write the value of the polynomial to.
* **[Exercise]** Revisit your polynomial program(s).  Rewrite them to take an
  address in `x1` that contains an address in main memory which contains the
  address to write the value of the polynomial to.
* **[Exercise]** Extend the first version your polynomial program(s) from the
  "Load" section that take a single base address in `x2` to include an address
  to write the value of the polynomial to.
  * Could you not provide an explicit address to write to and just write the
    output value to one beyond the input?  Why or why not?
* **[Exercise]** Extend the second version your polynomial program(s) from the
  "Load" section that take a single base address in `x2` to include an address
  to write the value of the polynomial to.
  * Could you not provide an explicit address to write to and just write the
    output value to one beyond the input?  Why or why not?

##### Flow Control

Flow control instructions are the special instructions that manipulate the `ip`
register.  The `ip` register "controls" which instruction is to be executed.
During normal instructions, the `ip` "flows" from one instruction to the next in
a straight line, referred to as "the flow of control."  These instructions
manipulate the flow of the `ip` through the program, hence the
slightly-overloaded name "flow control" (they "control the flow of control").

There are two main sub-categories of flow control instructions: unconditional
jumps, and conditional branches.

###### Unconditional Jumps

Unconditional jumps always add a (positive or negative) offset to the current
value in `ip`.  There are two forms: `jal` ("Jump and Link") and `jalr` ("Jump
and Link Register".)  They differ in where they get the offset.

The `jal` instruction takes two operands: a register to write the value `ip`
*would have been* into and an immediate integer value (a literal number of
instructions) to jump forwards or backwards.  After the instruction executes,
the address of the next instruction after the jump instruction will be in the
register given in the instruction, and the value in `ip` will be the address of
the jump instruction plus the offset given in the instruction.  In lieu of an
immediate offset value, a label is allowed.  This is also known as a "direct"
jump, since it is known beforehand exactly where the jump is to.

The `jalr` instruction takes three operands: a register to write the value `ip`
*would have been* into, a register containing an absolute "base" address, and an
immediate integer valued offset from that base address.  After the instruction
executes, the address of the next instruction after the jump instruction will be
in the register given as the first operand, and the value in `ip` will be the
current value in the register given as the second operand plus the immediate
value given as the third operand.  A label is *not* allowed with this
instruction.  This is also known as an "indirect" jump, since the value stored
in the register is not known (by the CPU, at least) until the instruction
executes.  This is the same notion of "indirection" we saw in the Load-Store
instructions.

It may seem strange that the instructions take a register and put the value the
`ip` would have been into it.  This is useful because it allows you to use that
value to "jump back" to where the jump occurred.

For example, convince yourself that this code will always reach the `halt`
instruction with the value of `16` in register `x2` (and a value of `0` in
`x1`).  Notice that while the `halt` instruction is the last instruction
executed, it is *not* the last instruction in the list.  The fact that this
works and is sensible is at the heart of understanding flow control.

```assembly
  add.i x2, x0, 2
  jal x1, double
  jal x1, double
  jal x1, double
  halt

double:
  mul.i x2, x2, 2
  jalr x0, x1, 0
```

* **[Exercise]** Write out in plain language the sequence of steps the above
  program takes and the values of the relevant registers at each step.
* **[Question]** Why is it ok use `x0` in the `jalr` instruction?  Would there
  ever be cases where you wouldn't want to use `x0`?
* **[Exercise]** Revisit your programs for computing the values of polynomials.
  Can you reduce the number of instructions using jumps?

###### Conditional Branches

Conditional branches compare the value in two registers, then either jump to an
address (update `ip` with an offset) or "fall through" to the next instruction
(allow the CPU to increment `ip` as normal) based on the results of the
comparison.

There are four forms of this, based on the comparison to be performed: `beq`
("Branch if equal"), `bne` ("Branch if not equal"), `blt` ("Branch less than"),
and `bge` ("Branch greater than or equal").

All of these instructions have the same operands: they take two registers to
compare (the left and right operands) and an immediate integer value (a literal
number of instructions) to jump forwards or backwards.  In lieu of an explicit
number of instructions, a label is allowed.  There are no "indirect" forms of
these instructions where the offset is read from a register.

If the result of the comparison is true, the offset is added to `ip` and the
branch is taken.  If the result of the comparison is false, the increments `ip`
as normal and continues executing the next instruction, i.e., the flow of
control is not interrupted.

For example, the following decrements the value in register `x1` by one until it
is `0`:

```assembly
loop:
  bge   x0, x1, done
  add.i x1, x1, -1
  jal   x0, loop

done:
  halt
```

* **[Exercise]** Write out in plain language the sequence of steps the above
  program takes and the values of the relevant registers at each step. 
* **[Exercise]** Revisit your programs for computing the values of polynomials.
  Can you reduce the number of instructions using branches?
* **[Exercise]** Extend your polynomial program to handle polynomials of
  "arbitrary" degree ("degree" is the highest power of your polynomial,
  following the same pattern as going from quadratic to cubic to quartic to
  quintic).  Store your final result in `x1`, assume the value of `x` is in
  register `x2`, assume the degree of your polynomial is stored in register
  `x3`, and assume the coefficients are stored in other registers, organized how
  you see fit.
  * Is there a limit on how high of a degree polynomial can you handle?  If so,
    what's the limit and what's imposing that limit?
  * Can you exploit the "fall-through" behavior of conditional branches to
    streamline your code?
  * Can you re-use the same code from lower-degree polynomials in higher-degree
    polynomials?

#### An Example Program

Here is an example program to put it all together.  This is the same program
presented at the   Read this and convince yourself that it (rather awkwardly)
multiplies the values in registers `x2` and `x3`, stores their product in
register `x1`, then halts.

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

* **[Exercise]** Does the program *always* reach the `halt` instruction?  If
  not, is there a change that could be made to guarantee that it does?
* **[Exercise]** Extend your polynomial program to handle polynomials of
  unlimited degree.  Store your final result in `x1`, assume the value of `x` is
  in register `x2`, assume the degree of your polynomial is stored in register
  `x3`, and assume register `x4` contains an address in main memory where the
  coefficients are stored in adjacent memory locations.
  * How few instructions can you perform it in?
  * How few registers can you perform it in?
  * Is there a limit to the number of polynomials you can process?
  * Is there any instance where your program doesn't reach a `halt` instruction?
  * If you only had a finite amount of memory, is there an instance where you
    could "run out" of memory?
* **[Exercise]** Modify your polynomial program to take a single address in
  register `x1`.  Assume the value of `x`, the degree of the polynomial, the
  address to write the final result, and the address of the coefficients are
  stored at sequential memory addresses starting at the address in `x1`.
  * How few instructions can you perform it in?
  * How few registers can you perform it in?
  * Is there a limit to the number of polynomials you can process?
  * Is there any instance where your program doesn't reach a `halt` instruction?
  * If you only had a finite amount of memory, is there an instance where you
    could "run out" of memory?
* **[Exercise]** Modify your polynomial program to take a single initial address
  in register `x1`.  Assume the value of `x`, the degree of the polynomial, the
  address to write the final result, the address of the coefficients, and the
  address of the "next" polynomial to process are stored at sequential memory
  addresses starting at the address in `x1`.  Keep computing the value of
  polynomials until the address of the next polynomial is `0`.  (For clarity,
  *do* compute the value the polynomial when the "next" value is `0`.  Do *not*
  try to process a polynomial *at* the address `0`.)  Once completed, store an
  address in register `x1`.  Similar to your input, at this address should be
  the address of the first polynomial processed, the value of the polynomial,
  and the address of the results of the "next" polynomial processed, all at
  sequential memory addresses.  Similar to the input, the last polynomial
  processed should have the value `0` for the address of the "next" result.
  * How few instructions can you perform it in?
  * How few registers can you perform it in?
  * Is there a limit to the number of polynomials you can process?
  * Is there any instance where your program doesn't reach a `halt` instruction?
  * If you only had a finite amount of memory, is there an instance where you
    could "run out" of memory?

Structured Data
---

TODO

Arrays
---

TODO

Linked Lists
---

TODO

Stacks
---

TODO

Queues
---

TODO

Trees
---

TODO

Graphs
---

TODO

Untyped λ Calculus
===

This section is based on the Untyped λ Calculus ("λ" is the lower-case Greek letter "lambda").  This is a very high-level, abstract view of a computer.  You will write some very simple programs to get the feel of writing code in a programming language.

First, we will introduce the grammar of the language which describes the set of valid ("well-formed") statements in the language.  Then we will introduce the evaluation rules of the language which describes how programs run.  Finally, we will give a few introductory problems to solve.

(Work in Progress)

Digital Logic
===

TODO