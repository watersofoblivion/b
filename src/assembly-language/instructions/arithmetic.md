# Arithmetic

The simplest instructions are arithmetic.  There are two sub-categories of
arithmetic: "register-register" arithmetic, and "register-immediate" arithmetic.

These are "normal" instructions that do not alter the `ip` register.

## Register-Register Arithmetic

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

## Register-Immediate Arithmetic

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
