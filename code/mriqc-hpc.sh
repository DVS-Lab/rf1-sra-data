#/usr/bin/env bash
#!/bin/bash
#PBS -l walltime=2:00:00
#PBS -N mriqc-test
#PBS -q normal
#PBS -l nodes=1:ppn=28

# load modules and go to workdir
module load fsl/6.0.2
source $FSLDIR/etc/fslconf/fsl.sh
module load singularity
cd $PBS_O_WORKDIR

# ensure paths are correct irrespective from where user runs the script
dsroot=/gpfs/scratch/tug87422/smithlab-shared/rf1-sra-data
codedir=$dsroot/code
logdir=$dsroot/logs
mkdir -p $logdir

#subjects=("${!1}")

rm -f $logdir/cmd_mriqc_${PBS_JOBID}.txt
touch $logdir/cmd_mriqc_${PBS_JOBID}.txt

# Delete old output files
rm -f $codedir/mriqc-test.o*
rm -f $codedir/mriqc-test.e*

## Run MRIQC on subject
# To-do: run through datalad with YODA principles

## make derivatives folder if it doesn't exist.
## let's keep this out of bids for now

if [ ! -d $dsroot/derivatives/mriqc ]; then
        mkdir -p $dsroot/derivatives/mriqc
fi

# make scratch
scratch=/gpfs/scratch/tug87422/smithlab-shared/rf1-sra-data/scratch
if [ ! -d $scratch ]; then
	mkdir -p $scratch
fi

TEMPLATEFLOW_DIR=~/work/tools/templateflow
MPLCONFIGDIR_DIR=~/work/mplconfigdir
export SINGULARITYENV_TEMPLATEFLOW_HOME=/opt/templateflow
export SINGULARITYENV_MPLCONFIGDIR=/opt/mplconfigdir

# no space left on device error for v0.15.2 and higher
# https://neurostars.org/t/mriqc-no-space-left-on-device-error/16187/1
# https://github.com/poldracklab/mriqc/issues/850

for sub in ${subjects[@]}; do
        echo singularity run --cleanenv \
        -B ${TEMPLATEFLOW_DIR}:/opt/templateflow \
        -B $dsroot/bids:/data \
        -B $dsroot/derivatives/mriqc:/out \
        -B $scratch:/scratch \
        /home/tun31934/work/tools/mriqc-24.0.2.simg \
        /data /out \
        participant --participant_label $sub \
	--no-datalad-get \
	--no-sub \
	--modalities bold \
        -w /scratch >> $logdir/cmd_mriqc_${PBS_JOBID}.txt
done

torque-launch -p $logdir/chk_mriqc_${PBS_JOBID}.txt $logdir/cmd_mriqc_${PBS_JOBID}.txt

--bids-filter-file $codedir/fmriprep_config.json
