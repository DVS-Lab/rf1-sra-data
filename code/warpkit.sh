#!/bash/bin


maindir=/ZPOOL/data/projects/dvs-testing/derivatives/sub-10926/func
singularity run --cleanenv \
-B $maindir:/base \
/ZPOOL/data/tools/warpkit.sif \
--magnitude /base/sub-10926_task-ugr_run-2_echo-1_part-mag_bold.nii.gz \
			/base/sub-10926_task-ugr_run-2_echo-2_part-mag_bold.nii.gz \
			/base/sub-10926_task-ugr_run-2_echo-3_part-mag_bold.nii.gz \
			/base/sub-10926_task-ugr_run-2_echo-4_part-mag_bold.nii.gz \
--phase /base/sub-10926_task-ugr_run-2_echo-1_part-phase_bold.nii.gz \
		/base/sub-10926_task-ugr_run-2_echo-2_part-phase_bold.nii.gz \
		/base/sub-10926_task-ugr_run-2_echo-3_part-phase_bold.nii.gz \
		/base/sub-10926_task-ugr_run-2_echo-4_part-phase_bold.nii.gz \
--metadata /base/sub-10926_task-ugr_run-2_echo-1_part-phase_bold.json \
			/base/sub-10926_task-ugr_run-2_echo-2_part-phase_bold.json \
			/base/sub-10926_task-ugr_run-2_echo-3_part-phase_bold.json \
			/base/sub-10926_task-ugr_run-2_echo-4_part-phase_bold.json \
--out_prefix /base/testing

