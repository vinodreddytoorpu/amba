
class apb5_packet #(
  parameter int ADDR_WIDTH      = 32,
  parameter int DATA_WIDTH      = 32,
  parameter int USER_REQ_WIDTH  = 128, 
  parameter int USER_DATA_WIDTH = DATA_WIDTH/2
) extends uvm_sequence_item;

  // source : requester
  rand bit write;
  rand bit [ (DATA_WIDTH/8)-1:0] strb;
  rand bit [                2:0] prot;

  // source : requester
  rand bit [                0:0] wakeup;
  rand bit [ USER_REQ_WIDTH-1:0] auser;
  rand bit [USER_DATA_WIDTH-1:0] wuser;

  // source : completer
  rand bit [                0:0] slverr;
  rand bit [USER_DATA_WIDTH-1:0] ruser;
  rand bit [USER_DATA_WIDTH-1:0] buser;

  // source : requester, completer
  rand bit [     ADDR_WIDTH-1:0] addr;
  rand bit [     DATA_WIDTH-1:0] wdata;
  rand bit [     DATA_WIDTH-1:0] rdata;

  rand bit [0:0] b2b_transfer; // back to back transfer

  `uvm_object_param_utils_begin(apb5_packet #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH))
    `uvm_field_int(write       , UVM_ALL_ON)
    `uvm_field_int(strb        , UVM_ALL_ON)
    `uvm_field_int(prot        , UVM_ALL_ON)
    `uvm_field_int(wakeup      , UVM_ALL_ON)
    `uvm_field_int(auser       , UVM_ALL_ON)
    `uvm_field_int(wuser       , UVM_ALL_ON)
    `uvm_field_int(slverr      , UVM_ALL_ON)
    `uvm_field_int(ruser       , UVM_ALL_ON)
    `uvm_field_int(buser       , UVM_ALL_ON)
    `uvm_field_int(addr        , UVM_ALL_ON)
    `uvm_field_int(wdata       , UVM_ALL_ON)
    `uvm_field_int(rdata       , UVM_ALL_ON)
    `uvm_field_int(b2b_transfer, UVM_ALL_ON)
  `uvm_object_utils_end

  extern function new(string name = "apb5_packet");
endclass : apb5_packet

function apb5_packet::new(string name = "apb5_packet");
  super.new(name);
endfunction : new
