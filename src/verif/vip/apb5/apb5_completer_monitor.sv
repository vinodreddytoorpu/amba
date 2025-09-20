
class apb5_completer_monitor #(
  parameter int ADDR_WIDTH      = 32,
  parameter int DATA_WIDTH      = 32,
  parameter int USER_REQ_WIDTH  = 128, 
  parameter int USER_DATA_WIDTH = DATA_WIDTH/2
) extends uvm_monitor;

  `uvm_component_param_utils(apb5_completer_monitor #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH))

  virtual apb5_interface #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH) vif;

  apb5_packet #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH) pkt;

  uvm_analysis_port #(apb5_packet #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH)) ap;

  apb5_completer_config cfg;

  uvm_component parent_comp;

  extern function new(string name = "apb5_completer_monitor", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task main_phase(uvm_phase phase);
endclass : apb5_completer_monitor

function apb5_completer_monitor::new(string name = "apb5_completer_monitor", uvm_component parent);
  super.new(name, parent);
  ap = new("ap", this);
endfunction : new

function void apb5_completer_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  parent_comp = get_parent();
  if(cfg == null) `uvm_fatal(get_name(), $psprintf("apb5_completer_config cfg is null, pass it from parent component %0p", parent_comp.get_name()))
endfunction : build_phase

function void apb5_completer_monitor::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if(!uvm_config_db #(virtual apb5_interface #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH))::get(this, "*", cfg.vif_path, vif)) `uvm_fatal(get_name(), $psprintf("virtual apb5_interface #(%0d, %0d, %0d, %0d) vif is null, check whether %0s set to config_db::set()", ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH, cfg.vif_path))
endfunction : connect_phase

task apb5_completer_monitor::main_phase(uvm_phase phase);
  super.main_phase(phase);

  forever begin
    @(vif.cb_monitor);
    if(vif.cb_monitor.pselx && vif.cb_monitor.penable && vif.cb_monitor.pready) begin
      pkt = apb5_packet #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH)::type_id::create("pkt");

      pkt.addr   = vif.cb_monitor.paddr;
      pkt.prot   = vif.cb_monitor.pprot;
      pkt.write  = vif.cb_monitor.pwrite;
      pkt.strb   = vif.cb_monitor.pstrb;
      pkt.wdata  = vif.cb_monitor.pwdata;
      pkt.wakeup = vif.cb_monitor.pwakeup;
      pkt.auser  = vif.cb_monitor.pauser;
      pkt.wuser  = vif.cb_monitor.pwuser;
      pkt.rdata  = vif.cb_monitor.prdata;
      pkt.slverr = vif.cb_monitor.pslverr;
      pkt.ruser  = vif.cb_monitor.pruser;
      pkt.buser  = vif.cb_monitor.pbuser;

      ap.write(pkt);
    end
  end
endtask : main_phase
