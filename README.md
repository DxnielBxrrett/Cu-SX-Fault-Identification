<img src="assets/schematics/process_schematic.png">

# Process State Identification

<img src="https://img.shields.io/badge/Stellenbosch University-BEng ChemE-008BC0?style=flat"/>

Chemical Engineering final year project using PCA and statistical classification to identify a process' state.

The process model consists of a dynamic model of a copper solvent extraction plant based on the model developed by Komulainen et al. (2009, 2006). 
The model simulates two control valve faults, namely:

- stuck valves
- and valve stiction, based on the physical valve stiction model developed by Shoukat Choudhury et al. (2005)

## 1. Process model

### 1.1. Running the model

1. Run the Simulink model from the MATLAB Live Script `process_model/copper_solvent_extraction_model.mlx`
1. Run the MATLAB Live Script from the main `Process-State-Identification` folder

### 1.2. Process settings

#### Table 1: Process settings
| Setting                           | Values                       | Description                                                                 |
|-----------------------------------|------------------------------|-----------------------------------------------------------------------------|
| `SAVE_IMAGES`                     | `true` <br> `false`          | Saves the generated images to the respective output folder if set to `true`.|
| `SAVE_DATA`                       | `true` <br> `false`          | Saves the simulation data to the respective output folder if set to `true`. |
| `SENSOR_NOISE`                    | `true` <br> `false`          | Adds sensor noise to the measurements if set to `true`.                     |
| `FEEDBACK_CONTROL`                | `true` <br> `false`          | Enables feedback control of the process if set to `true`.                   |
| `FEEDFORWARD_CONTROL`             | `true` <br> `false`          | Enables feedforward control of the process if set to `true`.                |
| `EXTERNAL_VARIABLES_STEADY_STATE` | `true` <br> `false`          | Sets the external variables to their constant steady-state values when set to `true`, or loads the non-steady-state external variable dataset selected by `EXTERNAL_VARIABLES_DATASET` when set to `false`.|
| `EXTERNAL_VARIABLES_DATASET`      | `'training'` <br> `'testing'`| Loads the training non-steady-state external variable dataset when set to `'training'`, or the testing non-steady-state external variable dataset when set to `'testing'`. Must specify a dataset to use regardless of the value of `EXTERNAL_VARIABLES_STEADY_STATE`.|
| `LOWPASS_FILTER_TUNING`           | `true` <br> `false`          | Stops the loaded organic and lean electrolyte stiction models from 'sticking' when set to `true`. This can be used to tune the loaded organic and lean electrolyte stiction lowpass filters (see below). The loaded organic and lean electrolyte stiction models work as expected when set to `false`.|
| `PROCESS_STATE`                   | see below                    | Select which process faults occur by selecting the process state. See Process States section below. |

### 1.3. Output folder structure

Create the following folder structure to save to simulation results using the `SAVE_IMAGES` and `SAVE_DATA` settings:

```
.
|__ process_model
    |__ output
        |__ data
        |__ graphs
            |__ measured_variables
            |__ process_variables
            |__ valve_states
```

### 1.4. Process states

The desired fault combinations can be set using the `PROCESS_STATE` setting. The following table shows which loaded organic valve faults and which lean electrolyte valve faults occur for the selected process state.

#### Table 2: Process states
| Process State | Loaded Organic Valve | Lean Electrolyte Valve |
|:-------------:|:--------------------:|:----------------------:|
|      `0`      |        normal        |         normal         |
|      `1`      |         stuck        |         normal         |
|      `2`      |       stiction       |         normal         |
|      `3`      |        normal        |          stuck         |
|      `4`      |        normal        |        stiction        |
|      `5`      |         stuck        |          stuck         |
|      `6`      |         stuck        |        stiction        |
|      `7`      |       stiction       |          stuck         |
|      `8`      |       stiction       |        stiction        |

The valve states are represented by the following values, and are selected using variant subsystems:

#### Table 3: Valve states
| Value | Valve State |
|:-----:|:-----------:|
|  `0`  |    normal   |
|  `1`  |    stuck    |
|  `2`  |   stiction  |

The time that the selected process faults occur can be set using the following `start_time` parameters. Corresponding `stop_time` parameters are also provided to set the time at which the process faults stop ocurring. If no stop time is desired, set the respective `stop_time` parameter equal to the simulation time.

#### Table 4: Process fault start and stop time settings
| Parameter                   | Units | Description                                          |
|-----------------------------|:-----:|------------------------------------------------------|
| `valve_LO_fault_start_time` |   s   | Time for the loaded organic valve's fault to occur   |
| `valve_LO_fault_stop_time`  |   s   | Time for the loaded organic valve's fault to stop    |
| `valve_LE_fault_start_time` |   s   | Time for the lean electrolyte valve's fault to occur |
| `valve_LE_fault_stop_time`  |   s   | Time for the lean electrolyte valve's fault to stop  |

### 1.5 Lowpass filter tuning

The loaded organic and lean electrolyte control valve stiction models use 1<sup>st</sup> order Butterworth filters to account for the sensor noise's effect on the valve stem positions. The valves 'stick' when the filtered valve position reaches a turning point.

The cutoff frequency of the lowpass filters can be tuned by seting the `LOWPASS_FILTER_TUNING` setting to `true`. The stiction models then still run, but the control valves will not 'stick'. The filtered signals can be viewed using the `Valve LO Lowpass Filter Scope` and `Valve LE Lowpass Filter Scope` scopes found in their respective stiction-valve-model subsytems.

The cutoff frequency for the loaded organic control valve's lowpass filter can be set using `valve_LO_stiction_lowpass_filter_cutoff_frequency` (rad/s). The cutoff frequency for the lean electrolyte control valve's lowpass filter can be set using `valve_LE_stiction_lowpass_filter_cutoff_frequency` (rad/s). 

## 2. External variables

### 2.1. Running the model

1. Run the Simulink model from the MATLAB Live Script `gaussian_external_variables.mlx`
1. Run the MATLAB Live Script from the main `Process-State-Identification` folder

### 2.2. Output folder structure

Create the following folder structure to save the smoothed external variable data and graphs:

```
.
|__ external_variables
    |___ output
         |__ data
         |__ graphs

```

### 2.3. Using the generated external variables

Copy the generated external variable .mat files over to the following folder to use them in the process model:

```
.
|__ external_variables
    |___ data

```

### 2.4. External variables used in the simulation

The following settings were used in the Signal Builder blocks in the `gaussian_external_variables.slx` file to generate the non-steady-state external variables used for the process model:

#### Table 5: External variable properties
|      Property      |                 Value                |
|:------------------:|:------------------------------------:|
|   Simulation time  |       20 hours (72000 seconds)       |
|    Sampling time   |              0.1 second              |
| Standard deviation | $\sigma$ = 0.20 x steady-state value |
|  Sample frequency  |              0.00015 Hz              |

The first and last points of each signal were manually changed to start and stop on the steady-state values of the respective variable.

#### Table 6: Training external variable properties
|    Variable    |    Mean    |  Standard deviation    | Units |    Seed    |
|:--------------:|:----------:|:----------------------:|:-----:|:----------:|
|    $c_{PLS}$   |      7     |           1.4          |  g/L  |      1     |
|    $c_{LE}$    |     35     |           7.0          |  g/L  |      2     |
|   $f_{PLSP}$   |     278    |          55.6          |  L/s  |      5     |
|   $f_{PLSS}$   |     278    |          55.6          |  L/s  |     16     |

#### Table 7: Testing external variable properties
|    Variable    |    Mean    |  Standard deviation    | Units |    Seed    |
|:--------------:|:----------:|:----------------------:|:-----:|:----------:|
|    $c_{PLS}$   |      7     |           1.4          |  g/L  |     19     |
|    $c_{LE}$    |     35     |           7.0          |  g/L  |     22     |
|   $f_{PLSP}$   |     278    |          55.6          |  L/s  |     28     |
|   $f_{PLSS}$   |     278    |          55.6          |  L/s  |     30     |

## 3. Controller tuning

### 3.1. Running the model

1. Run the Simulink model from either of the following two MATLAB Live Scripts:
    1. `feedback_arx_models.mlx`
    1. `feedforward_arx_models.mlx`
1. Run the above mentioned MATLAB Live Scripts from the main `Process-State-Identification` folder

### 3.2. Output folder structure

Create the following folder structure to save the ARX model results:

```
.
|__ controller_tuning
    |__ output
        |__ feedback
        |__ feedforward
```

## References

Komulainen, T., Doyle, F.J., Rantala, A., Jämsä-Jounela, S.L., 2009. Control of an industrial copper solvent extraction process. Journal of Process Control 19, 2–15. https://doi.org/10.1016/j.jprocont.2008.04.019

Komulainen, T., Pekkala, P., Rantala, A., Jämsä-Jounela, S.L., 2006. Dynamic modelling of an industrial copper solvent extraction process. Hydrometallurgy 81, 52–61. https://doi.org/10.1016/j.hydromet.2005.11.001

Shoukat Choudhury, M.A.A., Thornhill, N.F., Shah, S.L., 2005. Modelling Valve Stiction. Control Eng Pract 13, 641–658. https://doi.org/10.1016/j.conengprac.2004.05.005


