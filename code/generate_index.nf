/*
Pipeline input parameters
*/


params.genome = "genome.fa"
params.annotation = "genome.gff3"
params.ref_path = "$wd/data/reference"
params.outdir= "$wd/data"
log.info """\
        INDEXING GENOME WITH STAR
        ==========================
        genome      : $params.genome
        annotation  : $params.annotation
        ref_path    : $params.ref_path
        outdir      : $params.outdir
        launchDir   : $launchDir
        projectDir  : $projectDir
        workingDir  : $wd
        aligner     : STAR
        """

/*
process input variables
*/

genome_file = "${params.ref_path}/${params.genome}"
annotation_file = "${params.ref_path}/${params.annotation}"

process Index {
    cpus=8
    publishDir params.outdir, mode:"copy"
    
    input:
    path genome_file
    path annotation_file
    
    output:
    path index
    
    script:
    """
    STAR --runThreadN $task.cpus \
    --runMode genomeGenerate \
    --genomeDir index \
    --genomeFastaFiles $genome_file \
    --sjdbGTFfile $annotation_file \
    --sjdbOverhang 99
    """
}

workflow{
    Index(genome_file, annotation_file)
}
