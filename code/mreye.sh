#!/bin/bash



# ensure paths are correct irrespective from where user runs the script
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
maindir="$(dirname "$scriptdir")"

# make derivatives folder if it doesn't exist.
# let's keep this out of bids for now
if [ ! -d $maindir/derivatives/mreye_echo-2 ]; then
	mkdir -p $maindir/derivatives/mreye_echo-2
fi


# participant-level analyses
singularity run --cleanenv \
-B $maindir:/base \
/ZPOOL/data/tools/bidsmreye-0.3.1.sif \
--action all \
/base/derivatives/fmriprep-fake_echo-2 \
/base/derivatives/mreye_echo-2 \
participant \
--space MNI152NLin6Asym

# group-level qc
#singularity run --cleanenv \
#-B $maindir:/base \
#/ZPOOL/data/tools/bidsmreye-0.3.1.sif \
#--action qc \
#/base/derivatives/fmriprep-fake_echo-2 \
#/base/derivatives/mreye_echo-2 \
#group
