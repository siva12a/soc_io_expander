// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_proj_example
 *
 * This is an example of a (trivially simple) user project,
 * showing how the user project can connect to the logic
 * analyzer, the wishbone bus, and the I/O pads.
 *
 * This project generates an integer count, which is output
 * on the user area GPIO pads (digital output only).  The
 * wishbone connection allows the project to be controlled
 * (start and stop) from the management SoC program.
 *
 * See the testbenches in directory "mprj_counter" for the
 * example programs that drive this user project.  The three
 * testbenches are "io_ports", "la_test1", and "la_test2".
 *
 *-------------------------------------------------------------
 */

module user_proj_example #(
    parameter BITS = 32
)(

`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

   // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,
  
    input   user_clock2,
    // IRQ
    output [2:0] irq
);
    
 
    
    
    // IRQ
    assign irq = 3'b000;	// Unused

    // LA
    assign la_data_out = 128'h0000_0000_0000_0000_0000_0000_0000_0000;

    
    
    
    
    wire  w_wbs_ack_o;
    wire  [31:0] w_wbs_dat_o; 
   
    assign wbs_ack_o = w_wbs_ack_o;
    assign wbs_dat_o = w_wbs_dat_o;
   
   
   
    wire  [31:0]    w_gpi;
    wire  [31:0]    w_gpo;
    wire  [31:0]    w_gpio_oe;
  
    wire  w_hb_o;
   
   
   
  assign io_out[31:0] = w_gpo;
   assign io_oeb[31:0] = w_gpio_oe[31:0];
   assign w_gpi = io_in[31:0];
   
   
   assign io_out[36] = w_hb_o;
   assign io_oeb[36] = 1'b0;
 
 
   
   
   
  peripheral_top  peripheral_top(
    .wb_clk_i    (wb_clk_i ),
    .wb_rst_i    (wb_rst_i ),
    .wbs_stb_i   (wbs_stb_i),
    .wbs_cyc_i   (wbs_cyc_i),
    .wbs_we_i    (wbs_we_i ),
    .wbs_sel_i   (wbs_sel_i),
    .wbs_dat_i   (wbs_dat_i),
    .wbs_adr_i   (wbs_adr_i),
    .wbs_ack_o   (w_wbs_ack_o),
    .wbs_dat_o   (w_wbs_dat_o),
    
    .gpi         (w_gpi    ),
    .gpo         (w_gpo    ),
    .gpio_oe     (w_gpio_oe),
                
    .hb_o        (w_hb_o)
  
    );
   
   
   
   
 
endmodule

`default_nettype wire
