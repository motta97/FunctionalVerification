class agent_config;

    uvm_active_passive_enum is_active;

    function new(uvm_active_passive_enum is_active);
        this.is_active = is_active;
    endfunction

    function uvm_active_passive_enum get_is_active();
        return is_active;
    endfunction

endclass