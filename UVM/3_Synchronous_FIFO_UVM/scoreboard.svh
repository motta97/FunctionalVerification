class scoreboard extends uvm_component;
    `uvm_component_utils(scoreboard)

    uvm_tlm_analysis_fifo #(command_sequence_item) command_fifo;
    uvm_tlm_analysis_fifo #(result_item) result_fifo;
    command_sequence_item #(WIDTH) command_h;
    result_item #(WIDTH) result_h ;
    bit [WIDTH-1:0] q[$];
    bit same;
    string expected_values;
    string command;
    result_item #(WIDTH)predicted_result;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        command_fifo = new("command_fifo", this);
        result_fifo = new("result_fifo", this);
        predicted_result = result_item #(WIDTH)::type_id::create("predicted_result", this);
    endfunction
    /*
    which signals do we have?
    push, push_data, pop, pop_data, empty, full, rst_n
    */

    task run_phase(uvm_phase phase);
    forever begin
        same = 1;
        command_fifo.get(command_h);
        result_fifo.get(result_h);
        if(command_h.rst_n==0)begin
            q.delete();
            predicted_result.empty =1'b1;
            predicted_result.full = 1'b0;
            predicted_result.pop_data = 1'b0;
        end

        else begin
            if(command_h.pop)begin
                if(q.size()!=0)begin
                    predicted_result.pop_data = q.pop_front();
                end
            end

            if(command_h.push)begin
                if(q.size()!=DEPTH)begin
                    q.push_back(command_h.push_data);
                end
            end


        end
        if(q.size()==0)begin
            predicted_result.empty = 1'b1;
        end
        else begin
            predicted_result.empty = 1'b0;
        end

        if(q.size()==DEPTH)begin
            predicted_result.full = 1'b1;

        end
        else begin
            predicted_result.full = 1'b0;
        end



        if(!result_h.compare(predicted_result))
            same = 0;

        command= $sformatf("Command values are: rst_n = %0d, push = %0d, pop = %0d, push_data = %0d ",
        command_h.rst_n, command_h.push, command_h.pop, command_h.push_data);
        expected_values = $sformatf("Expected values are: empty = %0d, full = %0d, pop_data = %0d ", predicted_result.empty, predicted_result.full, predicted_result.pop_data );

        if(same)begin
            `uvm_info("SCOREBOARD", {"PASS ", command, expected_values, result_h.convert2string()}, UVM_LOW)
        end
        else begin

            `uvm_error("SCOREBOARD ERROR",{command, expected_values, result_h.convert2string()} );
        end
    end


    endtask



endclass