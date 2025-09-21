

`include "../vip/apb5/apb5_environment_package.sv"
`include "../env/amba_environment_package.sv"
`include "amba_seq_package.sv"

package amba_test_package;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import apb5_environment_package::*;
  import amba_environment_package::*;
  import amba_seq_package::*;

  `include "./amba_base_test/amba_base_test.sv"
  `include "./amba_apb5_completer_write_read_test/amba_apb5_completer_write_read_test.sv"
  `include "./amba_apb5_requester_write_read_test/amba_apb5_requester_write_read_test.sv"
endpackage : amba_test_package
