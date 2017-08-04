#!/bin/bash

GENOME=</path/to/directory/of/genome/assembly/>
reads_dir=</path/to/directory/of/fastq/symlinks>
barcodes=</path/to/barcodes/file>
rRNA=</path/to/rRNA_file/Dmel_rRNA.fasta>
nProc=4
outputDir=</path/to/output/directory>

echo "GoRAMPAGE job starting"

GoRAMPAGE -r $reads_dir -b $barcodes -R $rRNA -g $GENOME -p $nProc --outputdir $outputDir --startfromstep step3 --stopatstep step5 >& errScript

echo "GoRAMPAGE job is complete!"
