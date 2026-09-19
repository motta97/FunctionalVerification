class full_stress_test extends uvm_test;
`uvm_component_utils(full_stress_test)

env env_h;
agent_config agent_config_h;
fifo_sequencer fifo_sequencer_h;
full_stress_sequence full_stress_sequence_h;

function new(string name, uvm_component parent);
    super.new(name, parent);

endfunction

function void build_phase(uvm_phase phase);
    agent_config_h = new(UVM_ACTIVE);
    uvm_config_db #(agent_config)::set(null, "*","agent_config_h", agent_config_h);
    env_h = env::type_id::create("env_h", this);
    full_stress_sequence_h = new("full_stress_sequence_h");
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info(
        "full_stress_test", "I got here at end of elabor. phase", UVM_LOW
    )
    fifo_sequencer_h = env_h.agent_h.fifo_sequencer_h;
    if(fifo_sequencer_h == null)begin
        `uvm_info("full_stress_test", "sequencer is null", UVM_LOW)
    end
    if(full_stress_sequence_h == null)begin
        `uvm_info("full_stress_test", "sequence itself is null", UVM_LOW)
    end
endfunction

task run_phase(uvm_phase phase);
    `uvm_info(
        "full_stress_test", "I got here at run phase", UVM_LOW
    )
    phase.raise_objection(this);

        full_stress_sequence_h.start(fifo_sequencer_h);

    phase.drop_objection(this);

endtask


endclass