
class apb5_completer_config extends uvm_object;

  string vif_path = "null";

  uvm_active_passive_enum is_active;

  bit [31:0] addr_range_start;
  bit [31:0] addr_range_end;
  bit [31:0] addr_size;

  `uvm_object_utils_begin(apb5_completer_config)
    `uvm_field_string(vif_path               ,            UVM_ALL_ON)
    `uvm_field_int   (addr_range_start       ,            UVM_ALL_ON)
    `uvm_field_int   (addr_range_end         ,            UVM_ALL_ON)
    `uvm_field_int   (addr_size              ,            UVM_ALL_ON)
    `uvm_field_enum  (uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_object_utils_end

  extern function new(string name = "apb5_completer_config");
endclass : apb5_completer_config

function apb5_completer_config::new(string name = "apb5_completer_config");
  super.new(name);
endfunction : new
