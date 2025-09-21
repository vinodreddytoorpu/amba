
typedef class amba_environment;

class amba_apb5_requester_subscriber extends uvm_subscriber #(apb5_packet #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH));
  `uvm_component_utils(amba_apb5_requester_subscriber)

  uvm_component parent_comp;

  amba_environment env;

  bit [`AMBA_APB5_DATA_WIDTH-1:0] data_mem [bit [`AMBA_APB5_ADDR_WIDTH-1:0]];

  extern function new(string name = "amba_apb5_requester_subscriber", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void write(apb5_packet #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH) t);
  extern task main_phase(uvm_phase phase);
endclass : amba_apb5_requester_subscriber

function amba_apb5_requester_subscriber::new(string name = "amba_apb5_requester_subscriber", uvm_component parent);
  super.new(name, parent);
endfunction : new

function void amba_apb5_requester_subscriber::build_phase(uvm_phase phase);
  super.build_phase(phase);

  parent_comp = get_parent();

  if(env == null) `uvm_fatal(get_name(), $psprintf("amba_environment env is null, pass it from parent component %0p", parent_comp.get_name()))
endfunction : build_phase

function void amba_apb5_requester_subscriber::write(apb5_packet #(`AMBA_APB5_ADDR_WIDTH, `AMBA_APB5_DATA_WIDTH, `AMBA_APB5_USER_REQ_WIDTH, `AMBA_APB5_USER_DATA_WIDTH) t);
  `uvm_info(get_name(), $psprintf("[amba_apb5_requester_subscriber] received transaction from apb5 requester monitor to subscriber: \n%0s", t.sprint()), UVM_HIGH)
  if(t.write == 1'b0) begin
    data_mem[t.addr] = t.wdata;
    `uvm_info(get_name(), $psprintf("Write Transaction : storing into data_mem[%0h] = %0h", t.addr, t.wdata), UVM_LOW)
  end
endfunction : write
    
task amba_apb5_requester_subscriber::main_phase(uvm_phase phase);
  super.main_phase(phase);
endtask : main_phase
