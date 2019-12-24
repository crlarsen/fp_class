# Verilog IEEE 754 Class Decode

## Description

Modify hp_class module to use Verilog parameters. Rename module to fp_class. Convert to System Verilog file so we have access to $clog2 function. This makes the module useful for all of the IEEE 754 binary types (16-, 32-, 64-, & 128-bits).

Code is explained in the video series [Building an FPU in Verilog](https://www.youtube.com/watch?v=rYkVdJnVJFQ&list=PLlO9sSrh8HrwcDHAtwec1ycV-m50nfUVs).
See the video *Building an FPU in Verilog: Improving the hp_class Module*.

## Manifest

|   Filename   |                        Description                        |
|--------------|-----------------------------------------------------------|
| fp_class.sv  | Updated utility module to identify the IEEE 754 of the value passed in, and extract the exponent & significand fields for use by other modules. |
| fp_class_tb.v  | Verilog testbench code                                    |
| simulate.log-16 | Output from testbench simulation for IEEE 754 binary16 data.         |
| simulate.log-32 | Output from testbench simulation for IEEE 754 binary32 data.         |
| simulate.log-64 | Output from testbench simulation for IEEE 754 binary64 data.         |
| simulate.log-128 | Output from testbench simulation for IEEE 754 binary128 data.         |
| README.md    | This file                                                 |

## Copyright

:copyright: Chris Larsen, 2019
