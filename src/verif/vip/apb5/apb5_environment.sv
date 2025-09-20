
class apb5_environment #(
  parameter int ADDR_WIDTH      = 32,
  parameter int DATA_WIDTH      = 32,
  parameter int USER_REQ_WIDTH  = 128, 
  parameter int USER_DATA_WIDTH = DATA_WIDTH/2
) extends uvm_env;

  `uvm_component_param_utils(apb5_environment #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH))

  uvm_component parent_comp;

  apb5_environment_config cfg;

  apb5_requester_agent #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH) requester_agt[];
  apb5_completer_agent #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH) completer_agt[];

  extern function new(string name = "apb5_environment", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task main_phase(uvm_phase phase);
endclass : apb5_environment

function apb5_environment::new(string name = "apb5_environment", uvm_component parent);
  super.new(name, parent);
endfunction : new

function void apb5_environment::build_phase(uvm_phase phase);
  super.build_phase(phase);

  parent_comp = get_parent();

  if(cfg == null) `uvm_fatal(get_name(), $psprintf("apb5_environment_config is null, pass it from parent component %0p", parent_comp.get_name()))

  `uvm_info(get_name(), $psprintf("APB5 is_requester = %0d no_of_requester = %0d", cfg.is_requester, cfg.no_of_requester), UVM_LOW)
  if(cfg.is_requester) begin
    requester_agt = new[cfg.no_of_requester];
    foreach(requester_agt[i]) begin
      requester_agt[i] = apb5_requester_agent #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH)::type_id::create($psprintf("requester_agt%0d", i), this);
      requester_agt[i].cfg = cfg.requester_cfg[i];
      `uvm_info(get_name(), $psprintf("APB5 Creating requester_agt%0d", i), UVM_LOW)
    end
  end

  `uvm_info(get_name(), $psprintf("APB5 is_completer = %0d no_of_completer = %0d", cfg.is_completer, cfg.no_of_completer), UVM_LOW)
  if(cfg.is_completer) begin
    completer_agt = new[cfg.no_of_completer];
    foreach(completer_agt[i]) begin
      completer_agt[i] = apb5_completer_agent #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH)::type_id::create($psprintf("completer_agt%0d", i), this);
      completer_agt[i].cfg = cfg.completer_cfg[i];
      `uvm_info(get_name(), $psprintf("APB5 Creating completer_agt%0d", i), UVM_LOW)
    end
  end
endfunction : build_phase

function void apb5_environment::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

task apb5_environment::main_phase(uvm_phase phase);
  super.main_phase(phase);
endtask : main_phase
