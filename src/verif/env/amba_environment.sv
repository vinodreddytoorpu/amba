
class amba_environment extends uvm_env;
  `uvm_component_utils(amba_environment)

  uvm_component parent_comp;

  amba_environment_config cfg;

  apb5_environment #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH) apb5_env;

  amba_virtual_sequencer v_seqr;

  extern function new(string name = "amba_environment", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task main_phase(uvm_phase phase);
endclass : amba_environment

function amba_environment::new(string name = "amba_environment", uvm_component parent);
  super.new(name, parent);
endfunction : new

function void amba_environment::build_phase(uvm_phase phase);
  super.build_phase(phase);

  parent_comp = get_parent();

  if(cfg == null) `uvm_fatal(get_name(), $psprintf("amba_environment_config cfg is null, pass it from parent component %0p", parent_comp.get_name()))
  
  cfg.build_apb5_config();
  
  apb5_env = apb5_environment #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH)::type_id::create("apb5_env", this);
  apb5_env.cfg = cfg.apb5_cfg;
  `uvm_info(get_name(), "Creating the APB5 Environment", UVM_LOW)

  v_seqr = amba_virtual_sequencer::type_id::create("v_seqr", this);
  v_seqr.cfg = cfg;
  `uvm_info(get_name(), "Creating the AMBA Virtual Sequencer", UVM_LOW)
endfunction : build_phase

function void amba_environment::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  
  if(cfg.apb5_cfg.is_requester) begin
    foreach(v_seqr.apb5_req_seqr[i]) v_seqr.apb5_req_seqr[i] = apb5_env.requester_agt[i].seqr;
  end
  if(cfg.apb5_cfg.is_completer) begin
    foreach(v_seqr.apb5_comp_seqr[i]) v_seqr.apb5_comp_seqr[i] = apb5_env.completer_agt[i].seqr;
  end
endfunction : connect_phase
    
task amba_environment::main_phase(uvm_phase phase);
  super.main_phase(phase);
endtask : main_phase
