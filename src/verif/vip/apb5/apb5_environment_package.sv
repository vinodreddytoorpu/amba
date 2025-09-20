
`include "apb5_interface.sv"

package apb5_environment_package;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  `include "apb5_defines.sv"
  `include "apb5_packet.sv"
  
  `include "apb5_requester_config.sv"
  `include "apb5_requester_monitor.sv"
  `include "apb5_requester_driver.sv"
  `include "apb5_requester_sequencer.sv"
  `include "apb5_requester_base_seq.sv"
  `include "apb5_requester_agent.sv"
  
  `include "apb5_completer_config.sv"
  `include "apb5_completer_monitor.sv"
  `include "apb5_completer_driver.sv"
  `include "apb5_completer_sequencer.sv"
  `include "apb5_completer_base_seq.sv"
  `include "apb5_completer_agent.sv"

  `include "apb5_environment_config.sv"
  `include "apb5_environment.sv"

endpackage : apb5_environment_package
