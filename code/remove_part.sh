for file in `ls -1 ${bidsdir}/sub-*/func/sub-*_part-mag_sbref.*`; do
 	mv "${file}" "${file/_part-mag/}"
done
