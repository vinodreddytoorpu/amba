
class apb5_completer_base_seq #(
  parameter int ADDR_WIDTH      = 32,
  parameter int DATA_WIDTH      = 32,
  parameter int USER_REQ_WIDTH  = 128, 
  parameter int USER_DATA_WIDTH = DATA_WIDTH/2
) extends uvm_sequence #(apb5_packet #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH));
  `uvm_object_param_utils(apb5_completer_base_seq #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH))
  `uvm_declare_p_sequencer(apb5_completer_sequencer #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH))

  // source : requester
  rand bit write;
  rand bit [ (DATA_WIDTH/8)-1:0] strb;
  rand bit [                2:0] prot;

  // source : requester
  rand bit [                0:0] wakeup;
  rand bit [ USER_REQ_WIDTH-1:0] auser;
  rand bit [USER_DATA_WIDTH-1:0] wuser;

  // source : requester
  rand bit [     ADDR_WIDTH-1:0] addr;
  rand bit [     DATA_WIDTH-1:0] wdata;

  rand bit [0:0] b2b_transfer; // back to back transfer

  apb5_packet #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH) pkt;
  extern function new(string name = "apb5_completer_base_seq");
  extern task body();
endclass : apb5_completer_base_seq

function apb5_completer_base_seq::new(string name = "apb5_completer_base_seq");
  super.new(name);
endfunction : new

task apb5_completer_base_seq::body();
  pkt = apb5_packet #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH)::type_id::create("pkt");
  start_item(pkt);
  if(!pkt.randomize() with {
    write        == write;
    strb         == strb;
    prot         == prot;
    wakeup       == wakeup;
    auser        == auser;
    wuser        == wuser;
    addr         == addr;
    wdata        == wdata;
    b2b_transfer == b2b_transfer;
  }) `uvm_fatal(get_name(), "Randomization Failed for APB5 completer base sequence")
  `uvm_info(get_name(), $sformatf("APB5 completer base sequence item : \n%s", pkt.sprint()), UVM_LOW)
  finish_item(pkt);
endtask : body
