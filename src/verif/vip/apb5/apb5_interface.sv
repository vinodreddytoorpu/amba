
interface apb5_interface #(
  parameter int ADDR_WIDTH      = 32,
  parameter int DATA_WIDTH      = 32,
  parameter int USER_REQ_WIDTH  = 128,          // PAUSER is recommended to have a maximum width of 128 bit
  parameter int USER_DATA_WIDTH = DATA_WIDTH/2  // PRUSER is recommended to have a maximum width of DATA_WIDTH/2
) ( input logic pclk, input logic presetn);

  // source : requester
  logic [     ADDR_WIDTH-1:0] paddr;
  logic [                2:0] pprot;
  logic [                0:0] pselx;
  logic [                0:0] penable;
  logic [                0:0] pwrite;
  logic [     DATA_WIDTH-1:0] pwdata;
  logic [ (DATA_WIDTH/8)-1:0] pstrb;
  
  // source : completer
  logic [                0:0] pready;
  logic [     DATA_WIDTH-1:0] prdata;
  logic [                0:0] pslverr;

  // source : requester
  logic [                0:0] pwakeup;
  logic [ USER_REQ_WIDTH-1:0] pauser;
  logic [USER_DATA_WIDTH-1:0] pwuser;
  
  // source : completer
  logic [USER_DATA_WIDTH-1:0] pruser;
  logic [USER_DATA_WIDTH-1:0] pbuser;

  modport mp_requester (
    // source : requester
    output paddr  ,
    output pprot  ,
    output pselx  ,
    output penable,
    output pwrite ,
    output pwdata ,
    output pstrb  ,

    // source : completer
    input  pready ,
    input  prdata ,
    input  pslverr,

    // source : requester
    output pwakeup,
    output pauser ,
    output pwuser ,

    // source : completer
    input  pruser ,
    input  pbuser 
  );

  modport mp_completer (
    // source : requester
    input  paddr  ,
    input  pprot  ,
    input  pselx  ,
    input  penable,
    input  pwrite ,
    input  pwdata ,
    input  pstrb  ,

    // source : completer
    output pready ,
    output prdata ,
    output pslverr,

    // source : requester
    input  pwakeup,
    input  pauser ,
    input  pwuser ,

    // source : completer
    output pruser ,
    output pbuser 
  );

  modport mp_monitor (
    // source : requester
    input paddr  ,
    input pprot  ,
    input pselx  ,
    input penable,
    input pwrite ,
    input pwdata ,
    input pstrb  ,

    // source : completer
    input pready ,
    input prdata ,
    input pslverr,

    // source : requester
    input pwakeup,
    input pauser ,
    input pwuser ,

    // source : completer
    input pruser ,
    input pbuser 
  );

  clocking cb_requester @(posedge pclk);
    default input #1 output #1;
    // source : requester
    output paddr  ;
    output pprot  ;
    output pselx  ;
    output penable;
    output pwrite ;
    output pwdata ;
    output pstrb  ;

    // source : completer
    input  pready ;
    input  prdata ;
    input  pslverr;

    // source : requester
    output pwakeup;
    output pauser ;
    output pwuser ;

    // source : completer
    input  pruser ;
    input  pbuser ;
  endclocking : cb_requester

  clocking cb_completer @(posedge pclk);
    default input #1 output #1;
    // source : requester
    input  paddr  ;
    input  pprot  ;
    input  pselx  ;
    input  penable;
    input  pwrite ;
    input  pwdata ;
    input  pstrb  ;

    // source : completer
    output pready ;
    output prdata ;
    output pslverr;

    // source : requester
    input  pwakeup;
    input  pauser ;
    input  pwuser ;

    // source : completer
    output pruser ;
    output pbuser ;
  endclocking : cb_completer

  clocking cb_monitor @(posedge pclk);
    default input #1 output #1;
    // source : requester
    input paddr  ;
    input pprot  ;
    input pselx  ;
    input penable;
    input pwrite ;
    input pwdata ;
    input pstrb  ;

    // source : completer
    input pready ;
    input prdata ;
    input pslverr;

    // source : requester
    input pwakeup;
    input pauser ;
    input pwuser ;

    // source : completer
    input pruser ;
    input pbuser ;
  endclocking : cb_monitor

endinterface : apb5_interface
