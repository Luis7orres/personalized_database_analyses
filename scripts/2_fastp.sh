#!/bin/bash
# Establish input and ouptut routes
INPUT_TRIMMED=$1 
OUTPUT_FASTP=$2
HTML_REPORT=$7
JSON_REPORT=$8

# Establish parameters
WINDOW_SIZE=$3  
MEAN_QUAL=$4
CUT_TAIL_WINDOW_SZ=$5
MIN_LENGHT=$6

# RUN FASTP
fastp -i "$INPUT_TRIMMED" -o "$OUTPUT_FASTP" \
    -W "$WINDOW_SIZE" \
    --M "$MEAN_QUAL" \
    --cut_front \
    --cut_tail \
    --cut_tail_window_size "$CUT_TAIL_WINDOW_SZ" \
    -l "$MIN_LENGHT" \
    --disable_adapter_trimming \
    --html "$HTML_REPORT" \
    --json "$JSON_REPORT"