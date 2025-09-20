
class amba_virtual_sequencer extends uvm_sequencer;
  `uvm_component_param_utils(amba_virtual_sequencer)

  amba_environment_config cfg;

  apb5_requester_sequencer #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH) apb5_req_seqr[];
  apb5_completer_sequencer #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH) apb5_comp_seqr[];

  uvm_component parent_comp;

  extern function new(string name = "amba_virtual_sequencer", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
endclass : amba_virtual_sequencer

function amba_virtual_sequencer::new(string name = "amba_virtual_sequencer", uvm_component parent);
  super.new(name, parent);
endfunction : new

function void amba_virtual_sequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);

  parent_comp = get_parent();

  if(cfg == null) `uvm_fatal(get_name(), $psprintf("amba_environment_config cfg is null, pass it from parent component %0p", parent_comp.get_name()))
  
  if(cfg.apb5_cfg.is_requester) apb5_req_seqr  = new[cfg.apb5_cfg.no_of_requester];
  if(cfg.apb5_cfg.is_completer) apb5_comp_seqr = new[cfg.apb5_cfg.no_of_completer];
endfunction : build_phase
