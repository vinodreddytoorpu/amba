
class apb5_requester_config extends uvm_object;

  string vif_path = "null";
  
  uvm_active_passive_enum is_active;

  `uvm_object_utils_begin(apb5_requester_config)
    `uvm_field_string(vif_path               ,            UVM_ALL_ON)
    `uvm_field_enum  (uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_object_utils_end

  extern function new(string name = "apb5_requester_config");
endclass : apb5_requester_config

function apb5_requester_config::new(string name = "apb5_requester_config");
  super.new(name);
endfunction : new
