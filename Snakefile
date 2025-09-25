#############################################
## SNAKEFILE PIPELINE PERSONALIZED DATABASE #
#############################################

import os
import glob
import snakemake.io

## Load configfile
configfile: "/mnt/lustre/scratch/nlsas/home/uvi/bg/sbg/PERS_DATABASE_SM/config.yaml"

## Define folders
INPUT = config["general"]["input"]
OUTPUT = config["general"]["output"]
RESULTS = config["general"]["results"]
SCRIPTS= config["general"]["scripts"]
LOGS = config["general"]["logs"]

## Define parameters
# Porechop demultiplex and adapter trimming
BARCODE_THRESHOLD = config["parameters"]["barcode_threshold"]

# FASTP QUALITY FILTERING
FASTP_WINDOW_SIZE = config["parameters"]["window_size"]
MEAN_QUALITY = config["parameters"]["mean_quality"]
FASTP_CUT_TAIL_WINDOW_SZ = config["parameters"]["tail_window_sz"]
FASTP_CUT_TAIL_MEAN_QUALITY = config["parameters"]["tail_mean_quality"]
MIN_LENGHT = config["parameters"]["min_lenght"]


# ...


# DEFINE SAMPLES
SAMPLES = [os.path.basename(fastq).replace(".fastq", "") for fastq in glob.glob(os.path.join(INPUT, "*.fastq"))]

# Expected final output

rule all:
    input:
        # Preprocessing outputs
        expand(os.path.join(OUTPUT, "1_porechop", "{sample}_porechop.fastq"), sample = SAMPLES),
        expand(os.path.join(OUTPUT, "2_fastp", "{sample}_filtered.fastq"), sample = SAMPLES)

# PREPROCESSING CHUNK
include: "rules/preprocessing.smk"
