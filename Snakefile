#############################################
## SNAKEFILE PIPELINE PERSONALIZED DATABASE #
#############################################

import os
import glob

## Load configfile
configfile = "configfile.yaml"

## Define folders
INPUT = config["general"]["input"]
OUTPUT = config["general"]["output"]
RESULTS = config["general"]["results"]
LOGS = config["general"]["scripts"]

## Define parameters
# Porechop demultiplex and adapter trimming
BARCODE_THRESHOLD = ["parameters"]["barcode_threshold"]

# FASTP QUALITY FILTERING
FASTP_WINDOW_SIZE = ["parameters"]["window_size"]
FASTP_CUT_TAIL_WINDOW_SZ = ["parameters"]["tail_window_sz"]
FASTP_CUT_TAIL_MEAN_QUALITY = ["parameters"]["tail_mean_quality"]
MIN_LENGHT = ["parameters"]["min_lenght"]


# ...


# DEFINE SAMPLES
SAMPLE = [os.path.basename(fastq).replace(".fastq", "") for fastq in glob.glob(os.path.join(INPUT, "*.fastq"))]

# Expected final output

rule all:
    input:
        # Preprocessing outputs
        export(os.path.join(OUTPUT, "1.porechop_demultiplex_adapter_trim", "{sample}_porechop.fastq"), sample = SAMPLES)
        

# PREPROCESSING CHUNK
include: "rules/preprocessing.smk"
