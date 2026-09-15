class command_sequence_item #(int WIDTH = 8) extends uvm_sequence_item;
`uvm_object_utils(command_sequence_item #(WIDTH))

    function new (string name = "command_sequence_item");
        super.new(name);
    endfunction

rand bit rst_n;
rand bit push;
rand bit pop;
rand logic [WIDTH-1: 0] push_data;

bit same ;
constraint c{
    rst_n dist{0:=10, 1:=90};

};
function void do_copy(uvm_object rhs );
command_sequence_item #(WIDTH) temp;

    if(rhs == null)
        `uvm_fatal("command_sequence_item", "can't copy a null reference")
    if(!$cast(temp, rhs))
        `uvm_fatal("command_sequence_item","incompatiple types" )

    this.rst_n = temp.rst_n;
    this.push = temp.push;
    this.pop = temp.pop;
    this.push_data = temp.push_data;
    super.do_copy(rhs);

endfunction

function bit do_compare(uvm_object rhs, uvm_comparer comparer );

    command_sequence_item #(WIDTH) temp ;

    if(rhs == null)begin
        `uvm_fatal("command_sequence_item", "comparing to a null pointer!")
    end

    if(!$cast(temp,rhs))begin
        same = 0;
        return same;
    end
    same = super.do_compare(rhs, comparer)
        && this.push_data == temp.push_data 
        && this.push == temp.push
        && this.pop == temp.pop
        && this.rst_n == temp.rst_n;

    return same;

endfunction

function string convert2string();
    return $sformatf("rst_n is %d, pop is %0d, push is %0d, push_data is %0d", rst_n, pop, push, push_data);
endfunction


endclass