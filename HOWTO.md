# GoRAMPAGE HOWTO - examples for how to use the workflow

## Preparation

At this point, you should have completed the __GoRAMPAGE__ installation steps
documented in the [INSTALL](./INSTALL.md) document. Here we explain basic use of
__GoRAMPAGE__ with the sample test (toy) RAMPAGE data provided in the [test](../test)
directory. For research applications, please see our [publication](http://brendelgroup.org/research/publications.php),

Raborn, R.T. & Brendel, V.P. (2018)
__Using RAMPAGE to Identify and Annotate Promoters in Insect Genomes.__
In Insect Genomics: Methods and Protocols, S.J. Brown & Michael E. Pfrender (eds.),
_Methods in Molecular Biology_,
__1858__, 85-103.

For simplicity, we assume that you have installed __GoRAMPAGE__ in your home directory (~/).


## Overview
__GoRAMPAGE__ is an integrated workflow for the processing of paired-end transcription start site (TSS) profiling data.
RAMPAGE (RNA annotation and mapping of promoters for analysis of gene annotation; Batut and Gingeras, 2013) allows for
5'-mRNA ends to be identified at large-scale and with considerable specificity to identify TSSs and promoters at large scale.
Tag-based TSS profiling methods, of which the most prominent is CAGE (Cap Analysis of Gene Expression; Carninci et al., 2005.),
are limited because they do not supply the sequence of the transcript body; the TSS must be informatically associated with the downstream
gene body in all circumstances. By contrast, paired-end TSS profiling methods, including RAMPAGE as well as PEAT (Paired-end Analysis of
Transcription Start Sites; Ni et al., 2010) overcome this shortcoming by obtaining sequence from the both the 5' end and the transcript body.
While PEAT library construction requires MNase digestion and adapter ligation, RAMPAGE is ligation-free, allowing for a lower amount of starting
material. The workflow presented in __GoRAMPAGE__ was developed for analysis of RAMPAGE data, but could potentially be applied to PEAT data also.

## Input
To begin, simply type '~/GoRAMPAGE/scripts/GoRAMPAGE' on your command line, which results in the following:

```
    Usage: ~/GoRAMPAGE/scripts/GoRAMPAGE -r <rawreaddir> -b <barcodes> -R <reference> -g <genomedir> [options]

    Examples:
      ~/GoRAMPAGE/scripts/GoRAMPAGE -r rawreads -b rawreads/barcodes -R genome/rRNA.ref -g genome --runonlystep step1 >& errTEST1

    GoRAMPAGE will determine transcription start regions (TSRs) in a several-steps workflow.
    You can specify partial workflow execution by specifying "stepX" [X = 1, 2, ..., 7] as
    argument to --startfromstep, --stopatstep, or --runonlystep.

    Step 1  Demultiplexing barcoded raw reads input
    Step 2  Clipping non-native bases off reads ends
    Step 3  Removal of low quality and other unwanted reads
    Step 4  Read mapping
    Step 5  Filtering of read alignments
    Step 6  .
    Step 7  .

    To see more help, type "~/GoRAMPAGE/scripts/GoRAMPAGE -h" or "~/GoRAMPAGE/scripts/GoRAMPAGE --help".
```

The additional help is shown as:

```
    Usage: ~/GoRAMPAGE/scripts/GoRAMPAGE -r <rawreaddir> -b <barcodes> -R <reference> -g <genomedir> [options]

    Examples:
      ~/GoRAMPAGE/scripts/GoRAMPAGE -r rawreads -b rawreads/barcodes -R genome/rRNA.ref -g genome --runonlystep step1 >& errTEST1

    GoRAMPAGE will determine transcription start regions (TSRs) in a several-steps workflow.
    You can specify partial workflow execution by specifying "stepX" [X = 1, 2, ..., 7] as
    argument to --startfromstep, --stopatstep, or --runonlystep.

    Step 1  Demultiplexing barcoded raw reads input
    Step 2  Clipping non-native bases off reads ends
    Step 3  Removal of low quality and other unwanted reads
    Step 4  Read mapping
    Step 5  .
    Step 6  .
    Step 7  .

    To see more help, type "~/GoRAMPAGE/scripts/GoRAMPAGE -h" or "~/GoRAMPAGE/scripts/GoRAMPAGE --help".


      Options default to the specified values if not set.
      Details:

      1) Mandatory options:
        -r|--rawreadsdir <path>           Directory that contains the raw reads (all files ending in *.fq)
        -b|--barcodes <path>              barcodes file for use by fastq-multx
        -g|--genome <path>                Directory that contains the genome sequence files (all files ending in .*fa)
        -R|--reference <path>             Reference file genome directory for use by tagdust (one file ending in *.ref)                  
      2) GoRAMPAGE-specific options:
        -p|--numproc <#>                  Use <#> processors during execution [Default: 1]; ideally a multipe of the -k argument.
        -o|--outputdir <path>             Put output into directory <path> [Default: ./]
        -c|--configfile <path>            Configuration file [Default: ~/GoRAMPAGE/scripts/GoRAMPAGE.conf]
      3) GoRAMPAGE workflow settings; <step> below must be one of (step1, step2, ..., step7)
         --startfromstep <string>	  Starting step; previous steps must have run successfully before.
         --stopatstep <string>            Last step to execute
         --runonlystep <string>           Workflow step to execute; previous steps must have run successfully before.
      4) Else:
        -h|--help                         Show this usage information

```
__GoRAMPAGE__ requires the following be supplied to run the entire workflow:

* raw FASTQ file(s) (containing RAMPAGE or other paired-end TSS profiling sequence information; both R1 and R2 files required)
* a genome assembly (FASTA) file (containing the genome assembly that the fastq reads will be aligned against)
* a FASTA file containing rRNA sequences from the organism being studied. Each rRNA sequence should be represented by a separate fasta header line (> sequence ID).
* a barcode file (specifying the barcode sequence and identifier for each sample in the dataset)

The format of the barcode file is as follows:
```
<sample identifier> <barcode sequence>
```
An example barcode file can be found in _test/barcode_.

## Sample __GoRAMPAGE__ invocations

__GoRAMPAGE__ can be run as a single, complete workflow, comprising demultiplexing (Step 1),
adapter clipping (Step 2), rRNA/low complexity read removal (Step 3) and read alignment (Step 4).
However, each of these steps can be run separately if desired.
We provide some examples below using the data provided in the test/ directory.

To run the entire workflow from beginning to end, use the following command:
```
cd test/
../scripts/GoRAMPAGE -r rawreads/ -b barcodes -R rRNA_sequence.fasta -g genome >& errTestAll
```
which takes the files in __rawreads/__ as input, demultiplexes them according to the contents of __barcodes__, performs hard-clipping (i.e. removal) on the demultiplexed reads, removes rRNA and low-complexity sequences within the demultiplexed sequences, and the aligns the reads to the genome assembly in __genome/__ using STAR.
(Alternatively, execute __./xruntest__ in the test directory.)


## Steps in the workflow
A useful approach to learn what the __GoRAMPAGE__ workflow entails is to run an example in
stepwise fashion.  Just add the option __--runonlystep step1__ to your favorite
example.  That will stop the workflow after the first step (summarized below).
Look at the program logfiles and output, follow up on the program documentation,
and take a mental snapshot of what this step accomplished.  Then replace
__--runonlystep step1__ by __--runonlystep step2__ and continue in similar fashion
until the final step.

##### Step 1: Demultiplexing the raw fastq files according to their adapter sequence.

##### Step 2: Clipping the adapters from the demultiplexed reads (both R1 and R2).

##### Step 3: Removal of rRNA and low complexity sequences (tagDust) from demultiplexed fastq files

##### Step 4: Alignment of demultiplexed, trimmed, rRNA-removed fastq files to the genome.

##### Step 5: Filtering of RAMPAGE alignment files for subsequent identification of promoters (e.g. using TSRchitect)
