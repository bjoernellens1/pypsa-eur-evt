rule merge_austrian_network:
    input:
        network1=resources("networks/base_s_{clusters}.nc"), #"resources/networks/base_s_{clusters}.nc", #"resources/networks/base_europe.nc",  # adjust this to your actual PyPSA-Eur network path
        network2=resources("networks/austria.nc")
    output:
        #network="resources/networks/base_s_{clusters}_merged.nc"
        network=resources("networks/base_s_{clusters}_merged.nc")
    conda:
        "envs/pypsa-eur.yaml"
    notebook:
        "notebooks/merge_austrian_network.py.ipynb"