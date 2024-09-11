Code for anlysis of experiments for paper [1]

To execute the analysis follow these steps:

1) Download the <analysed> folder from [3]
2) Extract the <analysed> folder into the repository location. Delete the zip file
3) Run "extract_table_data.mat":


This script uses the data from the analysed folder to loop across each expermiment in exp.txt to obtain a final data_matrix called 
'data_table.xlsx'. This table contains the data of figure 3 from [1].
The analysed folder can also be found in [3]. Inside each folder the resulting data from each experiment can be seen.

There is also a preprocessing script  "analysis_mouse.m"  to show how the data from the analysed folder was computed.
This script  was used to preprocess the raw data of each experiment. The raw data is called from the raw data folder in [2].
The protocol for the analysis follows the instructions from the materials and methods of [1].
Overall the code runs the preprocessing steps from [1] and saves the data of the analysed experiment in a separate folder.
The label of experiments for contralateral and ipsililateral stimulation can be found in the table from [2]

     To run each experiment introduce the parameters of interest to run the analysis for each individual moouse.
     paratemers:
     - <file_store>: string that indicates the folder to save the preprecossed 
     - <filename>: string that indicates the raw data experiment you want to preprocess
     - <contra>: string with the name of the .mat file that contins data for contra stimulation
     - <ipsi>: string with the name of the .mat file that contins data for ipsi stimulation

Author:                             Arturo José Valiño Pérez

Corresponding author:              Arturo José Valiño Pérez (arturo-jose.valino@incipit.csic.es)


1. Genetic Rewiring of Retinothalamic Neurons Induces Ocular Dominance Columns in mice and Enhances Binocular Vision and Predatory Behaviors 
2. https://saco.csic.es/apps/files/files/207847421?dir=/zic2/code_data_zic2/data/raw_data/optical_imaging'.
3. https://saco.csic.es/apps/files/files/198269553?dir=/zic2/code_data_zic2/code/optical_imaging_analysis