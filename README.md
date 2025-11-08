# Power Control in Wireless Networks (MATLAB Project)

## Project Summary
MATLAB implementation of distributed power control algorithms for wireless networks. Models multi-user interference and achieves target SINR through iterative power adjustments. Demonstrates convergence/divergence based on Perron-Frobenius feasibility conditions with comprehensive analysis and visualization.

## Core Features
* **Distributed Power Control Algorithm**: Implements iterative power update: `p_i(t+1) = (γ_i^* / γ_i(t)) * p_i(t)`
* **Multi-User Interference Modeling**: Realistic channel gains and interference patterns between transmitters/receivers
* **Feasibility Analysis**: Perron-Frobenius eigenvalue calculation (ρ(F) < 1) for system convergence verification
* **Comprehensive Visualization**: Automatic generation of power evolution plots for convergent (3-user) and divergent (4-user) scenarios
* **Performance Validation**: SINR target achievement verification with detailed iteration analysis

## Key Methods and Algorithms
* **SINR Calculation**: `γ_i(t) = (G_ii × p_i(t)) / (Σ_{j≠i} G_ij × p_j(t) + σ²)`
* **Distributed Power Control**: Iterative algorithm using local SINR measurements only
* **Matrix Analysis**: Construction and eigenvalue analysis of F matrix for feasibility determination
* **Convergence Monitoring**: Real-time tracking of power levels and SINR achievement

## Technical Implementation
* **Channel Modeling**: Complete channel gain matrices for transmitter-receiver pairs
* **Interference Management**: Cross-user interference calculation and mitigation
* **System Scenarios**: 3-user (feasible) vs 4-user (infeasible) configuration testing
* **Parameter Analysis**: Target SINR validation under different channel conditions

## Skills Demonstrated
* Wireless communication system modeling and simulation
* Distributed algorithm implementation and convergence analysis
* Linear algebra applications (Perron-Frobenius theorem)
* Multi-user interference management in shared channels
* MATLAB programming for scientific computing and data visualization
* System feasibility analysis and performance validation

## File Overview
| File Name | Description |
|-----------|-------------|
| `power_control.m` | Complete MATLAB implementation of power control algorithm |
| `plot_3users.png` | Power convergence visualization for 3-user feasible system |
| `plot_4users.png` | Power divergence visualization for 4-user infeasible system |

## How to Run
**Requirements**: MATLAB R2018b or newer

**Execution**:
```matlab
power_control
