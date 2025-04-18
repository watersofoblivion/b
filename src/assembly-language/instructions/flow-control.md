# Flow Control

Flow control instructions are the special instructions that manipulate the `ip`
register.  The `ip` register "controls" which instruction is to be executed.
During normal instructions, the `ip` "flows" from one instruction to the next in
a straight line, referred to as "the flow of control."  These instructions
manipulate the flow of the `ip` through the program, hence the
slightly-overloaded name "flow control" (they "control the flow of control").

There are two main sub-categories of flow control instructions: unconditional
jumps, and conditional branches.

## Unconditional Jumps

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

## Conditional Branches

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
