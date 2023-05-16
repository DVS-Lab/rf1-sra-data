# ISTART-data: Data Management and Preprocessing
This repository contains the final code for managing and processing all of the data in our ISTART project. The data will eventually be placed on [OpenNeuro][openneuro]. More information about the project can be found in [Sazhin et al., 2020, Journal of Psychiatry and Brain Science.](https://doi.org/10.20900/jpbs.20200024)



## A few prerequisites and recommendations
- Understand BIDS and be comfortable navigating Linux
- Install [FSL](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation)
- Install [miniconda or anaconda](https://stackoverflow.com/questions/45421163/anaconda-vs-miniconda)
- Install PyDeface: `pip install pydeface`
- Make singularity containers for heudiconv (version: 0.9.0), mriqc (version: 0.16.1), and fmriprep (version: 20.2.3).


## Notes on repository organization and files
- Raw DICOMS (an input to heudiconv) are only accessible locally (Smith Lab Linux: /data/sourcedata)
- Some of the contents of this repository are not tracked (.gitignore) because the files are large and we do not yet have a nice workflow for datalad. Note that we only track key text files in `bids` and `derivatives`.
- Tracked folders and their contents:
  - `code`: analysis code
  - `derivatives`: stores derivates from our scripts
  - `bids`: contains the standardized "raw" in BIDS format (output of heudiconv)
  - `stimuli`: psychopy scripts and matlab scripts for delivering stimuli and organizing output


## Downloading Data and Running Preprocessing
```
# get data via datalad (TO DO)
git clone https://github.com/DVS-Lab/istart-data
cd istart-data
datalad clone https://github.com/OpenNeuroDatasets/XXXXXX.git bids
# the bids folder is a datalad dataset
# you can get all of the data with the command below:
datalad get sub-*

# run preprocessing and generate confounds and timing files for analyses
bash code/run_fmriprep.sh
python code/MakeConfounds.py --fmriprepDir="derivatives/fmriprep"
bash code/run_gen3colfiles.sh

```


## Acknowledgments
This work was supported, in part, by grants from the National Institutes of Health (R03-DA046733 to DVS. DVS was a Research Fellow of the Public Policy Lab at Temple University during the preparation of the manuscript (2019-2020 academic year).

[openneuro]: https://openneuro.org/
