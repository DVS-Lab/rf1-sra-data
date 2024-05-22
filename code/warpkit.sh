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

indir=${maindir}/fmap_test/sub-${sub}/func

if [ ! -e $indir/sub-${sub}_task-${task}_run-${run}_echo-1_part-mag_bold.json ]; then
	echo "NO DATA: sub-${sub}_task-${task}_run-${run}_echo-1_part-mag_bold.json"
	echo "NO DATA: sub-${sub}_task-${task}_run-${run}_echo-1_part-mag_bold.json" >> $scriptdir/missingFiles-warpkit.log
	exit
fi

# don't re-do existing output
if [ -e $maindir/fmap_test/sub-${sub}/fmap/sub-${sub}_run-${run}_fieldmap.json ]; then
	echo "EXISTS (skipping): sub-${sub}/fmap/sub-${sub}_run-${run}_fieldmap.json"
	exit
fi


singularity run --cleanenv \
-B $indir:/base \
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
--out_prefix /out/sub-${sub}_task-${task}_run-${run}


# extract first volume as fieldmap and copy to fmap dir. still need json files for these. 
fslroi $outdir/sub-${sub}_task-${task}_run-${run}_fieldmaps.nii $maindir/fmap_test/sub-${sub}/fmap/sub-${sub}_acq-${task}_run-${run}_fieldmap 0 1
fslroi $indir/sub-${sub}_task-${task}_run-${run}_echo-1_part-mag_bold.nii.gz $maindir/fmap_test/sub-${sub}/fmap/sub-${sub}_acq-${task}_run-${run}_magnitude 0 1

# placeholders for json files. will need editing.
cp $indir/sub-${sub}_task-${task}_run-${run}_echo-1_part-mag_bold.json $maindir/fmap_test/sub-${sub}/fmap/sub-${sub}_acq-${task}_run-${run}_magnitude.json
cp $indir/sub-${sub}_task-${task}_run-${run}_echo-1_part-phase_bold.json $maindir/fmap_test/sub-${sub}/fmap/sub-${sub}_acq-${task}_run-${run}_fieldmap.json

# trash the rest
rm -rf $outdir/sub-${sub}_task-${task}_run-${run}_displacementmaps.nii
rm -rf $outdir/sub-${sub}_task-${task}_run-${run}_fieldmaps_native.nii

