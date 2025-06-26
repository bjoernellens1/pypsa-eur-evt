# This Snakefile serves as a wrapper for the pypsa-eur-evt workflow, integrating residual loads.
# It includes the main pypsa-eur workflow Snakefile, allowing for partial overrides.
# Additionally, it incorporates custom rules for Austria-specific event modeling from 'rules/MA/evt_MA_austria.smk'.
# Uncomment the relevant line to include further custom rules for adding residual loads if needed.

# Wrapper Snakefile for pypsa-eur-evt with austrian cross-border lines and custom residual loads integration

include: "Snakefile"  # include the main pypsa-eur workflow, that will be partly overriden by this Snakefile
include: "rules/MA/evt_MA_austria.smk"