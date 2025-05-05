rule build_austrian_network:
    input:
        buses="data/MA/shapefiles/buses_aut.shp",
        lines="data/MA/shapefiles/lines_aut.shp"
    output:
        network="resources/networks/austria.nc"
    conda:
        "envs/pypsa-eur.yaml"
#    script:
#        "../../scripts/MA/build_austrian_network.py"
    notebook:
        "notebooks/build_austrian_network.py.ipynb"