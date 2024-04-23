Code for anlysis of experiments for paper "    "


The code is divided in two main scripts.
1) A preprocessing script:

     The script analysis_mouse.m  is used to preprocess the data of each experiment. The raw data is called from 
     '../data/raw_data'. The protocol for the anlysis follows the instructions from the materials and methods of [].
     Overall the code runs the preprocessing steps from [] and saves the data of the analysed experiment in a separate folder.

2) A data extraction script:
     After all data was is processed by <analysis_mouse.mat> the code 
     extract table data is used to loop across each expermiment in exp.txt to obtain a final data_matrix called 
     'data_table.xlsx'. This table contains the final data of the figure [] from the paper.


To execute the analysis, simply run the "extract_table_data.mat" file.
Inside, you will find the data from each preprocessed experiment that has been analyzed.


1) PREPROCESSING:
For each experiment introduce the parameters of interest to run the experiment.
paratemers:
- <file_store>: string that indicates the folder to save the preprecossed 
- <filename>: string that indicates the raw data experiment you want to preprocess
- <contra>: string with the name of the .mat file that contins data for contra stimulation
- <ipsi>: string with the name of the .mat file that contins data for ipsi stimulation

Each mouse analysis is saved in a separated folder  file_store 'analysed' with the name of the 
folder as in filename.



Author:                             Arturo José Valiño Pérez

Corresponding author:              Arturo José Valiño Pérez (arturo-jose.valino@incipit.csic.es)
