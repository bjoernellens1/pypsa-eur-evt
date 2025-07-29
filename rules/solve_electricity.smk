# SPDX-FileCopyrightText: Contributors to PyPSA-Eur <https://github.com/pypsa/pypsa-eur>
#
# SPDX-License-Identifier: MIT

# Rule: solve_network
# -------------------
# Solves the electricity network optimization problem using parameters and inputs dynamically loaded from the config file.
#
# Parameters:
#   - solving: Dictionary of solving options from config.
#   - foresight: Foresight setting from config.
#   - co2_sequestration_potential: Maximum CO2 sequestration allowed (default: 200).
#   - custom_extra_functionality: Additional custom functionality for the solver.
#
# Input:
#   - network: Path to the input network file, dynamically determined from config or default pattern.
#
# Output:
#   - network: Path to the solved network file.
#   - config: Path to the configuration file used for this run.
#
# Log:
#   - solver: Log file for solver output.
#   - memory: Log file for memory usage.
#   - python: Log file for Python execution.
#
# Benchmark:
#   - Benchmark file for this rule's execution.
#
# Threads:
#   - Number of threads for the solver, specified by `solver_threads`.
#
# Resources:
#   - mem_mb: Memory allocation for the rule.
#   - runtime: Maximum runtime, from config (default: 6h).
#
# Shadow:
#   - Uses shadow directory as specified by `shadow_config`.
#
# Conda:
#   - Uses the environment specified in "../envs/environment.yaml".
#
# Script:
#   - Executes "../scripts/solve_network.py" to perform the network solving.
## Altered for MA (Masterarbeit) workflow. Dynamic loading from configfile
rule solve_network:
    params:
        solving=config_provider("solving"),
        foresight=config_provider("foresight"),
        co2_sequestration_potential=config_provider(
            "sector", "co2_sequestration_potential", default=200
        ),
        custom_extra_functionality=input_custom_extra_functionality,
    #input:
        network=resources("networks/base_s_{clusters}_elec_{opts}.nc"),
    input:
        network=resources("networks/base_s_{clusters}_elec_residualload.nc"),
    # input:
    #     network=lambda wildcards: config.get(
    #         "solve_network_input",
    #         resources(f"networks/base_s_{wildcards.clusters}_elec_{wildcards.opts}.nc")        ),
    output:
        network=RESULTS + "networks/base_s_{clusters}_elec_{opts}.nc",
        config=RESULTS + "configs/config.base_s_{clusters}_elec_{opts}.yaml",
    log:
        solver=normpath(
            RESULTS + "logs/solve_network/base_s_{clusters}_elec_{opts}_solver.log"
        ),
        memory=RESULTS + "logs/solve_network/base_s_{clusters}_elec_{opts}_memory.log",
        python=RESULTS + "logs/solve_network/base_s_{clusters}_elec_{opts}_python.log",
    benchmark:
        (RESULTS + "benchmarks/solve_network/base_s_{clusters}_elec_{opts}")
    threads: solver_threads
    resources:
        mem_mb=memory,
        runtime=config_provider("solving", "runtime", default="6h"),
    shadow:
        shadow_config
    conda:
        "../envs/environment.yaml"
    script:
        "../scripts/solve_network.py"


rule solve_operations_network:
    params:
        options=config_provider("solving", "options"),
        solving=config_provider("solving"),
        foresight=config_provider("foresight"),
        co2_sequestration_potential=config_provider(
            "sector", "co2_sequestration_potential", default=200
        ),
        custom_extra_functionality=input_custom_extra_functionality,
    input:
        network=RESULTS + "networks/base_s_{clusters}_elec_{opts}.nc",
    output:
        network=RESULTS + "networks/base_s_{clusters}_elec_{opts}_op.nc",
    log:
        solver=normpath(
            RESULTS
            + "logs/solve_operations_network/base_s_{clusters}_elec_{opts}_op_solver.log"
        ),
        python=RESULTS
        + "logs/solve_operations_network/base_s_{clusters}_elec_{opts}_op_python.log",
    benchmark:
        (RESULTS + "benchmarks/solve_operations_network/base_s_{clusters}_elec_{opts}")
    threads: 4
    resources:
        mem_mb=memory,
        runtime=config_provider("solving", "runtime", default="6h"),
    shadow:
        shadow_config
    conda:
        "../envs/environment.yaml"
    script:
        "../scripts/solve_operations_network.py"
