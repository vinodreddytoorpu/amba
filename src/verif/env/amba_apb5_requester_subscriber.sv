
typedef class amba_environment;

class amba_apb5_requester_subscriber extends uvm_subscriber #(apb5_packet #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH));
  `uvm_component_utils(amba_apb5_requester_subscriber)

  uvm_component parent_comp;

  amba_environment env;

  extern function new(string name = "amba_apb5_requester_subscriber", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void write(apb5_packet #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH) t);
  extern task main_phase(uvm_phase phase);
endclass : amba_apb5_requester_subscriber

function amba_apb5_requester_subscriber::new(string name = "amba_apb5_requester_subscriber", uvm_component parent);
  super.new(name, parent);
endfunction : new

function void amba_apb5_requester_subscriber::build_phase(uvm_phase phase);
  super.build_phase(phase);

  parent_comp = get_parent();

  if(env == null) `uvm_fatal(get_name(), $psprintf("amba_environment env is null, pass it from parent component %0p", parent_comp.get_name()))
endfunction : build_phase

function void amba_apb5_requester_subscriber::write(apb5_packet #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH) t);
  `uvm_info(get_name(), $psprintf("[amba_apb5_requester_subscriber] received transaction from apb5 completer monitor to subscriber: \n%0s", t.sprint()), UVM_LOW)
endfunction : write
    
task amba_apb5_requester_subscriber::main_phase(uvm_phase phase);
  super.main_phase(phase);
endtask : main_phase
