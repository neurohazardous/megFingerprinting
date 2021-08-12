## License  
This file is part of the project megFingerprinting. All of megFingerprinting code is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. megFingerprinting is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with megFingerprinting. If not, see <https://www.gnu.org/licenses/>.

## Status
Manuscript has been submitted and is under review

## Objective
To identify people based on patterns of brain activity (as indexed by  MEG) and how demographic data interacts with this 

## Colaborators
Both Jason da Silva and [Hector Orozco](https://www.linkedin.com/in/hectordorozco/) contributed equally to this project (both are first authors of this study)

## Supervisors
[Dr Bratislav Misic](https://www.mcgill.ca/neuro/research/researchers/bratislav-misic) and [Dr Sylvain Baillet](https://www.mcgill.ca/neuro/research/researchers/baillet) at the Montreal Neurological Institute

## Dataset  
For this project we've been using [OMEGA](https://www.mcgill.ca/bic/resources/omega). The Open MEG Archive (OMEGA) is the fruit of a collaborative effort between the McConnell Brain Imaging Centre (MNI, McGill) and the Université de Montréal to provide a core repository of MEG data for open dissemination.

## Contents
The codes listed below are intended to allow other researchers to preprocess, fingerprint, and plot their results on both the OMEGA dataset as well as other MEEG data

### 1-dataSetup_BIDS
* This bash script will download the folders from the BIC server to your local computer. **You need special access for this**
    * Needs to be run from the local computer
    * Specify the number of participants that it will download in line 19
    * It also downloads metadata, empty room recordings, and extra files
    * It uses rsync, so, if the file was already downloaded, it will not overwrite it
    * Please note it downloads reconstructed anatomy data from a preprocessed version of OMEGA, as opposed to the newest OMEGA version

### 2-preprocessing_AEC_ortho.m and 2-preprocessing_PSD.m
* These MATLAB scripts take all the subjects in the OMEGA_BIDS folder and preprocess them. One of them was intended for the amplitude envelope correlation analysis (connectivity), and the other to explore area-specific power spectral density (PSD) 
* MEG Preprocessing pipline:
    1. Import BIDS dataset (will not work if we are not using this format!)
    2. Import subject's anatomy
    3. Prepare MEG and Noise files
    4. Run PSD on sensors
    5. Filtering: Line noise and high pass
    6. SSP: EOG and ECG
    7. postProcessing: PSD on sensors
    8. SSP: Sacades and EMG
    9. Preprocess empty room recordings
    10. Separate into FOI's
    11. Data/Noise Covariance
    12. Compute head model
    13. Inverse Modelling: Beamformers
    14. Snapshot: Contact sheet of sources
    15. Amplitude Envelope Correlation or PSD estimation
    16. Output CSV file
    17. Save and ouput report
    18. Delete intermediate files and save beamformer weights
* All output files are saved in output folder...
    * Brainstorm's subject report
    * The output of the PCA (% variance explained)
    * Matrices (csv format)
    * Matrices (brainstorm file (.mat))

### 3-matrix_visualization.ipynb
* This notebook has some useful functions to plot the connectivity matrices and to assign the different areas to the corresponding resting state network  

### 4-AEC_fingerprinting_\*.ipynb and 4-PSD_fingerprinting_*\.ipynb
* We used the same method as Finn et al., 2015 & Amico & Goñi, 2018 to compare both PCA reconstructed data and raw data
* After that, we run edge-wise analysis to understand what connections are consistent at the group level and which ones are more important to identify individuals than others
* Finally, we run several sanity checks (correlating identifiability with subject characteristics and artifact summary statistics & separating structural connectivity and functional connectivity)
* We perform this analysis with our different analysis conditions: between session, within sessions, for both AEC and PSD, for both the broadband data and specific frequency bands
* Please note that subject identification is referred to as differentiation in the manuscript and 'self-identifiability' is referred to as differentiability in the manuscript

### 5-PLS_analysis.m
* Performs the Partial Least Square analysis to try and find relationships between individuals' identifiability matrices and demographic information

### 6-Plotting_results_with_ggplot.R
* Plots PLS results

### Dependencies
* Includes files that correspond to the assignation of the different anatomical areas to the resting state network, analysis used to compare movement/heart/eye artifacts to indidividuals' identifiability scores (used as sanity checks)...

## Important Note
Please note that subject identification is referred to as differentiation in the manuscript and 'self-identifiability' is referred to as differentiability in the manuscript.
