
class amba_environment_config extends uvm_object;

  apb5_environment_config apb5_cfg;
  
  `uvm_object_utils_begin(amba_environment_config)
    `uvm_field_object(apb5_cfg, UVM_ALL_ON)
  `uvm_object_utils_end

  extern function new(string name = "amba_environment_config");

  extern function void build_apb5_config();
endclass : amba_environment_config

function amba_environment_config::new(string name = "amba_environment_config");
  super.new(name);
endfunction : new

function void amba_environment_config::build_apb5_config();
  `uvm_info(get_name(), "Creating APB5 Environment Config", UVM_LOW)
  apb5_cfg = apb5_environment_config::type_id::create("apb5_cfg");
  apb5_cfg.is_requester    = 1;
  apb5_cfg.no_of_requester = 1;
  apb5_cfg.is_completer    = 1;
  apb5_cfg.no_of_completer = 2;

  apb5_cfg.build_apb5_requester_config();
  foreach(apb5_cfg.requester_cfg[i]) begin
    apb5_cfg.requester_cfg[i].vif_path  = $psprintf("apb5_requester%0d_vif", i);
    apb5_cfg.requester_cfg[i].is_active = UVM_ACTIVE;
    `uvm_info(get_name(), $sformatf("Configuring the apb5 requester apb5_cfg.requester_cfg[%0d] vif_path = %0s | is_active = %0s", i, apb5_cfg.requester_cfg[i].vif_path, apb5_cfg.requester_cfg[i].is_active), UVM_LOW)
  end

  apb5_cfg.build_apb5_completer_config();
  foreach(apb5_cfg.completer_cfg[i]) begin
    apb5_cfg.completer_cfg[i].vif_path  = $psprintf("apb5_completer%0d_vif", i);
    apb5_cfg.completer_cfg[i].is_active = UVM_ACTIVE;

    // 4KB boundary alignment & Dynamic calculation: base + size
    if(i == 0) begin
      apb5_cfg.completer_cfg[i].addr_size        = `AMBA_APB5_COMPLETER0_ADDR_SIZE;
      apb5_cfg.completer_cfg[i].addr_range_start = `AMBA_APB5_COMPLETER0_ADDR_START;
      apb5_cfg.completer_cfg[i].addr_range_end   = `AMBA_APB5_COMPLETER0_ADDR_END;
    end
    else if(i == 1) begin
      apb5_cfg.completer_cfg[i].addr_size        = `AMBA_APB5_COMPLETER1_ADDR_SIZE;
      apb5_cfg.completer_cfg[i].addr_range_start = `AMBA_APB5_COMPLETER1_ADDR_START;
      apb5_cfg.completer_cfg[i].addr_range_end   = `AMBA_APB5_COMPLETER1_ADDR_END;
    end
    `uvm_info(get_name(), $sformatf("Configuring the apb5 completer apb5_cfg.completer_cfg[%0d] vif_path = %0s | is_active = %0s | addr_size = 0x%0h | addr_range_start = 0x%0h | addr_range_end = 0x%0h", i, apb5_cfg.completer_cfg[i].vif_path, apb5_cfg.completer_cfg[i].is_active, apb5_cfg.completer_cfg[i].addr_size, apb5_cfg.completer_cfg[i].addr_range_start, apb5_cfg.completer_cfg[i].addr_range_end), UVM_LOW)
  end
endfunction : build_apb5_config
