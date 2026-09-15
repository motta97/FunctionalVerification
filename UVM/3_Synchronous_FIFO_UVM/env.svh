class env extends uvm_env;
`uvm_component_utils(env)

agent agent_h;
scoreboard scoreboard_h;
coverage coverage_h;

function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void build_phase (uvm_phase phase);
    agent_h = agent::type_id::create("agent_h", this);
    scoreboard_h = scoreboard::type_id::create("scoreboard_h", this);
    coverage_h = coverage::type_id::create("coverage_h", this);
endfunction

function void connect_phase(uvm_phase phase);
    agent_h.command_port.connect(scoreboard_h.command_fifo.analysis_export);
    agent_h.command_port.connect(coverage_h.command_fifo.analysis_export);
    agent_h.result_port.connect(scoreboard_h.result_fifo.analysis_export);
endfunction







endclass