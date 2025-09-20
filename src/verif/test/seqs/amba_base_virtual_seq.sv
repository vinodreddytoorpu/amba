
class amba_base_virtual_seq extends uvm_sequence;
  `uvm_object_utils(amba_base_virtual_seq)
  `uvm_declare_p_sequencer(amba_virtual_sequencer)

  apb5_requester_sequencer #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH) apb5_req_seqr[];
  apb5_completer_sequencer #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH) apb5_comp_seqr[];

  uvm_component parent_comp;

  amba_environment_config cfg;

  amba_environment env;

  extern function new(string name = "amba_base_virtual_seq");
  extern task body();
endclass : amba_base_virtual_seq

function amba_base_virtual_seq::new(string name = "amba_base_virtual_seq");
  super.new(name);
endfunction : new

task amba_base_virtual_seq::body();
  if(cfg == null) `uvm_fatal(get_name(), $psprintf("amba_environment_config cfg is null, pass it from parent component %0p", parent_comp.get_name()))
  if(env == null) `uvm_fatal(get_name(), $psprintf("amba_environment env is null, pass it from parent component %0p", parent_comp.get_name()))

  if(cfg.apb5_cfg.is_requester) begin
    apb5_req_seqr = new[cfg.apb5_cfg.no_of_requester];
    foreach(apb5_req_seqr[i]) apb5_req_seqr[i] = p_sequencer.apb5_req_seqr[i];
  end
  if(cfg.apb5_cfg.is_completer) begin
    apb5_comp_seqr = new[cfg.apb5_cfg.no_of_completer];
    foreach(apb5_comp_seqr[i]) apb5_comp_seqr[i] = p_sequencer.apb5_comp_seqr[i];
  end
endtask : body
