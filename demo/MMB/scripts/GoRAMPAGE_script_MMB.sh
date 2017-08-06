#!/bin/bash

bindir=<path/to/GoRAMPAGE/scripts #please fill this out before you continue
workdir=<path/to/GoRAMPAGE/demo//MMB> #please fill this out before you continue
GENOME=${workdir}/genome
outputDir=${workdir}/output
reads_dir=${outputDir}/reads/clipped
rRNA=${workdir}/additional_files/Dmel_rRNA.fasta
nProc=4

echo "GoRAMPAGE job starting"
${bindir}/GoRAMPAGE -r $reads_dir -R $rRNA -g $GENOME -p $nProc --outputdir $outputDir --startfromstep step3 --stopatstep step5 >& errScript

echo "GoRAMPAGE job is complete!"
