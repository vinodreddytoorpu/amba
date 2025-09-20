# AMBA UVM Verification Environment

This repository contains a UVM-based SystemVerilog verification environment for AMBA.

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

