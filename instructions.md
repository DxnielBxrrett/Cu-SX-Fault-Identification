# Instructions

Instructions for running the process model, generating the external variable datasets, tuning the feedback and feedforward controllers, performing the fault detection, and quantifying the fault detection performance are provided in this document.

### Table of Contents

- [1. Process model \[1\]](#1-process-model-1)
  - [1.1. Running the model](#11-running-the-model)
  - [1.2. Process settings](#12-process-settings)
  - [1.3. Output folder structure](#13-output-folder-structure)
  - [1.4. Process states](#14-process-states)
  - [1.5 Lowpass filter tuning](#15-lowpass-filter-tuning)
- [2. External variables](#2-external-variables)
  - [2.1. Running the model](#21-running-the-model)
  - [2.2. Output folder structure](#22-output-folder-structure)
  - [2.3. Using the generated external variables](#23-using-the-generated-external-variables)
  - [2.4. External variables used in the simulation](#24-external-variables-used-in-the-simulation)
- [3. Controller tuning \[4\]](#3-controller-tuning-4)
  - [3.1. Running the model](#31-running-the-model)
  - [3.2. Output folder structure](#32-output-folder-structure)
- [4. Fault detection](#4-fault-detection)
  - [4.1. Running the fault detection](#41-running-the-fault-detection)
  - [4.2. Fault detection settings](#42-fault-detection-settings)
  - [4.3. Output folder structure](#43-output-folder-structure)
- [5. ROC curves \[7\]](#5-roc-curves-7)
  - [5.1. Generating the ROC curves](#51-generating-the-roc-curves)
  - [5.2. ROC curve settings](#52-roc-curve-settings)
  - [5.3. Constructing the ROC curves](#53-constructing-the-roc-curves)
  - [5.4. Output folder structure](#54-output-folder-structure)
- [References](#references)

## 1. Process model [1]

### 1.1. Running the model

1. Run the Simulink model from the MATLAB Live Script `process_model/copper_solvent_extraction_model.mlx`
1. Run the MATLAB Live Script from the main `Process-State-Identification` folder

### 1.2. Process settings

#### Table 1: Process settings
| Setting                           | Values                       | Description                                                                  |
|-----------------------------------|------------------------------|------------------------------------------------------------------------------|
| `SAVE_IMAGES`                     | `true` <br> `false`          | Saves the generated images to the respective output folders if set to `true`.|
| `SAVE_DATA`                       | `true` <br> `false`          | Saves the simulation data to the respective output folder if set to `true`.  |
| `SENSOR_NOISE`                    | `true` <br> `false`          | Adds sensor noise to the measurements if set to `true`.                      |
| `FEEDBACK_CONTROL`                | `true` <br> `false`          | Enables feedback control of the process if set to `true`.                    |
| `FEEDFORWARD_CONTROL`             | `true` <br> `false`          | Enables feedforward control of the process if set to `true`.                 |
| `EXTERNAL_VARIABLES_STEADY_STATE` | `true` <br> `false`          | Sets the external variables to their constant steady-state values when set to `true`, or loads the non-steady-state external variable dataset selected by `EXTERNAL_VARIABLES_DATASET` when set to `false`.|
| `EXTERNAL_VARIABLES_DATASET`      | `'training'` <br> `'testing'`| Loads the training non-steady-state external variable dataset when set to `'training'`, or the testing non-steady-state external variable dataset when set to `'testing'`. Must specify a dataset to use regardless of the value of `EXTERNAL_VARIABLES_STEADY_STATE`.|
| `LOWPASS_FILTER_TUNING`           | `true` <br> `false`          | Stops the loaded organic and lean electrolyte stiction models from 'sticking' when set to `true`. This can be used to tune the loaded organic and lean electrolyte stiction lowpass filters (see below). The loaded organic and lean electrolyte stiction models work as expected when set to `false`.|
| `PROCESS_STATE`                   | see below                    | Select which process faults occur by selecting the process state. See section 1.4. Process States below.                                   |
| `PROCESS_STATE_PLOTTING_REDUCED`  | `true` <br> `false`          | Only plots the single-fault process states (`0` to `4`) when set to `true`. Plots all the process states (`0` to `8`) when set to `false`. |

### 1.3. Output folder structure

The .gitignore file has been set up to ignore all output folders.

Create the following folder structure to save the simulation results using the `SAVE_IMAGES` and `SAVE_DATA` settings:

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

The desired fault combinations can be set using the `PROCESS_STATE` setting. The process states used are as follows:
Process state 0: Normal operation

Process state 3: Extractant degradation fault

Process state 4: Stuck valve fault

Process state 14: Sensor drift fault

Process state 18: Precision degradation fault

Process state 19: Combination of process state 3 and 14

Process state 20: Combination of process state 3, 14 and 18

Process state 21: Combination of process state 14 and 18



## 2. External variables

### 2.1. Running the model

1. Run the Simulink model from the MATLAB Live Script `gaussian_external_variables.mlx`
1. Run the MATLAB Live Script from the main `Process-State-Identification` folder

### 2.2. Output folder structure

Create the following folder structure to save the smoothed external variable data and graphs:

```
.
|__ external_variables
    |__ output
        |__ data
        |__ graphs

```

### 2.3. Using the generated external variables

Copy the generated external variable .mat files over to the following folder to use them in the process model:

```
.
|__ external_variables
    |__ data

```

### 2.4. External variables used in the simulation

The following settings were used in the Signal Builder blocks in the `gaussian_external_variables.slx` file to generate the non-steady-state external variables used for the process model:

#### Table 5: External variable properties
|      Property      |                 Value                |
|:------------------:|:------------------------------------:|
|   Simulation time  |      200 hours (720 000 seconds)     |
|    Sampling time   |              1 second                |
| Standard deviation | $\sigma$ = 0.10 x steady-state value |
|  Sample frequency  |              0.00005 Hz              |

The first and last points of each signal were manually changed to start and stop on the steady-state values of the respective variable.

#### Table 6: Training external variable properties
|    Variable    |    Mean    |  Standard deviation    | Units |    Seed    |
|:--------------:|:----------:|:----------------------:|:-----:|:----------:|
|    $c_{PLS}$   |      7     |           0.7          |  g/L  |      1     |
|    $c_{LE}$    |     35     |           3.5          |  g/L  |      2     |
|   $f_{PLSP}$   |     278    |          27.8          |  L/s  |      5     |
|   $f_{PLSS}$   |     278    |          27.8          |  L/s  |     16     |

#### Table 7: Testing external variable properties
|    Variable    |    Mean    |  Standard deviation    | Units |    Seed    |
|:--------------:|:----------:|:----------------------:|:-----:|:----------:|
|    $c_{PLS}$   |      7     |           0.7          |  g/L  |     19     |
|    $c_{LE}$    |     35     |           3.5          |  g/L  |     22     |
|   $f_{PLSP}$   |     278    |          27.8          |  L/s  |     28     |
|   $f_{PLSS}$   |     278    |          27.8          |  L/s  |     30     |

## 3. Controller tuning [4]

### 3.1. Running the model

1. Run the Simulink model from either of the following two MATLAB Live Scripts:
    1. `FOPDT_feedback.mlx`
    1. `FOPDT_feedforward.mlx`
1. Run the above mentioned MATLAB Live Scripts from the main `Process-State-Identification` folder

### 3.2. Output folder structure

Create the following folder structure to save the ARX model [5] results:

```
.
|__ controller_tuning
    |__ output
        |__ feedback
        |__ feedforward
```

## References

[1]	T. Komulainen, P. Pekkala, A. Rantala, and S.-L. Jämsä-Jounela, “Dynamic modelling of an industrial copper solvent extraction process,” Hydrometallurgy, vol. 81, no. 1, pp. 52–61, Jan. 2006, doi: 10.1016/j.hydromet.2005.11.001.


[4]	T. Komulainen, F. J. Doyle, A. Rantala, and S. L. Jämsä-Jounela, “Control of an industrial copper solvent extraction process,” J Process Control, vol. 19, no. 1, pp. 2–15, Jan. 2009, doi: 10.1016/j.jprocont.2008.04.019.

[5]	T. E. Marlin, Process Control: Designing Processes and Control Systems for Dynamic Performance, 2nd ed. 2015.


[7]	G. James, D. Witten, T. Hastie, and R. Tibshirani, An Introduction to Statistical Learning. New York, NY: Springer US, 2021. doi: 10.1007/978-1-0716-1418-1.
