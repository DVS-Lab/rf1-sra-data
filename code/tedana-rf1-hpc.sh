#!/bin/bash
#PBS -l walltime=12:00:00
#PBS -N tedana-07292024
#PBS -q normal
#PBS -m ae
#PBS -M cooper.sharp@temple.edu
#PBS -l nodes=1:ppn=28
cd $PBS_O_WORKDIR

# ensure paths are correct irrespective from where user runs the script
maindir=/home/tun31934/work/rf1-sra-data
scriptdir=$maindir/code
logdir=$maindir/logs
mkdir -p $logdir

for sub in ${subjects[@]}; do
	for task in "sharedreward" "trust" "ugr" "doors" "socialdoors"; do
		for run in 0 1; do
		
			# prepare inputs and outputs; don't run if data is missing, but log missingness
			prepdir=${maindir}/derivatives/fmriprep/sub-${sub}/func
			echo1=${prepdir}/sub-${sub}_task-${task}_run-${run}_echo-1_part-mag_desc-preproc_bold.nii.gz
			echo2=${prepdir}/sub-${sub}_task-${task}_run-${run}_echo-2_part-mag_desc-preproc_bold.nii.gz
			echo3=${prepdir}/sub-${sub}_task-${task}_run-${run}_echo-3_part-mag_desc-preproc_bold.nii.gz
			echo4=${prepdir}/sub-${sub}_task-${task}_run-${run}_echo-4_part-mag_desc-preproc_bold.nii.gz
			outdir=${maindir}/derivatives/tedana/sub-${sub}
			if [ ! -e $echo1 ]; then
				echo "missing ${echo1}"
				echo "missing ${echo1}" >> $scriptdir/missing-tedanaInput.log
				exit
			fi
			mkdir -p $outdir
			
			# run tedana
			tedana -d $echo1 $echo2 $echo3 $echo4 \
			-e 0.0138 0.03154 0.04928 0.06702 \
			--out-dir $outdir \
			--prefix sub-${sub}_task-${task}_run-${run} \
			--convention bids \
			--fittype curvefit \
			--overwrite
			
			# clean up and save space
			rm -rf ${outdir}/sub-${sub}_task-${task}_run-${run}_*.nii.gz
			
		done
	done
done