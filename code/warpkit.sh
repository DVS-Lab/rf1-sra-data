#!/bash/bin


# ensure paths are correct irrespective from where user runs the script
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
maindir="$(dirname "$scriptdir")"

sub=$1
task=$2
run=$3

outdir=$maindir/derivatives/warpkit/sub-${sub}
if [ ! -d $outdir ]; then
	mkdir -p $outdir
fi

indir=${maindir}/bids/sub-${sub}/func

singularity run --cleanenv \
-B $maindir:/base \
-B $outdir:/out \
/ZPOOL/data/tools/warpkit.sif \
--magnitude /base/sub-${sub}_task-${task}_run-${run}_echo-1_part-mag_bold.nii.gz \
			/base/sub-${sub}_task-${task}_run-${run}_echo-2_part-mag_bold.nii.gz \
			/base/sub-${sub}_task-${task}_run-${run}_echo-3_part-mag_bold.nii.gz \
			/base/sub-${sub}_task-${task}_run-${run}_echo-4_part-mag_bold.nii.gz \
--phase /base/sub-${sub}_task-${task}_run-${run}_echo-1_part-phase_bold.nii.gz \
		/base/sub-${sub}_task-${task}_run-${run}_echo-2_part-phase_bold.nii.gz \
		/base/sub-${sub}_task-${task}_run-${run}_echo-3_part-phase_bold.nii.gz \
		/base/sub-${sub}_task-${task}_run-${run}_echo-4_part-phase_bold.nii.gz \
--metadata /base/sub-${sub}_task-${task}_run-${run}_echo-1_part-phase_bold.json \
			/base/sub-${sub}_task-${task}_run-${run}_echo-2_part-phase_bold.json \
			/base/sub-${sub}_task-${task}_run-${run}_echo-3_part-phase_bold.json \
			/base/sub-${sub}_task-${task}_run-${run}_echo-4_part-phase_bold.json \
--out_prefix /out/sub-${sub}_task-${task}_run-${run}_

