####################################################################################################

ptm <- proc.time()

# ... loading the TSRchitect library:
library(TSRchitect)

### NOTE: You will need to replace WORKDIR and GoRAMPAGEhome in the following two lines by the
###       appropriate paths on your system to make this script work.
###
BAMDIR  <- c("WORKDIR/output/alignments")
DmAnnot <- c("GoRAMPAGEhome/demo/MMB/additional_files/Drosophila_melanogaster.BDGP5.78.gff")

# ... initializing the tssObj object:
DmRAMPAGE <- loadTSSobj(experimentTitle="RAMPAGE Tutorial", inputDir=BAMDIR, isPairedBAM=TRUE, isPairedBED=FALSE, sampleNames=c("E1h","E2h", "E3h", "L1", "L2", "L3"), replicateIDs=c(1,1,1,2,2,2))

# ... converting BAM data into TSS information and attaching it to the tssObj object:
DmRAMPAGE <- inputToTSS(DmRAMPAGE)

# ... constructing the tag count per TSS data matrices:
DmRAMPAGE <- processTSS(experimentName=DmRAMPAGE, n.cores=1, tssSet="1", writeTable=TRUE)
DmRAMPAGE <- processTSS(experimentName=DmRAMPAGE, n.cores=1, tssSet="2", writeTable=TRUE)
DmRAMPAGE <- processTSS(experimentName=DmRAMPAGE, n.cores=1, tssSet="3", writeTable=TRUE)
DmRAMPAGE <- processTSS(experimentName=DmRAMPAGE, n.cores=1, tssSet="4", writeTable=TRUE)
DmRAMPAGE <- processTSS(experimentName=DmRAMPAGE, n.cores=1, tssSet="5", writeTable=TRUE)
DmRAMPAGE <- processTSS(experimentName=DmRAMPAGE, n.cores=1, tssSet="6", writeTable=TRUE)

# ... identifying TSRs (promoters):
DmRAMPAGE <- determineTSR(experimentName=DmRAMPAGE, n.cores=1, tsrSetType="replicates", tssSet="1", tagCountThreshold=25, clustDist=20, writeTable=TRUE)
DmRAMPAGE <- determineTSR(experimentName=DmRAMPAGE, n.cores=1, tsrSetType="replicates", tssSet="2", tagCountThreshold=25, clustDist=20, writeTable=TRUE)
DmRAMPAGE <- determineTSR(experimentName=DmRAMPAGE, n.cores=1, tsrSetType="replicates", tssSet="3", tagCountThreshold=25, clustDist=20, writeTable=TRUE)
DmRAMPAGE <- determineTSR(experimentName=DmRAMPAGE, n.cores=1, tsrSetType="replicates", tssSet="4", tagCountThreshold=25, clustDist=20, writeTable=TRUE)
DmRAMPAGE <- determineTSR(experimentName=DmRAMPAGE, n.cores=1, tsrSetType="replicates", tssSet="5", tagCountThreshold=25, clustDist=20, writeTable=TRUE)
DmRAMPAGE <- determineTSR(experimentName=DmRAMPAGE, n.cores=1, tsrSetType="replicates", tssSet="6", tagCountThreshold=25, clustDist=20, writeTable=TRUE)

# ... now adding tag count output:
#
DmRAMPAGE <- addTagCountsToTSR(experimentName=DmRAMPAGE, tsrSetType="replicates", tsrSet=1, tagCountThreshold=10, writeTable=TRUE)
DmRAMPAGE <- addTagCountsToTSR(experimentName=DmRAMPAGE, tsrSetType="replicates", tsrSet=2, tagCountThreshold=10, writeTable=TRUE)
DmRAMPAGE <- addTagCountsToTSR(experimentName=DmRAMPAGE, tsrSetType="replicates", tsrSet=3, tagCountThreshold=10, writeTable=TRUE)
DmRAMPAGE <- addTagCountsToTSR(experimentName=DmRAMPAGE, tsrSetType="replicates", tsrSet=4, tagCountThreshold=10, writeTable=TRUE)
DmRAMPAGE <- addTagCountsToTSR(experimentName=DmRAMPAGE, tsrSetType="replicates", tsrSet=5, tagCountThreshold=10, writeTable=TRUE)
DmRAMPAGE <- addTagCountsToTSR(experimentName=DmRAMPAGE, tsrSetType="replicates", tsrSet=6, tagCountThreshold=10, writeTable=TRUE)

# ... now adding annotation to the replicates:
#
DmRAMPAGE <- importAnnotationExternal(experimentName=DmRAMPAGE, fileType="gff3", annotFile=DmAnnot)
DmRAMPAGE <- addAnnotationToTSR(experimentName=DmRAMPAGE, tsrSetType="replicates", tsrSet=1, upstreamDist=1000, downstreamDist=200, feature="gene", featureColumnID="ID", writeTable=TRUE)
DmRAMPAGE <- addAnnotationToTSR(experimentName=DmRAMPAGE, tsrSetType="replicates", tsrSet=2, upstreamDist=1000, downstreamDist=200, feature="gene", featureColumnID="ID", writeTable=TRUE)
DmRAMPAGE <- addAnnotationToTSR(experimentName=DmRAMPAGE, tsrSetType="replicates", tsrSet=3, upstreamDist=1000, downstreamDist=200, feature="gene", featureColumnID="ID", writeTable=TRUE)
DmRAMPAGE <- addAnnotationToTSR(experimentName=DmRAMPAGE, tsrSetType="replicates", tsrSet=4, upstreamDist=1000, downstreamDist=200, feature="gene", featureColumnID="ID", writeTable=TRUE)
DmRAMPAGE <- addAnnotationToTSR(experimentName=DmRAMPAGE, tsrSetType="replicates", tsrSet=5, upstreamDist=1000, downstreamDist=200, feature="gene", featureColumnID="ID", writeTable=TRUE)
DmRAMPAGE <- addAnnotationToTSR(experimentName=DmRAMPAGE, tsrSetType="replicates", tsrSet=6, upstreamDist=1000, downstreamDist=200, feature="gene", featureColumnID="ID", writeTable=TRUE)

# ... merging the samples into embryonic and larval
#
DmRAMPAGE <- mergeSampleData(DmRAMPAGE)

# ... identifying TSRs (promoters) from the merged samples:
DmRAMPAGE <- determineTSR(experimentName=DmRAMPAGE, n.cores=1, tsrSetType="merged", tssSet="1", tagCountThreshold=40, clustDist=20, writeTable=TRUE)
DmRAMPAGE <- determineTSR(experimentName=DmRAMPAGE, n.cores=1, tsrSetType="merged", tssSet="2", tagCountThreshold=40, clustDist=20, writeTable=TRUE)
DmRAMPAGE <- determineTSR(experimentName=DmRAMPAGE, n.cores=1, tsrSetType="merged", tssSet="3", tagCountThreshold=40, clustDist=20, writeTable=TRUE)

# ... now adding annotation to the merged samples:
#
DmRAMPAGE <- addAnnotationToTSR(experimentName=DmRAMPAGE, tsrSetType="merged", tsrSet=1, upstreamDist=1000, downstreamDist=200, feature="gene", featureColumnID="ID", writeTable=TRUE)
DmRAMPAGE <- addAnnotationToTSR(experimentName=DmRAMPAGE, tsrSetType="merged", tsrSet=2, upstreamDist=1000, downstreamDist=200, feature="gene", featureColumnID="ID", writeTable=TRUE)
DmRAMPAGE <- addAnnotationToTSR(experimentName=DmRAMPAGE, tsrSetType="merged", tsrSet=3, upstreamDist=1000, downstreamDist=200, feature="gene", featureColumnID="ID", writeTable=TRUE)

proc.time() - ptm

# ... uncomment the following line if you would like to the data generated by the above
#     for future reloading with the R load command:
#save(DmRAMPAGE, file="DmRAMPAGE.RData")
