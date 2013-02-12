PIC16C5x : A Microcontroller Core in Verilog
=======================

Copyright (C) 2013, Michael A. Morris <morrisma@mchsi.com>.
All Rights Reserved.

Released under LGPL.

General Description
-------------------

This project is provides a synthesizable core implementation of the PIC16C5x 
microcontroller. As a core, it has a full complement of PIC16C5x RAM and 
peripherals. However, the user is responsible for providing memory for the 
core's program and for configuring the core's I/O ports.

Features
---------------

The PIC16C5x supports to full instruction set of the PIC16C5x family of 
microcomputers, and it also incorporates the I/O and timers found in the 
family. The core also implements all of the RAM normally found in this family 
of microcomputers.

The timeout period of the watchdog timer is configurable. Although it is 
normally set to be equal to a 20-bit timer, it can be set to be less than that 
for simulation purposes. See the test bench for an example of how to change 
the period of the PIC16C5x core's watch dog timer.

Implementation
--------------

The PIC16C5x core is implemented as a single Verilog-2001 csource file.

    PIC16C5x.v                  -- RTL source file for the PIC16C5x core
        tb_PIC16C5x.v           -- Rudimentary testbench

Synthesis
---------

The objective is for the PIC16C5x to synthesize into a small FPGA, and to be 
able to support an operating frequency greater than that commonly supported by 
a commercial single-chip implementation. The supplied core satisfies both 
objectives.

No special synthesis constraints are required to satisfy a 16 ns clock period 
constraint.

    Number of Slice FFs:            155
    Number of 4-input LUTs:         408 (40 used as 16x1 SP LUT-based RAM)
    Number of Occupied Slices:      307
    Total Number of 4-input LUTs:   453 (45 used as route-throughs)

    Number of BUFGMUXs:             1
    Number of BlockRAMs             0

    Best Case Achievable:           15.930 ns (0.070 ns SETUP; 0.879 ns HOLD )

Status
------

The design, implementation, and test of the core is complete.

Other Notes
-----------
