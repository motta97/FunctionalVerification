class random_sequence extends uvm_sequence #(command_sequence_item);
    `uvm_object_utils(random_sequence)
    command_sequence_item #(WIDTH) command_transaction;
    function new(string name="random_sequence");
        super.new(name);
    endfunction



    task body();
        repeat(5)begin
             command_transaction = command_sequence_item #(WIDTH)::type_id::create("command_transaction");
            start_item(command_transaction);
                command_transaction.rst_n=0;
            finish_item(command_transaction);
        end     
        repeat(100)begin
             command_transaction = command_sequence_item #(WIDTH)::type_id::create("command_transaction");
            start_item(command_transaction);
                assert(command_transaction.randomize());
            finish_item(command_transaction);
        end

    endtask

endclass