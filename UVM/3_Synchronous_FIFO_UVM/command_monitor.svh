class command_monitor extends uvm_monitor;


`uvm_component_utils(command_monitor)
uvm_analysis_port #(command_sequence_item) command_port;
virtual fifo_ifc #(DEPTH, WIDTH)fifo_ifc_h;
command_sequence_item #(WIDTH) cmd ;
function new (string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    command_port = new("command_port", this);
    cmd = new("cmd");
    if(!uvm_config_db #(virtual interface fifo_ifc #(DEPTH, WIDTH))::get(null, "*", "ifc", fifo_ifc_h))
        `uvm_fatal("command_monitor", "failed to get the interface");

endfunction


task run_phase(uvm_phase phase);

forever begin
    @(posedge fifo_ifc_h.clk);
    #1; 
    cmd.push_data = fifo_ifc_h.push_data;
    cmd.push = fifo_ifc_h.push;
    cmd.pop = fifo_ifc_h.pop;
    cmd.rst_n = fifo_ifc_h.rst_n;
    command_port.write(cmd);
end



endtask










endclass