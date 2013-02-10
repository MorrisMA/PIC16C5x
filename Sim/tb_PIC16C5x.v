///////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2008-2013 by Michael A. Morris, dba M. A. Morris & Associates
//
//  All rights reserved. The source code contained herein is publicly released
//  under the terms and conditions of the GNU Lesser Public License. No part of
//  this source code may be reproduced or transmitted in any form or by any
//  means, electronic or mechanical, including photocopying, recording, or any
//  information storage and retrieval system in violation of the license under
//  which the source code is released.
//
//  The source code contained herein is free; it may be redistributed and/or 
//  modified in accordance with the terms of the GNU Lesser General Public
//  License as published by the Free Software Foundation; either version 2.1 of
//  the GNU Lesser General Public License, or any later version.
//
//  The source code contained herein is freely released WITHOUT ANY WARRANTY;
//  without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
//  PARTICULAR PURPOSE. (Refer to the GNU Lesser General Public License for
//  more details.)
//
//  A copy of the GNU Lesser General Public License should have been received
//  along with the source code contained herein; if not, a copy can be obtained
//  by writing to:
//
//  Free Software Foundation, Inc.
//  51 Franklin Street, Fifth Floor
//  Boston, MA  02110-1301 USA
//
//  Further, no use of this source code is permitted in any form or means
//  without inclusion of this banner prominently in any derived works. 
//
//  Michael A. Morris
//  Huntsville, AL
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

///////////////////////////////////////////////////////////////////////////////
// Company:         M. A. Morris & Associates 
// Engineer:        Michael A. Morris
//
// Create Date:     11:48:46 02/18/2008
// Design Name:     PIC16C5x
// Module Name:     C:/ISEProjects/ISE10.1i/P16C5x/tb_PIC16C5x.v
// Project Name:    PIC16C5x
// Target Device:   Spartan-II  
// Tool versions:   ISEWebPACK 10.1i SP3  
//
// Description: Verilog Test Fixture created by ISE for module: PIC16C5x. Test
//              program used to verify the execution engine. Test program uses
//              all of the instructions in the PIC16C5x instructions. Program
//              memory address range is not explicitly tested.
//
// Dependencies:	PIC16C5x.v 
//
// Revision: 
//
// 	0.01 	08B17	MAM	    File Created
//
// Additional Comments: 
//
///////////////////////////////////////////////////////////////////////////////

module tb_PIC16C5x_v;

	// UUT Module Ports
	reg     POR;

	reg     Clk;
	reg     ClkEn;

	wire    [11:0] PC;
	reg     [11:0] IR;

	wire    [3:0] TRISA;
	wire    [3:0] PORTA;
	reg     [3:0] PA_DI;
 
    wire    [7:0] TRISB;
	wire    [7:0] PORTB;
	reg     [7:0] PB_DI;

	wire    [7:0] TRISC;
	wire    [7:0] PORTC;
	reg     [7:0] PC_DI;

	reg     MCLR;
	reg     T0CKI;
	reg     WDTE;

	// UUT Module Test Ports
    
	wire    Err;
	
    wire    [5:0] OPTION;

    wire    [ 8:0] dIR;
	wire    [11:0] ALU_Op;
	wire    [ 8:0] KI;
	wire    Skip;

 	wire    [11:0] TOS;
	wire    [11:0] NOS;

	wire    [7:0] W;

	wire    [6:0] FA;
	wire    [7:0] DO;
	wire    [7:0] DI;

	wire    [7:0] TMR0;
	wire    [7:0] FSR;
	wire    [7:0] STATUS;
	
    wire    T0CKI_Pls;
	
    wire    WDTClr;
	wire    [9:0] WDT;
	wire    WDT_TC;
	wire    WDT_TO;
	
    wire    [7:0] PSCntr;
	wire    PSC_Pls;
    
	// Instantiate the Unit Under Test (UUT)
	PIC16C5x #(.WDT_Size(10))
             uut (.POR(POR), 
                  .Clk(Clk), 
                  .ClkEn(ClkEn), 
                  .PC(PC), 
                  .IR(IR), 
                  .TRISA(TRISA), 
                  .PORTA(PORTA), 
                  .PA_DI(PA_DI), 
                  .TRISB(TRISB), 
                  .PORTB(PORTB), 
                  .PB_DI(PB_DI), 
                  .TRISC(TRISC), 
                  .PORTC(PORTC), 
                  .PC_DI(PC_DI), 
                  .MCLR(MCLR), 
                  .T0CKI(T0CKI), 
                  .WDTE(WDTE), 
                  .Err(Err), 
                  .OPTION(OPTION), 
                  .dIR(dIR), 
                  .ALU_Op(ALU_Op), 
                  .KI(KI), 
                  .Skip(Skip), 
                  .TOS(TOS), 
                  .NOS(NOS), 
                  .W(W), 
                  .FA(FA), 
                  .DO(DO), 
                  .DI(DI), 
                  .TMR0(TMR0), 
                  .FSR(FSR), 
                  .STATUS(STATUS), 
                  .T0CKI_Pls(T0CKI_Pls), 
                  .WDTClr(WDTClr), 
                  .WDT(WDT), 
                  .WDT_TC(WDT_TC), 
                  .WDT_TO(WDT_TO), 
                  .PSCntr(PSCntr), 
                  .PSC_Pls(PSC_Pls));

	initial begin
		// Initialize Inputs
		POR     = 1;
		Clk     = 1;
        ClkEn   = 1;
		IR      = 0;
		PA_DI   = 0;
		PB_DI   = 0;
		PC_DI   = 0;
		MCLR    = 0;
		T0CKI   = 0;
		WDTE    = 1;

		// Wait 100 ns for global reset to finish
		#101;

        POR = 0;
//        ClkEn = 1;

        #899;
        
	end
    
    always #5 Clk = ~Clk;
    
//    always @(posedge Clk)
//    begin
//        if(POR)
//            #1 ClkEn <= 0;
//        else
//            #1 ClkEn <= ~ClkEn;
//    end
    
    // Test Program ROM
      
    always @(PC or POR)
    begin
        if(POR)
            IR <= 12'b0000_0000_0000;    // NOP             ;; No Operation
        else 
            case(PC[11:0])
                12'h000 : IR = 12'b0111_0110_0011;   // BTFSS   0x03,3  ;; Test PD (STATUS.3), if set, not SLEEP restart
                12'h001 : IR = 12'b1010_0011_0000;   // GOTO    0x030   ;; SLEEP restart, continue test program
                12'h002 : IR = 12'b1100_0000_0111;   // MOVLW   0x07    ;; load OPTION
                12'h003 : IR = 12'b0000_0000_0010;   // OPTION
                12'h004 : IR = 12'b0000_0100_0000;   // CLRW            ;; clear working register
                12'h005 : IR = 12'b0000_0000_0101;   // TRISA           ;; load W into port control registers
                12'h006 : IR = 12'b0000_0000_0110;   // TRISB
                12'h007 : IR = 12'b0000_0000_0111;   // TRISC
                12'h008 : IR = 12'b1010_0000_1010;   // GOTO    0x00A   ;; Test GOTO
                12'h009 : IR = 12'b1100_1111_1111;   // MOVLW   0xFF    ;; instruction should be skipped
                12'h00A : IR = 12'b1001_0000_1101;   // CALL    0x0D    ;; Test CALL
                12'h00B : IR = 12'b0000_0010_0010;   // MOVWF   0x02    ;; Test Computed GOTO, Load PCL with W
                12'h00C : IR = 12'b0000_0000_0000;   // NOP             ;; No Operation
                12'h00D : IR = 12'b1000_0000_1110;   // RETLW   0x0E    ;; Test RETLW, return 0x0E in W
                12'h00E : IR = 12'b1100_0000_1001;   // MOVLW   0x09    ;; starting RAM + 1
                12'h00F : IR = 12'b0000_0010_0100;   // MOVWF   0x04    ;; indirect address register (FSR)
//
                12'h010 : IR = 12'b1100_0001_0111;   // MOVLW   0x17    ;; internal RAM count - 1
                12'h011 : IR = 12'b0000_0010_1000;   // MOVWF   0x08    ;; loop counter
                12'h012 : IR = 12'b0000_0100_0000;   // CLRW            ;; zero working register
                12'h013 : IR = 12'b0000_0010_0000;   // MOVWF   0x00    ;; clear RAM indirectly
                12'h014 : IR = 12'b0010_1010_0100;   // INCF    0x04,1  ;; increment FSR
                12'h015 : IR = 12'b0010_1110_1000;   // DECFSZ  0x08,1  ;; decrement loop counter
                12'h016 : IR = 12'b1010_0001_0011;   // GOTO    0x013   ;; loop until loop counter == 0
                12'h017 : IR = 12'b1100_0000_1001;   // MOVLW   0x09    ;; starting RAM + 1
                12'h018 : IR = 12'b0000_0010_0100;   // MOVWF   0x04    ;; reload FSR
                12'h019 : IR = 12'b1100_1110_1001;   // MOVLW   0xE9    ;; set loop counter to 256 - 23
                12'h01A : IR = 12'b0000_0010_1000;   // MOVWF   0x08
                12'h01B : IR = 12'b0010_0000_0000;   // MOVF    0x00,0  ;; read memory into W 
                12'h01C : IR = 12'b0011_1110_1000;   // INCFSZ  0x08,1  ;; increment counter loop until 0
                12'h01D : IR = 12'b1010_0001_1011;   // GOTO    0x01B   ;; loop    
                12'h01E : IR = 12'b0000_0000_0100;   // CLRWDT          ;; clear WDT
                12'h01F : IR = 12'b0000_0110_1000;   // CLRF    0x08    ;; Clear Memory Location 0x08
//
                12'h020 : IR = 12'b0010_0110_1000;   // DECF    0x08,1  ;; Decrement Memory Location 0x08
                12'h021 : IR = 12'b0001_1100_1000;   // ADDWF   0x08,0  ;; Add Memory Location 0x08 to W, Store in W
                12'h022 : IR = 12'b0000_1010_1000;   // SUBWF   0x08,1  ;; Subtract Memory Location 0x08
                12'h023 : IR = 12'b0011_0110_1000;   // RLF     0x08,1  ;; Rotate Memory Location 0x08
                12'h024 : IR = 12'b0011_0010_1000;   // RRF     0x08,1  ;; Rotate Memory Location
                12'h025 : IR = 12'b1100_0110_1001;   // MOVLW   0x69    ;; Load W with test pattern: W <= 0x69
                12'h026 : IR = 12'b0000_0010_1000;   // MOVWF   0x08    ;; Initialize Memory with test pattern
                12'h027 : IR = 12'b0011_1010_1000;   // SWAPF   0x08,1  ;; Test SWAPF: (0x08) <= 0x96 
                12'h028 : IR = 12'b0001_0010_1000;   // IORWF   0x08,1  ;; Test IORWF: (0x08) <= 0x69 | 0x96 
                12'h029 : IR = 12'b0001_0110_1000;   // ANDWF   0x08,1  ;; Test ANDWF: (0x08) <= 0x69 & 0xFF
                12'h02A : IR = 12'b0001_1010_1000;   // XORWF   0x08,1  :: Test XORWF: (0x08) <= 0x69 ^ 0x69
                12'h02B : IR = 12'b0010_0110_1000;   // COMF    0x08    ;; Test COMF:  (0x08) <= ~0x00  
                12'h02C : IR = 12'b1101_1001_0110;   // IORLW   0x96    ;; Test IORLW:      W <= 0x69 | 0x96
                12'h02D : IR = 12'b1110_0110_1001;   // ANDLW   0x69    ;; Test ANDLW:      W <= 0xFF & 0x69
                12'h02E : IR = 12'b1111_0110_1001;   // XORLW   0x69    ;; Test XORLW:      W <= 0x69 ^ 0x69
                12'h02F : IR = 12'b0000_0000_0011;   // SLEEP           ;; Stop Execution of test program: HALT
//
                12'h030 : IR = 12'b0000_0000_0100;   // CLRWDT          ;; Detected SLEEP restart, Clr WDT to reset PD
                12'h031 : IR = 12'b0110_0110_0011;   // BTFSC   0x03,3  ;; Check STATUS.3, skip if ~PD clear
                12'h032 : IR = 12'b1010_0011_0100;   // GOTO    0x034   ;; ~PD is set, CLRWDT cleared PD
                12'h033 : IR = 12'b1010_0011_0011;   // GOTO    0x033   ;; ERROR: hold here on error
                12'h034 : IR = 12'b1100_0001_0000;   // MOVLW   0x10    ;; Load FSR with non-banked RAM address
                12'h035 : IR = 12'b0000_0010_0100;   // MOVWF   0x04    ;; Initialize FSR for Bit Processor Tests
                12'h036 : IR = 12'b0000_0110_0000;   // CLRF    0x00    ;; Clear non-banked RAM location using INDF
                12'h037 : IR = 12'b0101_0000_0011;   // BSF     0x03,0  ;; Set   STATUS.0 (C) bit 
                12'h038 : IR = 12'b0100_0010_0011;   // BCF     0x03,1  ;; Clear STATUS.1 (DC) bit
                12'h039 : IR = 12'b0100_0100_0011;   // BCF     0x03,2  ;; Clear STATUS.2 (Z) bit
                12'h03A : IR = 12'b0010_0000_0011;   // MOVF    0x03,0  ;; Load W with STATUS
                12'h03B : IR = 12'b0011_0000_0000;   // RRF     0x00,0  ;; Rotate Right RAM location: C <= 0,      W <= 0x80
                12'h03C : IR = 12'b0011_0110_0000;   // RLF     0x00,0  ;; Rotate Left  RAM location: C <= 0, (INDF) <= 0x00
                12'h03D : IR = 12'b0000_0010_0000;   // MOVWF   0x00    ;; Write result back to RAM: (INDF) <= 0x80
                12'h03E : IR = 12'b0000_0010_0001;   // MOVWF   0x01    ;; Write to TMR0, clear Prescaler
                12'h03F : IR = 12'b1010_0000_0000;   // GOTO    0x000   ;; Restart Program
//
                default : IR = 12'b0000_0000_0000;   // NOP             ;; Reset Vector: Jump 0x000 (Start)
            endcase
    end
    
endmodule

