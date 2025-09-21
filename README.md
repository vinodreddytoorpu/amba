# AMBA UVM Verification Environment

This repository contains a UVM-based SystemVerilog verification environment for AMBA.

## UVM testbench topology

```
# UVM_INFO @ 0: reporter [UVMTOP] UVM testbench topology:
# ----------------------------------------------------------------
# Name                         Type                    Size  Value
# ----------------------------------------------------------------
# uvm_test_top                 amba_base_test          -     @475 
#   env                        amba_environment        -     @483 
#     apb5_env                 uvm_env                 -     @494 
#       completer_agt0         uvm_agent               -     @617 
#         drv                  uvm_driver #(REQ,RSP)   -     @632 
#           rsp_port           uvm_analysis_port       -     @647 
#           seq_item_port      uvm_seq_item_pull_port  -     @639 
#         mon                  uvm_monitor             -     @764 
#           ap                 uvm_analysis_port       -     @771 
#         seqr                 uvm_sequencer           -     @655 
#           rsp_export         uvm_analysis_export     -     @662 
#           seq_item_export    uvm_seq_item_pull_imp   -     @756 
#           arbitration_queue  array                   0     -    
#           lock_queue         array                   0     -    
#           num_last_reqs      integral                32    'd1  
#           num_last_rsps      integral                32    'd1  
#       completer_agt1         uvm_agent               -     @624 
#         drv                  uvm_driver #(REQ,RSP)   -     @785 
#           rsp_port           uvm_analysis_port       -     @800 
#           seq_item_port      uvm_seq_item_pull_port  -     @792 
#         mon                  uvm_monitor             -     @917 
#           ap                 uvm_analysis_port       -     @924 
#         seqr                 uvm_sequencer           -     @808 
#           rsp_export         uvm_analysis_export     -     @815 
#           seq_item_export    uvm_seq_item_pull_imp   -     @909 
#           arbitration_queue  array                   0     -    
#           lock_queue         array                   0     -    
#           num_last_reqs      integral                32    'd1  
#           num_last_rsps      integral                32    'd1  
#       requester_agt0         uvm_agent               -     @610 
#         drv                  uvm_driver #(REQ,RSP)   -     @938 
#           rsp_port           uvm_analysis_port       -     @953 
#           seq_item_port      uvm_seq_item_pull_port  -     @945 
#         mon                  uvm_monitor             -     @1070
#         seqr                 uvm_sequencer           -     @961 
#           rsp_export         uvm_analysis_export     -     @968 
#           seq_item_export    uvm_seq_item_pull_imp   -     @1062
#           arbitration_queue  array                   0     -    
#           lock_queue         array                   0     -    
#           num_last_reqs      integral                32    'd1  
#           num_last_rsps      integral                32    'd1  
#     v_seqr                   uvm_sequencer           -     @501 
#       rsp_export             uvm_analysis_export     -     @508 
#       seq_item_export        uvm_seq_item_pull_imp   -     @602 
#       arbitration_queue      array                   0     -    
#       lock_queue             array                   0     -    
#       num_last_reqs          integral                32    'd1  
#       num_last_rsps          integral                32    'd1  
# ----------------------------------------------------------------
```

## Directory Structure

```bash
|src/
|--verif/
  |--env/ – Common environment files (config, defines, packages)
  |--tb/ – Testbench top-level and related files
  |--test/ – Test classes and sequences
  |--vip/ – APB5 VIP (agents, drivers, monitors, configs, etc.)
|run.ps1 – PowerShell script to compile and run simulations
|compile.log, simulate.log – Logs from compilation and simulation
```

## How to Build and Run

1. **Compile the Design and Testbench**

   Run the provided PowerShell script:

   ```bash
   ./run.ps1
   ```

   This script compiles all relevant SystemVerilog files and runs the simulation using Questa/ModelSim.

2. **View Simulation Results**

   - Check `simulate.log` for simulation output.
   - View waveforms in `dump.vcd` using your preferred viewer (e.g., GTKWave).

