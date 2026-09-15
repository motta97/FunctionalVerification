class coverage extends uvm_component;
    `uvm_component_utils(coverage)
    command_sequence_item #(WIDTH)command_item;
    uvm_tlm_analysis_fifo #(command_sequence_item) command_fifo;


    covergroup command_transaction_coverage;
        coverpoint command_item.rst_n;
        coverpoint command_item.push;
        coverpoint command_item.pop;
        coverpoint command_item.push_data;
    endgroup

    function new(string name, uvm_component parent);
        super.new(name, parent);
        command_transaction_coverage = new();
    endfunction

    function void build_phase(uvm_phase phase);
        command_fifo = new("command_fifo", this);
    endfunction

    task run_phase(uvm_phase phase);

        forever begin
            command_fifo.get(command_item);
            this.sample_command(command_item);
        end

    endtask

    logic rst_n, push, pop;
    logic [WIDTH-1:0] push_data;




    function void sample_command(command_sequence_item command_item_h);
        this.rst_n = command_item_h.rst_n;
        this.push = command_item_h.push;
        this.pop = command_item_h.pop;
        this.push_data= command_item_h.push_data;
        command_transaction_coverage.sample();
    endfunction 


endclass