# Introduction

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

(Both of those levels are "software", i.e., programs written to run on
computers.  Additionally, I have a placeholder for Digital Logic, which is how
the hardware works.  I don't know if I'll fill that in, but it's there.)

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

## Assmebly Language

The "Assembly Language" section presents software at the lowest level possible.
The language presented uses a simple Assembly Language, loosely based on RISC-V 
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

At the level of assembly language, a computer is a very simple device with three
main components: main memory, registers, and a CPU.  We'll tackle each one in
turn.  But first, let's talk about numbers.

## Untyped λ Calculus

TODO

## Digital Logic

TODO