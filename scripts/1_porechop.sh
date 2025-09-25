
#!/bin/bash
# === LOAD MODULES ===
module load cesga/2020 porechop/0.2.4

# === FOLDERS AND DIRECTORIES ===
INPUT_FASTQ=$1
OUTPUT_DIR=$2
BARCODE_THRESHOLD=$3

mkdir -p "$OUTPUT_DIR"


# --- LOGGING FUNCTION ---
log_message() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1"
}

# === PORECHOP DEMULTIPLEXING AND ADAPTER TRIMMING===

log_message "Starting demultiplex with Porechop."
log_message "INPUT directory: $INPUT_FASTQ"
log_message "OUTPUT directory: $OUTPUT_DIR"
log_message "------------------------------------------------------------"

# RUN PORECHOP

porechop \
    -i "$INPUT_FASTQ" \
    -b "$OUTPUT_DIR" \
    --format fastq \
    --verbosity 1 \
    --check_reads 10000 \
    --barcode_threshold 75 \
    --threads 30

log_message "------------------------------------------------------------"
log_message "DONE."

