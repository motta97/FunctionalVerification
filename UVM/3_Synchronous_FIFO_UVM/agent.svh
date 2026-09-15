class agent extends uvm_agent;

    `uvm_component_utils(agent)

    uvm_active_passive_enum is_active;
    virtual fifo_ifc #(DEPTH,WIDTH)fifo_ifc_h;
    uvm_analysis_export #(command_sequence_item) command_port;
    uvm_analysis_export #(result_item) result_port;

    command_monitor command_monitor_h;
    result_monitor result_monitor_h;
    agent_config agent_config_h;
    fifo_sequencer fifo_sequencer_h;
    driver driver_h;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);

        if(!uvm_config_db #(virtual interface fifo_ifc#(DEPTH,WIDTH))::get(null, "*", "ifc", fifo_ifc_h))
            `uvm_fatal("agent", "failed to get the interface")
        if(!uvm_config_db #(agent_config)::get(null, "*", "agent_config_h", agent_config_h))
            `uvm_fatal("agent", "failed to get the config item")
            
        is_active = agent_config_h.get_is_active();
        command_monitor_h = command_monitor::type_id::create("command_monitor_h", this);
        result_monitor_h = result_monitor::type_id::create("result_monitor_h", this);
        command_port = new("command_port", this);
        result_port = new("result_port", this);

        if(get_is_active()==UVM_ACTIVE)begin
            driver_h = driver::type_id::create("driver_h", this);
            fifo_sequencer_h = new("fifo_sequencer_h");
        end

    endfunction

    function void connect_phase(uvm_phase phase);
        command_monitor_h.command_port.connect(command_port);
        result_monitor_h.result_port.connect(result_port);
        if(get_is_active()==UVM_ACTIVE)begin
            driver_h.seq_item_port.connect(fifo_sequencer_h.seq_item_export);
        end
    endfunction

endclass