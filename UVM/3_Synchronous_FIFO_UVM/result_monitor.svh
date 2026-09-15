class result_monitor extends uvm_monitor;

`uvm_component_utils(result_monitor)

result_item #(WIDTH) result ;
uvm_analysis_port #(result_item) result_port;
virtual fifo_ifc #(DEPTH, WIDTH)fifo_ifc_h; 
function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    result_port = new ("result_port", this);
    result = new("result");
    if(!uvm_config_db #(virtual interface fifo_ifc #(DEPTH, WIDTH))::get(null, "*", "ifc", fifo_ifc_h))
        `uvm_fatal("result_monitor", "failed to get the interface")

endfunction
task run_phase(uvm_phase phase);

forever begin
    @(posedge fifo_ifc_h.clk);
    #1;
    result.pop_data = fifo_ifc_h.pop_data;
    result.empty = fifo_ifc_h.empty;
    result.full = fifo_ifc_h.full;
    result_port.write(result);
    
end

endtask





endclass