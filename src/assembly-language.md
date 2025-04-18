# Assembly Language

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

At the level of assembly language, a computer is a very simple device with three
main components: main memory, registers, and a CPU.  We'll tackle each one in
turn.  But first, let's talk about numbers.
