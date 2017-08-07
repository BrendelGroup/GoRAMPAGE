#!/bin/bash

GoRAMPAGEhome=<enter full path to GoRAMPAGE directory> ## please change before proceeding
workdir=<enter full to your work directory> ## please change before proceeding
nProc=4 ## please set the number of processors to be used here

bindir=${GoRAMPAGEhome}/scripts
outputDir=${workdir}/output
reads_dir=${outputDir}/reads/clipped
rRNA=${GoRAMPAGEhome}/demo/MMB/additional_files/Dmel_rRNA.fasta
GENOME=${workdir}/genome


echo "GoRAMPAGE job starting"
echo " ... you can monitor progress in a separate window with 'tail -f err'"
echo ""
${bindir}/GoRAMPAGE -r $reads_dir -R $rRNA -g $GENOME -p $nProc --outputdir $outputDir --startfromstep step3 --stopatstep step5 >& err
