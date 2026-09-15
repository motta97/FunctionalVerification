class driver extends uvm_driver #(command_sequence_item);
    `uvm_component_utils(driver)

    command_sequence_item #(WIDTH) cmd;
    virtual fifo_ifc #(DEPTH, WIDTH)fifo_ifc_h;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);

    if(!uvm_config_db #(virtual interface fifo_ifc#(DEPTH, WIDTH)) :: get(null,  "*", "ifc", fifo_ifc_h))
        `uvm_fatal("driver", "failed to get the interface")
    endfunction


    task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(cmd);
            fifo_ifc_h.load_ifc(cmd.push, cmd.pop, cmd.rst_n, cmd.push_data);
            seq_item_port.item_done();

        end
    endtask

endclass