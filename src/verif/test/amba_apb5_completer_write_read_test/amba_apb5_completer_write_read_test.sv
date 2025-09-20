
class amba_apb5_completer_write_read_test extends amba_base_test;
  `uvm_component_utils(amba_apb5_completer_write_read_test)

  amba_apb5_completer_write_read_seq apb5_write_read_seq;

  extern function new(string name = "amba_apb5_completer_write_read_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task main_phase(uvm_phase phase);
endclass : amba_apb5_completer_write_read_test

function amba_apb5_completer_write_read_test::new(string name = "amba_apb5_completer_write_read_test", uvm_component parent);
  super.new(name, parent);
endfunction : new

function void amba_apb5_completer_write_read_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

function void amba_apb5_completer_write_read_test::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

task amba_apb5_completer_write_read_test::main_phase(uvm_phase phase);
  super.main_phase(phase);
  phase.raise_objection(this);
  apb5_write_read_seq = amba_apb5_completer_write_read_seq::type_id::create("apb5_write_read_seq");
  apb5_write_read_seq.env = env;
  apb5_write_read_seq.start(env.v_seqr);
  #100ns;
  phase.drop_objection(this);
endtask : main_phase
    