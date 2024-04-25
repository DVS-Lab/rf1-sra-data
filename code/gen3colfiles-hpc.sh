#!/usr/bin/env bash

# this script will convert your BIDS *events.tsv files into the 3-col format for FSL
# it relies on Tom Nichols' converter, which we store locally under /data/tools
# https://github.com/bids-standard/bidsutils

# To do:
# 0) currently only works for sharedreward following srndna-data model
# 1) make general for all tasks? not sure that is preferred since task leaders need to be responsible for their tasks
# 2) add parametric modulators?
# 3) log missing inputs?
# 4) zero padding for run number. fix at heudiconv conversion


scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
maindir="$(dirname "$scriptdir")"
baseout=/home/tun31934/work/rf1-sra-data/derivatives/fsl/EVfiles
if [ ! -d ${baseout} ]; then
  mkdir -p $baseout
fi

sub=$1

for task in doors socialdoors trust sharedreward ugr; do
	for stimuli in Social_Doors Card_Guessing_Game Investment_Game Lets_Make_A_Deal; do
		for run in 1 2; do
  				input=/ZPOOL/data/projects/rf1-sra/stimuli/Scan-${stimuli}/data/${sub}/sub-${sub}_task-${task}_run-${run}_events.tsv
  				output=${baseout}/sub-${sub}/${task}
				mkdir -p $output
  				if [ -e $input ]; then
    				bash ${scriptdir}/BIDSto3col.sh $input ${output}/
  				else
    			echo "PATH ERROR: cannot locate ${input}."
    			continue
  				fi
		done
	done
done