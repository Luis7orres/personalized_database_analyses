## PREPROCESSING RULES
# 1. PORECHOP DEMULTIPLEXING AND ADAPTER TRIMMING
rule porechop:
    input:
        fastqs = os.path.join(INPUT, "{sample}.fastq")
    output:
        porechopped = os.path.join(OUTPUT, "1_porechop", "{sample}_porechop.fastq")
    params:
        barcode_threshold = BARCODE_THRESHOLD
    log:
        os.path.join(LOGS, "1_porechop", "porechop_{sample}.log")
    shell:
        "bash {SCRIPTS}/1_porechop.sh {input.fastqs} {output.porechopped} {params.barcode_threshold} 2>&1 | tee {log}"

# 2. QUALITY CONTROL 
rule qc_fastp:
    input:
        chopped = os.path.join(OUTPUT, "1_porechop", "{sample}_porechop.fastq")
    output:
        qc_filtered = os.path.join(OUTPUT, "2_fastp", "{sample}_filtered.fastq")  
    params:
        ws = FASTP_WINDOW_SIZE,
        mean_qual = MEAN_QUALITY,
        ct_ws = FASTP_CUT_TAIL_WINDOW_SZ,
        min_len = MIN_LENGHT,
        qc_html = os.path.join(OUTPUT, "2_fastp", "reports", "{sample}_fastp_report.html"),
        qc_json = os.path.join(OUTPUT, "2_fastp", "reports", "{sample}_fastp_report.json")
    log:
        os.path.join(LOGS,"2_fastp", "{sample}_filtered.log")
    shell:
        """
        bash {SCRIPTS}/2_fastp.sh {input.chopped} {output.qc_filtered} {params.ws} {params.mean_qual} {params.ct_ws} \
        {params.min_len} {params.qc_html} {params.qc_json} 2>&1 | tee {log}
        """

# 3. DEQUIMERIZATION 

