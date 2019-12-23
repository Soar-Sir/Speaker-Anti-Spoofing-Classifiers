#!/usr/bin/env bash

datadir=${1:-"../ASVspoof2015/"}
if [[ ! -d $datadir && ! -L $data ]]; then
    #statements
    echo """Input dir ${datadir} does not exist. 
    Please set another dir, where the ASVspoof2015 dataset is located or:
    Run ./download_asv15.sh in this directory"""
    exit
fi
outputdir=${2-"filelists/asv15"}
mkdir -p $outputdir
echo "Putting filelists to $outputdir"

wavedir=$(readlink -e ${datadir}/wav) # Full path to waves
for protocol in train dev eval;
do 
    labelfile=$(find CM_protocol/ -name "*${protocol}*");
    cat $labelfile | awk -v base=${wavedir} 'BEGIN{print "filename","speaker","latype","bintype"}{print base"/"$1"/"$2, $1,$3,$4}' > labels/${protocol}".tsv"
    echo "Generated labels/${protocol}.tsv"
done
