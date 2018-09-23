## License  
This file is part of the project megFingerprinting. All of megFingerprinting code is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. megFingerprinting is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with megFingerprinting. If not, see <https://www.gnu.org/licenses/>.

## Status
On going - We have an accuracy of ~95% using linear methods (correlations) and dimensionality reduction techniques (PCA). We are currently running follow up analysis (i.e. is it really the dynamic connectivity that helps us identify people or is it a by-product of source modelling?)

## Objective
To identify people based on patterns of brain connectivity (as indexed by  MEG) using Deep Learning and other linear methods

## Supervisors
[Dr Bratislav Misic](https://www.mcgill.ca/neuro/research/researchers/bratislav-misic) and [Dr Sylvain Baillet](https://www.mcgill.ca/neuro/research/researchers/baillet) at the Montreal Neurological Institute

## Dataset  
For this project we've been using [OMEGA](https://www.mcgill.ca/bic/resources/omega). The Open MEG Archive (OMEGA) is the fruit of a collaborative effort between the McConnell Brain Imaging Centre (MNI, McGill) and the Université de Montréal to provide a core repository of MEG data for open dissemination.

## Contents
### 1-dataSetup_BIDS
* This bash script will download the folders from the BIC server to your local computer. **You need special access for this**
    * Needs to be run from the local computer
    * Specify the number of participants that it will download in line 19
    * It also downloads metadata, empty room recordings, and extra files
    * It uses rsync, so, if the file was already downloaded, it will not overwrite it
    * Please note it downloads reconstructed anatomy data from a preprocessed version of OMEGA, as opposed to the newest OMEGA version

### 2-preprocessing.m
* This MATLAB scripts takes all the subjects in the OMEGA_BIDS folder and preprocess them
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
    15. Amplitude Envelope Correlation
    16. Output CSV file
    17. Save and ouput report
    18. Delete intermediate files and save beamformer weights
* All output files are saved in output folder...
    * Brainstorm's subject report
    * The output of the PCA (% variance explained)
    * Matrices (csv format)
    * Matrices (brainstorm file (.mat))

### 3-fingerprinting_deep_learning.ipynb
* The Artificial Neural Network, as of now, it performs at chance level. Because of this, we decided to try other types of analysis

### 4-fingerprinting_corr_pca.ipynb
* We used the same method as Finn et al., 2015 & Amico & Goñi, 2018, and we get an accuracy of 96% with the PCA reconstructed data
* After that, we run edge-wise analysis to understand what connections are consistent at the group level and which ones are more important to identify individuals than others
* Finally, we run several sanity checks (correlating identifiability with subject characteristics and artifact summary statistics & separating structural connectivity and functional connectivity)
