container: "docker://git.unileoben.ac.at:5050/evt1/pypsa-eur-evt:latest"
rule build_austrian_network:
    # input:
    #     buses="data/MA/shapefiles/buses_aut.shp",
    #     lines="data/MA/shapefiles/lines_aut.shp"
    output:
        network= resources("networks/austria.nc") #"resources/networks/austria.nc"
    conda:
        "envs/pypsa-eur.yaml"
    notebook:
        "notebooks/build_austrian_network_postgis.py.ipynb"