package fifo_pkg;
    //as usual bottom-up approach

    import uvm_pkg::*;
    import fifo_config_pkg::*;
    `include "uvm_macros.svh"
    `include "command_sequence_item.svh"
    `include "result_item.svh"
    `include "fifo_sequencer.svh"
    `include "command_monitor.svh"
    `include "result_monitor.svh"
    `include "driver.svh"
    `include "agent_config.svh"
    `include "agent.svh"
    `include "scoreboard.svh"
    `include "coverage.svh"
    `include "env.svh"
    `include "random_sequence.svh"
    `include "full_stress_sequence.svh"
    `include "random_test.svh"
    `include "full_stress_test.svh"

endpackage;














