
class apb5_requester_driver #(
  parameter int ADDR_WIDTH      = 32,
  parameter int DATA_WIDTH      = 32,
  parameter int USER_REQ_WIDTH  = 128, 
  parameter int USER_DATA_WIDTH = DATA_WIDTH/2
) extends uvm_driver #(apb5_packet #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH));

  `uvm_component_param_utils(apb5_requester_driver #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH))

  virtual apb5_interface #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH) vif;

  apb5_requester_config cfg;

  uvm_component parent_comp;

  extern function new(string name = "apb5_requester_driver", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task main_phase(uvm_phase phase);
endclass : apb5_requester_driver

function apb5_requester_driver::new(string name = "apb5_requester_driver", uvm_component parent);
  super.new(name, parent);
endfunction : new

function void apb5_requester_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(cfg == null) `uvm_fatal(get_name(), $psprintf("apb5_requester_config cfg is null, pass it from parent component %0p", parent_comp.get_name()))
endfunction : build_phase

function void apb5_requester_driver::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if(!uvm_config_db #(virtual apb5_interface #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH))::get(this, "*", cfg.vif_path, vif)) `uvm_fatal(get_name(), $psprintf("virtual apb5_interface #(%0d, %0d, %0d, %0d) vif is null, check whether %0s set to config_db::set()", ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH, cfg.vif_path))
endfunction : connect_phase

task apb5_requester_driver::main_phase(uvm_phase phase);
  super.main_phase(phase);
  fork
    begin
      forever begin
        if(vif.presetn == 1'b0) begin
          vif.pready  <= 1'b1; // default ready
          vif.prdata  <= '0;
          vif.pslverr <= 1'b0;
          vif.pruser  <= '0;
          vif.pbuser  <= '0;
        end
        @(vif.cb_requester); 
      end
    end  
    // begin
    //   forever begin
    //     apb5_pkt = apb5_packet #(ADDR_WIDTH, DATA_WIDTH, USER_REQ_WIDTH, USER_DATA_WIDTH)::type_id::create("apb5_pkt");
    //     seq_item_port.get_next_item(apb5_pkt);

    //     while(1) begin
    //       if(vif.presetn == 1'b0) @(vif.cb_requester); 
    //       else break;
    //     end
    //     if(vif.pclk == 1'b0) @(posedge vif.pclk); // wait for posedge if clk is low
        
    //     // Drive address and control signals at next posedge
    //     vif.paddr   <= apb5_pkt.addr;
    //     vif.pprot   <= apb5_pkt.prot;
    //     vif.pselx   <= 1'b1;
    //     vif.penable <= 1'b0;
    //     vif.pwrite  <= apb5_pkt.write;
    //     vif.pwdata  <= apb5_pkt.wdata;
    //     vif.pstrb   <= apb5_pkt.strb;
    //     vif.pwakeup <= apb5_pkt.wakeup;
    //     vif.pauser  <= apb5_pkt.auser;
    //     vif.pwuser  <= apb5_pkt.wuser;
    //     `uvm_info(get_name(), $sformatf("APB5 Completer Driver APB_SETUP_PHASE | paddr = %0h, pprot = %0h, pselx = %0h, penable = %0h, pwrite = %0h, pwdata = %0h, pstrb = %0h, pwakeup = %0h, pauser = %0h, pwuser = %0h", apb5_pkt.addr, apb5_pkt.prot, 1'b1, 1'b0, apb5_pkt.write, apb5_pkt.wdata, apb5_pkt.strb, apb5_pkt.wakeup, apb5_pkt.auser, apb5_pkt.wuser), UVM_LOW)

    //     // Move to ACCESS phase
    //     @(vif.cb_requester);
    //     vif.penable <= 1'b1;
    //     `uvm_info(get_name(), $sformatf("APB5 Completer Driver APB_ACCESS_PHASE | penable = %0h, pready = %0h", 1'b1, vif.cb_requester.pready), UVM_LOW)

    //     // Wait for slave to assert PREADY
    //     do begin
    //       `uvm_info(get_name(), $sformatf("APB5 Completer Driver APB_ACCESS_PHASE waiting for | pready = %0h", vif.cb_requester.pready), UVM_LOW)
    //       @(vif.cb_requester);
    //     end while (!vif.cb_requester.pready);

    //     // Sample response
    //     if(vif.pwrite) begin // read transaction
    //       apb5_pkt.rdata = vif.prdata;
    //       apb5_pkt.ruser = vif.pruser;
    //       apb5_pkt.buser = vif.pbuser;
    //     end
    //     apb5_pkt.slverr = vif.pslverr;
    //     `uvm_info(get_name(), $sformatf("APB5 Completer Driver | pslverr = %0h, prdata = %0h, pruser = %0h, pbuser = %0h", vif.cb_requester.pslverr, vif.cb_requester.prdata, vif.cb_requester.pruser, vif.cb_requester.pbuser), UVM_LOW)

    //     // Deassert select and enable
    //     @(vif.cb_requester);
    //     vif.pselx   <= 1'b0;
    //     vif.penable <= 1'b0;

    //     seq_item_port.item_done();
    //   end
    // end  
  join_none
endtask : main_phase
