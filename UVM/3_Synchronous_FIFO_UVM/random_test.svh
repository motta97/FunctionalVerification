class random_test extends uvm_test;
`uvm_component_utils(random_test)

env env_h;
agent_config agent_config_h;
fifo_sequencer fifo_sequencer_h;
random_sequence random_sequence_h;

function void build_phase(uvm_phase phase);
    env_h = env::type_id::create("env_h", this);
    agent_config_h = new(UVM_ACTIVE);
    uvm_config_db #(agent_config)::set(null, "*","agent_config_h", agent_config_h);
    random_sequence_h = new("random_sequence_h");
endfunction

function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info("random_test.end_of_elaboration", "was this ever executed?", UVM_HIGH)
    fifo_sequencer_h = env_h.agent_h.fifo_sequencer_h;
endfunction
function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //NEVER DO A CONNECTION OUTSIDE THE CONNECT PHASE
  env_h.agent_h.result_port.connect(random_sequence_h.result_fifo_h.analysis_export);
    //THE ABOVE LINE WAS INSIDE THE RUN_PHASE AND IT INTRODUCED A BUG THAT TOOK
    //HOURS TO FIND
endfunction
task run_phase(uvm_phase phase);
    `uvm_info("random_test.run_phase", "was this ever executed?", UVM_HIGH)
    phase.raise_objection(this);
        random_sequence_h.start(fifo_sequencer_h);
    phase.drop_objection(this);

endtask


endclass