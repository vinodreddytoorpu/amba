
class apb5_environment_config extends uvm_object;

  bit is_requester;
  bit is_completer;

  int no_of_requester;
  int no_of_completer;

  apb5_requester_config requester_cfg[];
  apb5_completer_config completer_cfg[];

  `uvm_object_utils_begin(apb5_environment_config)
    `uvm_field_int         (no_of_requester, UVM_ALL_ON)
    `uvm_field_int         (no_of_completer, UVM_ALL_ON)
    `uvm_field_array_object(requester_cfg,   UVM_ALL_ON)
    `uvm_field_array_object(completer_cfg,   UVM_ALL_ON)
  `uvm_object_utils_end

  extern function new(string name = "apb5_environment_config");

  extern function void build_apb5_requester_config();
  extern function void build_apb5_completer_config();
endclass : apb5_environment_config

function apb5_environment_config::new(string name = "apb5_environment_config");
  super.new(name);
endfunction : new

function void apb5_environment_config::build_apb5_requester_config();
  requester_cfg = new[no_of_requester];
  foreach(requester_cfg[i]) begin
    `uvm_info(get_name(), $sformatf("Creating APB5 Requester Config %0d", i), UVM_LOW)
    requester_cfg[i] = apb5_requester_config::type_id::create($psprintf("requester_cfg%0d", i));
  end
endfunction : build_apb5_requester_config

function void apb5_environment_config::build_apb5_completer_config();
  completer_cfg = new[no_of_completer];
  foreach(completer_cfg[i]) begin
    `uvm_info(get_name(), $sformatf("Creating APB5 Completer Config %0d", i), UVM_LOW)
    completer_cfg[i] = apb5_completer_config::type_id::create($psprintf("completer_cfg%0d", i));
  end
endfunction : build_apb5_completer_config
