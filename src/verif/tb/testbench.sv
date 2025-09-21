`include "uvm_macros.svh"

`include "../test/amba_test_package.sv"

module top;
  import uvm_pkg::*;
  import apb5_environment_package::*;
  import amba_environment_package::*;
  import amba_seq_package::*;
  import amba_test_package::*;
  
  logic clock;
  logic resetn;

  logic [     `AMBA_APB5_ADDR_WIDTH-1:0] paddr;
  logic [                           2:0] pprot;
  logic [                           0:0] pselx;
  logic [                           0:0] penable;
  logic [                           0:0] pwrite;
  logic [     `AMBA_APB5_DATA_WIDTH-1:0] pwdata;
  logic [ (`AMBA_APB5_DATA_WIDTH/8)-1:0] pstrb;

  // source : completer
  logic [                           0:0] pready;
  logic [     `AMBA_APB5_DATA_WIDTH-1:0] prdata;
  logic [                           0:0] pslverr;

  // source : requester
  logic [                           0:0] pwakeup;
  logic [ `AMBA_APB5_USER_REQ_WIDTH-1:0] pauser;

  logic [`AMBA_APB5_USER_DATA_WIDTH-1:0] pwuser;

  // source : completer
  logic [`AMBA_APB5_USER_DATA_WIDTH-1:0] pruser;
  logic [`AMBA_APB5_USER_DATA_WIDTH-1:0] pbuser;

  logic completer0_select, completer1_select;
  
  // Function for address range checking
  function logic addr_in_range(logic [31:0] addr, logic [31:0] range_start, logic [31:0] range_end);
    return (addr >= range_start && addr <= range_end);
  endfunction : addr_in_range

  apb5_interface #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH) apb5_requester0_if(clock, resetn);
  apb5_interface #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH) apb5_completer0_if(clock, resetn);
  apb5_interface #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH) apb5_completer1_if(clock, resetn);
  
  // Address decoding logic to select the completer
  assign completer0_select = addr_in_range(apb5_requester0_if.paddr, `AMBA_APB5_COMPLETER1_ADDR_START, `AMBA_APB5_COMPLETER1_ADDR_END);
  assign completer1_select = addr_in_range(apb5_requester0_if.paddr, `AMBA_APB5_COMPLETER1_ADDR_START, `AMBA_APB5_COMPLETER1_ADDR_END);

  // From APB5 requester outputs to top signals
  assign paddr   = apb5_requester0_if.paddr;
  assign pprot   = apb5_requester0_if.pprot;
  assign pselx   = apb5_requester0_if.pselx;
  assign penable = apb5_requester0_if.penable;
  assign pwrite  = apb5_requester0_if.pwrite;
  assign pwdata  = apb5_requester0_if.pwdata;
  assign pstrb   = apb5_requester0_if.pstrb;
  assign pwakeup = apb5_requester0_if.pwakeup;
  assign pauser  = apb5_requester0_if.pauser;
  assign pwuser  = apb5_requester0_if.pwuser;

  // From APB5 requester inputs to top signals
  assign apb5_requester0_if.pready  = pready;
  assign apb5_requester0_if.prdata  = prdata;
  assign apb5_requester0_if.pslverr = pslverr;
  assign apb5_requester0_if.pruser  = pruser;
  assign apb5_requester0_if.pbuser  = pbuser;

  // From top signals to APB5 completer0 inputs
  assign apb5_completer0_if.paddr   = paddr;
  assign apb5_completer0_if.pprot   = pprot;
  assign apb5_completer0_if.pselx   = pselx & completer0_select;
  assign apb5_completer0_if.penable = penable & completer0_select;
  assign apb5_completer0_if.pwrite  = pwrite;
  assign apb5_completer0_if.pwdata  = pwdata;
  assign apb5_completer0_if.pstrb   = pstrb;
  assign apb5_completer0_if.pwakeup = pwakeup;
  assign apb5_completer0_if.pauser  = pauser;
  assign apb5_completer0_if.pwuser  = pwuser;

  // From top signals to APB5 completer1 inputs
  assign apb5_completer1_if.paddr   = paddr;
  assign apb5_completer1_if.pprot   = pprot;
  assign apb5_completer1_if.pselx   = pselx & completer1_select;
  assign apb5_completer1_if.penable = penable & completer1_select;
  assign apb5_completer1_if.pwrite  = pwrite;
  assign apb5_completer1_if.pwdata  = pwdata;
  assign apb5_completer1_if.pstrb   = pstrb;
  assign apb5_completer1_if.pwakeup = pwakeup;
  assign apb5_completer1_if.pauser  = pauser;
  assign apb5_completer1_if.pwuser  = pwuser;   

  // From APB5 completer outputs to top signals (combined)
  assign pready  = completer0_select ? apb5_completer0_if.pready  :
                   completer1_select ? apb5_completer1_if.pready  : 1'b1;

  assign prdata  = completer0_select ? apb5_completer0_if.prdata  :
                   completer1_select ? apb5_completer1_if.prdata  : '0;

  assign pslverr = completer0_select ? apb5_completer0_if.pslverr :
                   completer1_select ? apb5_completer1_if.pslverr : '0;

  assign pruser  = completer0_select ? apb5_completer0_if.pruser  :
                   completer1_select ? apb5_completer1_if.pruser  : '0;

  assign pbuser  = completer0_select ? apb5_completer0_if.pbuser  :
                   completer1_select ? apb5_completer1_if.pbuser  : '0;

  initial begin
    clock = 0;
    resetn = 0;

    repeat(2) @(posedge clock); 

    resetn = 1;
  end
  
  always #5 clock = !clock;
  
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    
    uvm_config_db #(virtual apb5_interface #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH))::set (null, "*", "apb5_requester0_vif", apb5_requester0_if);
    uvm_config_db #(virtual apb5_interface #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH))::set (null, "*", "apb5_completer0_vif", apb5_completer0_if);
    uvm_config_db #(virtual apb5_interface #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH))::set (null, "*", "apb5_completer1_vif", apb5_completer1_if);
    
    uvm_top.finish_on_completion = 1;
    
    run_test("amba_apb5_completer_write_read_test");
  end
endmodule : top
