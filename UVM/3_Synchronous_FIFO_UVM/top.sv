import fifo_pkg::*;
import uvm_pkg::*;
import fifo_config_pkg::*;
`include "uvm_macros.svh"
`include "FIFO.v"
`include "fifo_ifc.sv"
module top;


    reg clk;

    fifo_ifc #(DEPTH, WIDTH) ifc(.clk(clk));
    fifo #(DEPTH, WIDTH)    dut  (.push(ifc.push), .pop(ifc.pop), 
        .push_data(ifc.push_data), .rst_n(ifc.rst_n),
        .pop_data(ifc.pop_data),.clk(clk), .full(ifc.full), .empty(ifc.empty)
    );

    initial begin
        clk = 1;
        uvm_config_db #(virtual interface fifo_ifc#(DEPTH, WIDTH))::set(null, "*", "ifc", ifc);
        fork 
                forever begin
                    #5 clk= ~clk;
                end

        join_none

    run_test();



    end












endmodule