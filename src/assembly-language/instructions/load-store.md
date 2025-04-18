# Load-Store

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

## Load

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

## Store

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
