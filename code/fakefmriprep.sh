#!/bash/bin


# ensure paths are correct irrespective from where user runs the script
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
maindir="$(dirname "$scriptdir")"

sub=$1
task=$2
run=$3

indir=$maindir/derivatives/fmriprep/sub-${sub}
outdir=$maindir/derivatives/fmriprep-fake_echo-2/sub-${sub}/func
if [ ! -d $outdir ]; then
	mkdir -p $outdir
fi


if [ -e ${indir}/func/sub-${sub}_task-${task}_run-${run}_echo-2_part-mag_desc-preproc_bold.nii.gz ]; then

	# split into 3d vols
	fslsplit ${indir}/func/sub-${sub}_task-${task}_run-${run}_echo-2_part-mag_desc-preproc_bold.nii.gz \
	${indir}/func/sub-${sub}_task-${task}_run-${run}_vol -t
	NVOLS=`fslnvols ${indir}/func/sub-${sub}_task-${task}_run-${run}_echo-2_part-mag_desc-preproc_bold.nii.gz`
	vol=1
	for vol in `seq ${NVOLS}`; do
		let vol=$vol-1
		vol_pad=`zeropad ${vol} 4`
		
		# Apply transformation using antsApplyTransforms
		 antsApplyTransforms \
		 --dimensionality 3 \
		 --input ${indir}/func/sub-${sub}_task-${task}_run-${run}_vol${vol_pad}.nii.gz \
		 --reference-image ${indir}/func/sub-${sub}_task-${task}_run-${run}_part-mag_space-MNI152NLin6Asym_boldref.nii.gz \
		 --transform ${indir}/anat/sub-${sub}_from-T1w_to-MNI152NLin6Asym_mode-image_xfm.h5 \
		 --transform [${indir}/func/sub-${sub}_task-${task}_run-${run}_from-boldref_to-T1w_mode-image_desc-coreg_xfm.txt,0] \
		 --interpolation LanczosWindowedSinc \
		 --output ${outdir}/sub-${sub}_task-${task}_run-${run}_space-MNI152NLin6Asym_desc-preproc_bold_vol${vol_pad}.nii.gz \
		 # --verbose 1
		 
	 done
	 
	 # merge volumes
	 fslmerge -tr ${outdir}/sub-${sub}_task-${task}_run-${run}_space-MNI152NLin6Asym_desc-preproc_bold \
	 ${outdir}/sub-${sub}_task-${task}_run-${run}_space-MNI152NLin6Asym_desc-preproc_bold_vol*.nii.gz 1.615
	 
	 # clean up
	 rm -rf ${indir}/func/sub-${sub}_task-${task}_run-${run}_vol*.nii.gz
	 rm -rf ${outdir}/sub-${sub}_task-${task}_run-${run}_space-MNI152NLin6Asym_desc-preproc_bold_vol*.nii.gz
	 
else
	 echo "no data: sub-${sub}_task-${task}_run-${run}"
fi
 