
class apb5_completer_agent #(
  parameter int ADDR_WIDTH      = 32,
  parameter int DATA_WIDTH      = 32,
  parameter int USER_REQ_WIDTH  = 128, 
  parameter int USER_DATA_WIDTH = DATA_WIDTH/2
) extends uvm_agent;

  `uvm_component_param_utils(apb5_completer_agent #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH))

  virtual apb5_interface #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH) vif;

  apb5_completer_config cfg;

  apb5_completer_monitor   #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH) mon;
  apb5_completer_driver    #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH) drv; 
  apb5_completer_sequencer #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH) seqr;

  uvm_component parent_comp;

  extern function new(string name = "apb5_completer_agent", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task main_phase(uvm_phase phase);
endclass : apb5_completer_agent

function apb5_completer_agent::new(string name = "apb5_completer_agent", uvm_component parent);
  super.new(name, parent);
endfunction : new

function void apb5_completer_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  parent_comp = get_parent();
  if(cfg == null) `uvm_fatal(get_name(), $psprintf("apb5_completer_config is null, pass it from parent component %0p", parent_comp.get_name()))

  `uvm_info(get_name(), $psprintf("Agent is %0s", cfg.is_active), UVM_LOW)
  if(cfg.is_active) begin
    drv = apb5_completer_driver #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH)::type_id::create("drv", this); 
    drv.cfg = cfg;
    `uvm_info(get_name(), "Creating the Driver", UVM_LOW)
    seqr = apb5_completer_sequencer #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH)::type_id::create("seqr", this);
    `uvm_info(get_name(), "Creating the Sequencer", UVM_LOW)
  end

  mon = apb5_completer_monitor #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH)::type_id::create("mon", this); 
  mon.cfg = cfg;
  `uvm_info(get_name(), "Creating the Monitor", UVM_LOW)
endfunction : build_phase

function void apb5_completer_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  if(cfg.is_active) begin
    drv.seq_item_port.connect(seqr.seq_item_export);
    `uvm_info(get_name(), "Creating the TLM connection between Driver and Sequencer", UVM_LOW)
  end
endfunction : connect_phase

task apb5_completer_agent::main_phase(uvm_phase phase);
  super.main_phase(phase);
endtask : main_phase
