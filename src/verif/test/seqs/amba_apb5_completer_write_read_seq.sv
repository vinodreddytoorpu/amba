class amba_apb5_completer_write_read_seq extends amba_base_virtual_seq;
  `uvm_object_utils(amba_apb5_completer_write_read_seq)

  apb5_completer_base_seq #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH) apb5_seq;

  extern function new(string name = "amba_apb5_completer_write_read_seq");
  extern task body();
endclass : amba_apb5_completer_write_read_seq

function amba_apb5_completer_write_read_seq::new(string name = "amba_apb5_completer_write_read_seq");
  super.new(name);
endfunction : new

task amba_apb5_completer_write_read_seq::body();
  apb5_seq = apb5_completer_base_seq #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH)::type_id::create("apb5_seq");
  if(!apb5_seq.randomize() with { 
    write == 0; 
  }) `uvm_fatal("SEQ", "Randomization failed for apb5_completer_seq")
  apb5_seq.start(env.v_seqr.apb5_comp_seqr[0]);
endtask : body
