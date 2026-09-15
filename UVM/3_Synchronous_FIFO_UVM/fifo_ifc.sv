interface fifo_ifc #(
    parameter int  DEPTH =8,
    parameter int  WIDTH = 8
) (
     input clk
);


    logic             rst_n;
    logic             push;
    logic [WIDTH-1:0] push_data;
    logic             pop;
    logic [WIDTH-1:0] pop_data;
    logic             full;
    logic             empty;


task load_ifc(
    logic push_s, pop_s, rst_n_s, 
    logic [WIDTH-1:0] push_data_s
);

    @(negedge clk);
    rst_n = rst_n_s;
    push = push_s;
    pop = pop_s;
    push_data = push_data_s;

endtask


endinterface