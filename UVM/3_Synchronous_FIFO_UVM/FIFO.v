module fifo #(
  parameter DEPTH = 8,
  parameter WIDTH = 8
)(
  input  logic             clk,
  input  logic             rst_n,
  input  logic             push,
  input  logic [WIDTH-1:0] push_data,
  input  logic             pop,
  output logic [WIDTH-1:0] pop_data,
  output logic             full,
  output logic             empty
);

reg [$clog2(DEPTH+1)-1:0] count;

reg [WIDTH - 1: 0] mem [DEPTH -1: 0];
reg [$clog2(DEPTH)-1:0] rd_ptr, wr_ptr;

always @(posedge clk) begin
    if(!rst_n)begin
        rd_ptr <= 0;
        wr_ptr <= 0;
        count <= 0;
        pop_data <= 0;
    end
    else begin
        if(push && !full)begin
                mem[wr_ptr]<=push_data;
                wr_ptr <= (wr_ptr +1)%DEPTH;
        end

        if(pop && !empty)begin
                pop_data <= mem[rd_ptr];
                rd_ptr <= (rd_ptr + 1) % DEPTH;
        end
    case({push && !full, pop && !empty})
        2'b00:
            count<=count;
        2'b01:
            count<=count-1;//can't get to negative sinc we're sure that count is greater
                            //than 0 if we got here since we have non-empty FIFO
        2'b10:
            count<=count+1;
        2'b11:
            count<=count;
    endcase
    end

    // $strobe("values are: count =%0d, rst_n = %0d, pop = %0d, push = %0d, pop_data = %0d, empty = %0d, full = %0d, push_data = %0d at time %0d", 
    // count, rst_n, pop, push, pop_data, empty, full, push_data, $time);
end
assign full = (count == 8);
assign empty = (count == 0);



endmodule