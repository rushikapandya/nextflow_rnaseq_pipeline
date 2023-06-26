#!/bin/sh

# Take all files in folder and map to ref genome using STAR
# # Run ./gen_genomeIndex.sh path/to/index /path/to/fastq /path/to/output_dir /path/to/acc_id._samples.txt paired(single)

PAIRED=0
usage() {
    echo "Usage: ./STAR_mapping.sh [-i path/to/index_dir] [-f path/to/fastq] [-o path/to/output_dir] [-a path/to/acc_id_samples.txt] [-p]"

}

exit_abnormal() {
    usage
    exit 1
}
no_args="true"
while getopts "i:f:o:a:p" options; 
do
    case "${options}" in
        i)
            INDEX_DIR=${OPTARG}
            ;;
        f)
            RAW_DATA_DIR=${OPTARG}
            ;;
        o)
            OUT_DIR=${OPTARG}
            ;;
        a)
            SAMPLES=${OPTARG}
            ;;
        p)
            PAIRED=1
            echo "Paired ended data"
            ;;
        :) #If expected argument omitted:
            echo "Error: -${OPTARG} requires an argument"
            exit_abnormal
            ;;
        *)
            exit_abnormal
            ;;
    esac
    no_args="false"
done

[[ ${no_args} == "true" ]] && { usage; exit 1; }


#STAR --genomeLoad LoadAndExit --genomeDir ${INDEX_DIR}
# if ${PAIRED} == 1 #Paired ended
#     while read id; 
#     do
#         echo "Starting Mapping with STAR: ${id}"
#         STAR --genomeDir ${INDEX_DIR} \
#         --readFilesIn ${RAW_DATA_DIR}/${id}\_R1.fq.gz ${RAW_DATA_DIR}/${id}\_R2.fq.gz\
#         --runThreadN 16 --outFileNamePrefix ${OUT_DIR}/${id}/${id} \
#         --outSAMtype BAM SortedByCoordinate \
#         --quantMode GeneCounts \
#         --sjdbGTFfile ${INDEX_DIR}/Homo_sapiens.GRCh38.109.gtf \
#         --readFilesCommand zcat
#         echo "Mapping complete for ${id}"
#     done <$SAMPLES
# else #single-ended
#     while read id; 
#     do
#         echo "Starting Mapping with STAR: ${id}"
#         STAR --genomeDir ${INDEX_DIR} --genomeLoad LoadAndKeep \
#         --readFilesIn ${RAW_DATA_DIR}/${id}\_R1.fq.gz \
#         --runThreadN 16 --outFileNamePrefix ${OUT_DIR}/${id}/${id} \
#         --outSAMtype BAM SortedByCoordinate \
#         --quantMode GeneCounts \
#         --sjdbGTFfile ${INDEX_DIR}/Homo_sapiens.GRCh38.109.gtf \
#         --readFilesCommand zcat
#         echo "Mapping complete for ${id}"
#     done <$SAMPLES
# fi

#STAR --genomeLoad Remove --genomeDir ${INDEX_DIR}

