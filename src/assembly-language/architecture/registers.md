# Registers

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

## Special Registers

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