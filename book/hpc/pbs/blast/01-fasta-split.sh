#!/bin/bash

#PBS -l jobtype=cluster_only
#PBS -l select=1:ncpus=2:mem=4gb
#PBS -l walltime=24:00:00
#PBS -l cput=24:00:00

set -u

cd "$CWD"
source "$CONFIG"
source "common.sh"

TMP_FILES=$(mktemp)
find "$FASTA_DIR" -type f > $TMP_FILES
NUM_FILES=$(lc "$TMP_FILES")

if [[ $NUM_FILES -lt 1 ]]; then
  echo "Found no files in FASTA_DIR \"$FASTA_DIR\""
  exit 1
fi

SPLIT_DIR="$OUT_DIR/split"

if [[ ! -d "$SPLIT_DIR" ]]; then
  mkdir -p "$SPLIT_DIR"
fi

echo "Started splitting $(date)"

while read FILE; do
  /rsgrps/bhurwitz/hurwitzlab/bin/faSplit about $FILE ${MAX_FASTA_SIZE:-100000000} "$SPLIT_DIR" 
done < $TMP_FILES

rm $TMP_FILES

echo "Done splitting $(date)"
