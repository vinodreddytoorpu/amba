# $questaPath = "C:\questasim64_2024.1\win64"
# if (-not ($env:PATH -split ";" | Where-Object { $_ -eq $questaPath })) {
#   $env:PATH = "$questaPath;$env:PATH"
#   Write-Host "Added QuestaSim path to PATH for this session."
# } 

# Ensure LM_LICENSE_FILE is set
# if (-not $env:LM_LICENSE_FILE -or !(Test-Path $env:LM_LICENSE_FILE)) {
#   $defaultLicense = "C:\flexlm\LR-253979_License.dat"
#   if (Test-Path $defaultLicense) {
#     $env:LM_LICENSE_FILE = $defaultLicense
#     Write-Host "Set LM_LICENSE_FILE to $defaultLicense for this session."
#   } else {
#     Write-Host "Warning: License file not found at $defaultLicense. Please check your license path."
#   }
# }


$files = @(
  "src/verif/tb/testbench.sv"
  # "src/verif/test/amba_test_package.sv"
  # "src/verif/vip/apb5/apb5_environment_package.sv"
  # ,"src/verif/env/amba_environment_package.sv"
  # ,"src/verif/test/amba_seq_package.sv"
  # ,"src/verif/test/amba_test_package.sv"
)

foreach ($file in $files) {
  vlog -work work $file *> compile.log
}

# Run simulation after compilation with cli
# vsim -c -do "run -all; quit" work.top *> simulate.log

# Run simulation with GUI
vsim work.top
