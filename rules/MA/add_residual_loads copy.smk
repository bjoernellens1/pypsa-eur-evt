rule add_residual_loads:
    input:
        loads_dir = "data/MA/loads",
        network="resources/networks/base_s_{clusters}_merged.nc",
    output:
        network="resources/networks/base_s_{clusters}_loaded.nc"
    conda:
        "envs/pypsa-eur.yaml"
    notebook:
        "notebooks/add_residual_loads.py.ipynb"