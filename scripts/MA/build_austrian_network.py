import geopandas as gpd
import pypsa
from shapely.geometry import LineString, Point

# Load inputs
buses_gdf = gpd.read_file(snakemake.input.buses)
lines_gdf = gpd.read_file(snakemake.input.lines)

# Initialize network
network = pypsa.Network()

# Helper to add buses
def add_bus(point, network):
    bus_id = f"Bus_{point.x:.5f}_{point.y:.5f}"
    if bus_id not in network.buses.index:
        network.add("Bus", bus_id, x=point.x, y=point.y)
    return bus_id

# Add lines with valid geometries
for idx, row in lines_gdf.iterrows():
    geom = row.geometry
    if not isinstance(geom, LineString) or geom is None or len(geom.coords) < 2:
        continue  # Skip invalid geometries

    try:
        start, end = Point(geom.coords[0]), Point(geom.coords[-1])
        bus0 = add_bus(start, network)
        bus1 = add_bus(end, network)

        network.add("Line", f"Line_{idx}", bus0=bus0, bus1=bus1, x=0, y=0, r=0.01, s_nom=100, capital_cost=500)

    except Exception as e:
        print(f"Skipping line {idx}: {e}")

# Export the network
network.export_to_netcdf(snakemake.output.network)
