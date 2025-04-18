# Numbers

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
