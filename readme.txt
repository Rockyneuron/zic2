## Analysis code for optical imaging data

### Overview
This repository contains the analysis code used in the paper "Induced emergence of ocular dominance columns enhances mouse binocular vision and hunting behavior".

## Installation and Setup

1. Download the `analysed` folder from the repository [3]
2. Extract the `analysed` folder into the repository location and delete the zip file
3. Execute `extract_table_data.mat`

## Data Processing

The main script (`extract_table_data.mat`) processes data from the analysed folder by iterating through each experiment listed in `exp.txt` to generate a final data matrix saved as 'data_table.xlsx'. This table contains the data presented in Figure 3 of the primary publication [1].

The analyzed folder is available at [3], containing individual experimental results of the ocular dominance maps computed.

### Preprocessing Pipeline

A preprocessing script `analysis_mouse.m` demonstrates the computation methodology for the analyzed folder data. This script processes raw experimental data (available in [2]) following the protocols outlined in the materials and methods section of [1].
Experiment labels for contralateral and ipsilateral stimulation are documented in [2].

#### Required Parameters

To analyze individual mouse data, the following parameters must be specified:

- `file_store`: Directory path for preprocessed data storage
- `filename`: Raw data experiment identifier
- `contra`: Filename of .mat file containing contralateral stimulation data
- `ipsi`: Filename of .mat file containing ipsilateral stimulation data

## Authors

**Author:**  
Arturo José Valiño Pérez

**Corresponding Author:**  
Arturo José Valiño Pérez  
Email: arturo-jose.valino@incipit.csic.es

## References

1. Induced emergence of ocular dominance columns enhances mouse binocular vision and hunting behavior
2. Raw data available at: https://saco.csic.es/apps/files/files/207847421?dir=/zic2/code_data_zic2/data/raw_data/optical_imaging
3. Analysis code available at: https://saco.csic.es/apps/files/files/198269553?dir=/zic2/code_data_zic2/code/optical_imaging_analysis