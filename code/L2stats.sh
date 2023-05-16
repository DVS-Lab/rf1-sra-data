#!/bin/bash

# ensure paths are correct irrespective from where user runs the script
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
maindir="$(dirname "$scriptdir")"

# setting inputs and common variables
sub=$1
type=$2
model=$3
task=sharedreward # edit if necessary
sm=4 # edit if necessary
MAINOUTPUT=${maindir}/derivatives/fsl/sub-${sub}


# --- start EDIT HERE start: exceptions and conditionals for the task
NCOPES=16

# ppi has more contrasts than act (phys), so need a different L2 template
if [ "${type}" == "act" ]; then
	if [ ${sub} -eq 10303 ]; then
		ITEMPLATE=${maindir}/templates/L2_task-${task}_model-${model}_type-act_10303.fsf
	elif [ ${sub} -eq 10185 ]; then
		ITEMPLATE=${maindir}/templates/L2_task-${task}_model-${model}_type-act_10185.fsf
	elif [ ${sub} -eq 10198 ]; then
		ITEMPLATE=${maindir}/templates/L2_task-${task}_model-${model}_type-act_10198.fsf
	else
		ITEMPLATE=${maindir}/templates/L2_task-${task}_model-${model}_type-act.fsf
	fi	
	NCOPES=${NCOPES}
else
	ITEMPLATE=${maindir}/templates/L2_task-${task}_type-ppi.fsf
	let NCOPES=${NCOPES}+1 # add 1 since we tend to only have one extra contrast for PPI
fi
INPUT1=${MAINOUTPUT}/L1_task-${task}_model-${model}_type-${type}_acq-mb1me1_sm-${sm}_denoising-none_aroma.feat
INPUT2=${MAINOUTPUT}/L1_task-${task}_model-${model}_type-${type}_acq-mb1me4_sm-${sm}_denoising-none_aroma.feat
INPUT3=${MAINOUTPUT}/L1_task-${task}_model-${model}_type-${type}_acq-mb3me1_sm-${sm}_denoising-none_aroma.feat
INPUT4=${MAINOUTPUT}/L1_task-${task}_model-${model}_type-${type}_acq-mb3me4_sm-${sm}_denoising-none_aroma.feat
INPUT5=${MAINOUTPUT}/L1_task-${task}_model-${model}_type-${type}_acq-mb6me1_sm-${sm}_denoising-none_aroma.feat
INPUT6=${MAINOUTPUT}/L1_task-${task}_model-${model}_type-${type}_acq-mb6me4_sm-${sm}_denoising-none_aroma.feat

# --- end EDIT HERE end: exceptions and conditionals for the task; need to exclude bad/missing runs


# check for existing output and re-do if missing/incomplete
OUTPUT=${MAINOUTPUT}/L2_task-${task}_model-${model}_type-${type}_sm-${sm}_aroma
if [ -e ${OUTPUT}.gfeat/cope${NCOPES}.feat/cluster_mask_zstat1.nii.gz ]; then # check last (act) or penultimate (ppi) cope
	echo "skipping existing output"
else
	echo "re-doing: ${OUTPUT}" >> re-runL2.log
	rm -rf ${OUTPUT}.gfeat


	# set output template and run template-specific analyses
	#for sub-10303, run mb3me4 not collected
	if [ ${sub} -eq 10303 ]; then
		OTEMPLATE=${MAINOUTPUT}/L2_task-${task}_model-${model}_type-${type}_denoising-none_aroma.fsf
		sed -e 's@OUTPUT@'$OUTPUT'@g' \
		-e 's@INPUT1@'$INPUT1'@g' \
		-e 's@INPUT2@'$INPUT2'@g' \
		-e 's@INPUT3@'$INPUT3'@g' \
		-e 's@INPUT5@'$INPUT5'@g' \
		-e 's@INPUT6@'$INPUT6'@g' \
		<$ITEMPLATE> $OTEMPLATE
		feat $OTEMPLATE
	#for sub-10185, run mb6me4 had no left button responses
	elif [ ${sub} -eq 10185 ]; then
		OTEMPLATE=${MAINOUTPUT}/L2_task-${task}_model-${model}_type-${type}_denoising-none_aroma.fsf
		sed -e 's@OUTPUT@'$OUTPUT'@g' \
		-e 's@INPUT1@'$INPUT1'@g' \
		-e 's@INPUT2@'$INPUT2'@g' \
		-e 's@INPUT3@'$INPUT3'@g' \
		-e 's@INPUT4@'$INPUT4'@g' \
		-e 's@INPUT5@'$INPUT5'@g' \
		<$ITEMPLATE> $OTEMPLATE
		feat $OTEMPLATE
	#for sub-10198, run mb1me1 not collected
	elif [ ${sub} -eq 10198 ]; then
		OTEMPLATE=${MAINOUTPUT}/L2_task-${task}_model-${model}_type-${type}_denoising-none_aroma.fsf
		sed -e 's@OUTPUT@'$OUTPUT'@g' \
		-e 's@INPUT2@'$INPUT2'@g' \
		-e 's@INPUT3@'$INPUT3'@g' \
		-e 's@INPUT4@'$INPUT4'@g' \
		-e 's@INPUT5@'$INPUT5'@g' \
		-e 's@INPUT6@'$INPUT6'@g' \
		<$ITEMPLATE> $OTEMPLATE
		feat $OTEMPLATE
	else
		OTEMPLATE=${MAINOUTPUT}/L2_task-${task}_model-${model}_type-${type}_denoising-none_aroma.fsf
		sed -e 's@OUTPUT@'$OUTPUT'@g' \
		-e 's@INPUT1@'$INPUT1'@g' \
		-e 's@INPUT2@'$INPUT2'@g' \
		-e 's@INPUT3@'$INPUT3'@g' \
		-e 's@INPUT4@'$INPUT4'@g' \
		-e 's@INPUT5@'$INPUT5'@g' \
		-e 's@INPUT6@'$INPUT6'@g' \
		<$ITEMPLATE> $OTEMPLATE
		feat $OTEMPLATE
	fi
	# delete unused files
	for cope in `seq ${NCOPES}`; do
		rm -rf ${OUTPUT}.gfeat/cope${cope}.feat/stats/res4d.nii.gz
		rm -rf ${OUTPUT}.gfeat/cope${cope}.feat/stats/corrections.nii.gz
		rm -rf ${OUTPUT}.gfeat/cope${cope}.feat/stats/threshac1.nii.gz
		rm -rf ${OUTPUT}.gfeat/cope${cope}.feat/filtered_func_data.nii.gz
		rm -rf ${OUTPUT}.gfeat/cope${cope}.feat/var_filtered_func_data.nii.gz
	done

fi
