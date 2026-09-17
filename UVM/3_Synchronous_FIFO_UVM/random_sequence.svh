class random_sequence extends uvm_sequence #(command_sequence_item);
    `uvm_object_utils(random_sequence)
    command_sequence_item #(WIDTH) command_transaction;
    result_item #(WIDTH) result_item_h;
    uvm_tlm_analysis_fifo #(result_item) result_fifo_h;

    function new(string name="random_sequence");
        super.new(name);
        result_fifo_h = new("result_fifo_h");
        //the above line was in the build phase below, but I had the
        //error of bad handle or reference when that fifo was accessed
        //in the random_test class, so putting it here, make its instantiaiton
        //even earlier to overcome such errors.
    endfunction

    task body();
        repeat(5)begin
             command_transaction = command_sequence_item #(WIDTH)::type_id::create("command_transaction");
            start_item(command_transaction);
                command_transaction.rst_n=0;
            finish_item(command_transaction);
              `uvm_info("ranodm_seqeuence","DID I GET HERE BEFORE GETTING THE RESULT?",UVM_HIGH)
            result_fifo_h.get(result_item_h);
            `uvm_info("ranodm_seqeuence","DID I GET HERE AFTER GETTING THE RESULT?",UVM_HIGH)
        end

        repeat(100)begin
            
            //we've added feedback from our dut to the sequence

            `uvm_info("ranodm_seqeuence","DID I GET HERE?",UVM_HIGH)
            command_transaction = command_sequence_item #(WIDTH)::type_id::create("command_transaction");
            
            start_item(command_transaction);
                assert(command_transaction.randomize() with{
                    if(result_item_h.full){
                        command_transaction.push!=1;
                    }
                    if(result_item_h.empty){
                        command_transaction.pop!=1;
                    }
                });
                `uvm_info("ranodm_seqeuence",command_transaction.convert2string(),UVM_LOW)
            finish_item(command_transaction);
            result_fifo_h.get(result_item_h);
        end

    endtask

endclass