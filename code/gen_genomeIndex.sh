#!/bin/sh

# Human Reference Genome - GRCh38/Hg38: Release 109 from Ensembl
# Download date: 
# Reference genome folder contains genome fasta file and annotation (gtf) file
# Requires path to folder where you want to save index files
# Run ./gen_genomeIndex.sh path/to/reference_genome /path/to/save/index_files

# Path to Reference genome
ref_path=$1
index_path=$2

# Run STAR genome generate command
STAR --runThreadN 8 \
--runMode genomeGenerate \
--genomeDir $index_path/hg38_index \
--genomeFastaFiles $ref_path/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
--sjdbGTFfile $ref_path/Homo_sapiens.GRCh38.109.gtf \
--sjdbOverhang 99

