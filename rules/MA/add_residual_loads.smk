# add_residual_loads.smk

# === Load and resolve config ===
scenario_cfg = config["scenario"]
austria_cfg = config["austria"]
residual_cfg = austria_cfg["residual_loads"]

scenario = residual_cfg["scenario"]
input_dir = residual_cfg["input_dir"]
cluster = scenario_cfg["clusters"][0]

# Fully resolve file paths
inputs = {
    k: v.format(input_dir=input_dir, scenario=scenario)
    for k, v in residual_cfg["inputs"].items()
}

# RULE 1: Prepare residual inputs
rule prepare_residual_inputs:
  input:
    nachfrage=inputs["nachfrage"],
    pv=inputs["pv"],
    wind=inputs["wind"],
    biomasse=inputs["biomasse"],
    gross_wasserkraft=inputs["gross_wasserkraft"],
    klein_wasserkraft=inputs["klein_wasserkraft"],
  output:
    f"residual/{scenario}/residual_inputs.parquet"
  params:
    config=residual_cfg
  notebook:
    "notebooks/prepare_residual_inputs.py.ipynb"

# RULE 2: Map to buses
rule map_residual_to_buses:
  input:
    residual=f"residual/{scenario}/residual_inputs.parquet",
    network=f"resources/networks/base_s_{cluster}_merged.nc"
  output:
    f"residual/{scenario}/mapped_residual_inputs.parquet"
  params:
    config=residual_cfg
  notebook:
    "notebooks/map_residual_to_buses.py.ipynb"

# RULE 3: Inject into PyPSA network
rule inject_residual_loads:
  input:
    mapped=f"residual/{scenario}/mapped_residual_inputs.parquet",
    network=f"resources/networks/base_s_{cluster}_merged.nc"
  output:
    f"networks/{scenario}/base_s_{cluster}_elec_residualload.nc"
  params:
    config=residual_cfg
  notebook:
    "notebooks/inject_residual_load.py.ipynb"
