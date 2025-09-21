class amba_apb5_requester_write_read_seq extends amba_base_virtual_seq;
  `uvm_object_utils(amba_apb5_requester_write_read_seq)

  apb5_requester_base_seq #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH) apb5_seq;

  extern function new(string name = "amba_apb5_requester_write_read_seq");
  extern task body();
endclass : amba_apb5_requester_write_read_seq

function amba_apb5_requester_write_read_seq::new(string name = "amba_apb5_requester_write_read_seq");
  super.new(name);
endfunction : new

task amba_apb5_requester_write_read_seq::body();
  apb5_seq = apb5_requester_base_seq #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH)::type_id::create("apb5_seq");
  if(!apb5_seq.randomize() with { 
    addr inside {[`AMBA_APB5_COMPLETER0_ADDR_START : `AMBA_APB5_COMPLETER0_ADDR_END]};
    write        == 0;
    strb         == {`AMBA_APB5_DATA_WIDTH/8{1'b1}};
    wdata        == 'hDEADBEEF;
    wakeup       == 1'b0;
    b2b_transfer == 1'b0;
  }) `uvm_fatal("SEQ", "Randomization failed for apb5_requester_seq")
  apb5_seq.start(env.v_seqr.apb5_req_seqr[0]);

  #100ns;

  apb5_seq = apb5_requester_base_seq #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH)::type_id::create("apb5_seq");
  if(!apb5_seq.randomize() with { 
    addr inside {[`AMBA_APB5_COMPLETER0_ADDR_START : `AMBA_APB5_COMPLETER0_ADDR_END]};
    write        == 1;
    strb         == {`AMBA_APB5_DATA_WIDTH/8{1'b1}};
    wdata        == 'hDEADBEEF;
    wakeup       == 1'b0;
    b2b_transfer == 1'b0;
  }) `uvm_fatal("SEQ", "Randomization failed for apb5_requester_seq")
  apb5_seq.start(env.v_seqr.apb5_req_seqr[0]);

endtask : body
