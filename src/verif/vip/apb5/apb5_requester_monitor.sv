
class apb5_requester_monitor #(
  parameter int ADDR_WIDTH      = 32,
  parameter int DATA_WIDTH      = 32,
  parameter int USER_REQ_WIDTH  = 128, 
  parameter int USER_DATA_WIDTH = DATA_WIDTH/2
) extends uvm_monitor;

  `uvm_component_param_utils(apb5_requester_monitor #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH))

  virtual apb5_interface #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH) vif;

  apb5_requester_config cfg;

  uvm_component parent_comp;

  apb5_packet #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH) pkt;

  uvm_analysis_port #(apb5_packet #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH)) ap;

  extern function new(string name = "apb5_requester_monitor", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task main_phase(uvm_phase phase);
endclass : apb5_requester_monitor

function apb5_requester_monitor::new(string name = "apb5_requester_monitor", uvm_component parent);
  super.new(name, parent);
  ap = new("ap", this);
endfunction : new

function void apb5_requester_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  parent_comp = get_parent();
  if(cfg == null) `uvm_fatal(get_name(), $psprintf("apb5_requester_config cfg is null, pass it from parent component %0p", parent_comp.get_name()))
endfunction : build_phase

function void apb5_requester_monitor::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if(!uvm_config_db #(virtual apb5_interface #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH))::get(this, "*", cfg.vif_path, vif)) `uvm_fatal(get_name(), $psprintf("virtual apb5_interface #(%0d, %0d, %0d, %0d) vif is null, check whether %0s set to config_db::set()", ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH, cfg.vif_path))
endfunction : connect_phase

task apb5_requester_monitor::main_phase(uvm_phase phase);
  super.main_phase(phase);

  forever begin
    @(posedge vif.pclk);
    if(vif.presetn) begin
      if(vif.pselx && vif.penable && vif.pready) begin
        pkt = apb5_packet #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH)::type_id::create("pkt");
        
        pkt.write    = vif.pwrite;
        pkt.addr     = vif.paddr;
        pkt.prot     = vif.pprot;
        pkt.strb     = vif.pstrb;
        pkt.wakeup   = vif.pwakeup;
        pkt.auser    = vif.pauser;
        pkt.wuser    = vif.pwuser;
        pkt.slverr   = vif.pslverr;
        pkt.ruser    = vif.pruser;
        pkt.buser    = vif.pbuser;
        
        if(!vif.pwrite) pkt.wdata = vif.pwdata; // write_transaction
        else if(vif.pwrite) pkt.rdata = vif.prdata; // read_transaction
        `uvm_info(get_name(), $sformatf("Monitor observed a transaction: \n%0s", pkt.sprint()), UVM_LOW)
        ap.write(pkt);
      end
    end
  end
endtask : main_phase
