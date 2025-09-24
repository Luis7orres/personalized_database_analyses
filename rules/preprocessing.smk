# 1. PORECHOP DEMULTIPLEXING AND ADAPTER TRIMMING

rule porechop:
    input:
        fastqs = os.path.join(INPUT, "{sample}.fastq")
    output:
        porechopped = os.path.join(INPUT, "1_PORECHOP", "{sample}_porechop.fastq")
    params:
        barcode_threshold = BARCODE_THRESHOLD
    log:
        os.path.join(LOGS, "1_Porechop.log")
    script:
        "bash {SCRIPTS}/1_porechop.sh {input.fastqs} {output.porechopped} {params.barcode_threshold} 2>&1 | tee {log}"