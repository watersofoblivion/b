# Main Memory

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
