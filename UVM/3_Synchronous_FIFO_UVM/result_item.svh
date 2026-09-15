class result_item #(int WIDTH =8) extends uvm_transaction;
    `uvm_object_utils(result_item #(WIDTH))
    logic [WIDTH -1: 0] pop_data;
    logic full, empty;
    bit same;

    function new(string name="result_item");
        super.new(name);
    endfunction

    function void do_copy(uvm_object rhs);

        result_item #(WIDTH) temp ;

        if(rhs == null)
            `uvm_fatal("result_item", "can't copy to a null reference")
        if(!$cast(temp, rhs))
            `uvm_fatal("result_item", "incompatible types")

        super.do_copy(rhs);
        this.pop_data= temp.pop_data;
        this.full = temp.full;
        this.empty = temp.empty;

    endfunction

    function bit do_compare(uvm_object rhs, uvm_comparer comparer);

        result_item #(WIDTH) temp ;
        if(rhs == null)
            `uvm_fatal("result_item", "can't compare to a null reference")

        if(!$cast(temp, rhs)) begin
            same = 0;
            return same;
        end

        same = super.do_compare(rhs, comparer)
            && this.pop_data == temp.pop_data
            && this.empty == temp.empty
            && this.full == temp.full;
        return same;
    endfunction

    function string convert2string();
        return $sformatf(" Actual values are: empty = %0d, full =%0d, pop_data= %0d",
        empty, full, pop_data);
    endfunction




endclass