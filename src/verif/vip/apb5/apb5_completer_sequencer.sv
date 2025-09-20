
class apb5_completer_sequencer #(
  parameter int ADDR_WIDTH      = 32,
  parameter int DATA_WIDTH      = 32,
  parameter int USER_REQ_WIDTH  = 128, 
  parameter int USER_DATA_WIDTH = DATA_WIDTH/2
) extends uvm_sequencer #(apb5_packet #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH));

  `uvm_component_param_utils(apb5_completer_sequencer #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH))

  extern function new(string name = "apb5_completer_sequencer", uvm_component parent);
endclass : apb5_completer_sequencer

function apb5_completer_sequencer::new(string name = "apb5_completer_sequencer", uvm_component parent);
  super.new(name, parent);
endfunction : new
