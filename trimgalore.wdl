## This widdle workflow will perform adapter removal and 
## quality trimming on input paired-end reads using 
## trim_galore

# workflow
workflow SeqQC {
	call trimgalore
}

# task definition
task trimgalore {
	String sample_name
	File r1fastq
	File r2fastq

	command {
		trim_galore --stringency 5 --trim-n --max_n 5 --length 35 --fastqc --paired ${r1fastq} ${r2fastq} &> ${sample_name}.trimgalore.log
	}
	
	runtime {
		docker: "dukegcb/trim-galore"
		cpu: 1
		memmory: "8GB"
	}

	output {
		File outr1rpt = "${r1fastq}_trimming_report.txt" 
		File outr2rpt = "${r2fastq}_trimming_report.txt"
		File outr1fq = "${sample_name}_R1_val_1.fq.gz"
		File outr2fq = "${sample_name}_R2_val_2.fq.gz"
		File outr1zip = "${sample_name}_R1_val_1_fastqc.zip"
		File outr2zip = "${sample_name}_R2_val_2_fastqc.zip"
		File outr1html = "${sample_name}_R1_val_1_fastqc.html"
		File outr2html = "${sample_name}_R2_val_2_fastqc.html"
	}

}
