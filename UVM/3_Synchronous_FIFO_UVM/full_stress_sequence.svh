class full_stress_sequence extends uvm_sequence #(command_sequence_item);

`uvm_object_utils(full_stress_sequence)
command_sequence_item #(WIDTH)command_transaction;
function new(string name="full_stress_sequence");
    super.new(name);
endfunction

function void build_phase(uvm_phase phase);

    command_transaction = command_sequence_item#(WIDTH)::type_id::create("command_transaction");


endfunction

task body();

start_item(command_transaction);
command_transaction.rst_n=0;
finish_item(command_transaction);

repeat(DEPTH*2)begin
    start_item(command_transaction);
        command_transaction.rst_n<=1;
        command_transaction.push <= 1;
        command_transaction.pop <=0;
        command_transaction.push_data <= 1;//can be any number in the valid range
    finish_item(command_transaction);
end


endtask



endclass