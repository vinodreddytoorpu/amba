
package amba_seq_package;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import apb5_environment_package::*;
  import amba_environment_package::*;

  `include "./seqs/amba_base_virtual_seq.sv"
  `include "./seqs/amba_apb5_completer_write_read_seq.sv"
  `include "./seqs/amba_apb5_requester_write_read_seq.sv"
endpackage : amba_seq_package
