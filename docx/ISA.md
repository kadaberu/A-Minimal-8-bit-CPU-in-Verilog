# ISA Specification

## Register File

The CPU contains four 8-bit general-purpose registers:

```text
R0
R1
R2
R3
```

------

## Instruction Format

### ADD

```text
 7  6 5  4 3   2 1   0
+----+----+-----+-----+
| 00 | rd | rs1 | rs2 |
+----+----+-----+-----+
```

Operation:

```text
R[rd] = R[rs1] + R[rs2]
```

Description:

Add two registers and store the result in `rd`.

------

### LI (Load Immediate)

```text
 7  6 5  4 3     0
+----+----+-------+
| 10 | rd |  imm  |
+----+----+-------+
```

Operation:

```text
R[rd] = imm
```

Description:

Load a 4-bit immediate value into `rd`.
Upper bits are filled with zeros.

------

### BNER0

```text
 7  6 5   2 1   0
+----+------+-----+
| 11 | addr | rs2 |
+----+------+-----+
```

Operation:

```text
if (R[0] != R[rs2])
    PC = addr;
```

Description:

Branch to `addr` when `R[0]` is not equal to `R[rs2]`.

------

### DISP

```text
 7  6 5  4 3     0
+----+----+-------+
| 01 | rd |unused |
+----+----+-------+
```

Operation:

```text
DISP(R[rd])
```

Description:

Display the value stored in `R[rd]` on the seven-segment display.