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
    env_h = env::type_id::create("env_h", this);
    agent_config_h = new(UVM_ACTIVE);
    uvm_config_db #(agent_config)::set(null, "*","agent_config_h", agent_config_h);

endfunction

function void end_of_elaboration_phase(uvm_phase phase);
    fifo_sequencer_h = env_h.agent_h.fifo_sequencer_h;
endfunction

task run_phase(uvm_phase phase);

    phase.raise_objection(this);
        full_stress_sequence_h = new("full_stress_sequence_h");
        full_stress_sequence_h.start(fifo_sequencer_h);

    phase.drop_objection(this);

endtask


endclass