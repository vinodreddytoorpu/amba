
class amba_base_test extends uvm_test;
  `uvm_component_utils(amba_base_test)

  uvm_component parent_comp;

  amba_environment_config cfg;
  amba_environment        env;

  extern function new(string name = "amba_base_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern task main_phase(uvm_phase phase);
endclass : amba_base_test

function amba_base_test::new(string name = "amba_base_test", uvm_component parent);
  super.new(name, parent);
endfunction : new

function void amba_base_test::build_phase(uvm_phase phase);
  super.build_phase(phase);

  parent_comp = get_parent();

  cfg = amba_environment_config::type_id::create("cfg");
  `uvm_info(get_name(), "Creating the AMBA Environment Config", UVM_LOW)
  
  env = amba_environment::type_id::create("env", this);
  env.cfg = cfg;
  `uvm_info(get_name(), "Creating the AMBA Environment", UVM_LOW)
endfunction : build_phase

function void amba_base_test::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase
    
function void amba_base_test::end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology();
endfunction : end_of_elaboration_phase

task amba_base_test::main_phase(uvm_phase phase);
  super.main_phase(phase);
  phase.raise_objection(this);
  #100ns;
  phase.drop_objection(this);
endtask : main_phase
    