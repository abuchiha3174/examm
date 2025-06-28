#!/bin/bash -l

#SBATCH -J 10_r_
#SBATCH -A one-nas
#SBATCH -o examm_%x_%j.output
#SBATCH -e examm_%x_%j.error
#SBATCH --mail-user=as3485@g.rit.edu
#SBATCH --mail-type=ALL
#SBATCH -t 24:00:00
#SBATCH -p debug -n 36
#SBATCH --mem-per-cpu=5000

#module load module_future
#module load openmpi-1.10-x86_64

# spack load gcc/lhqcen5
# spack load cmake/pbddesj
# spack load libtiff/gnxev37
# spack load openmpi/xcunp5q

EXAMM="/home/as3485/examm"
MAX_GENOME=20000
NUM_ISLAND=10
DATASET="c172"

# Run 10 independent experiments
for folder in {0..9}
do
    # Create full directory path with SLURM job ID included
    exp_name="$EXAMM/results_debug/test/$DATASET/max_genome_${MAX_GENOME}_${SLURM_JOB_ID}/$NUM_ISLAND/$folder"
    
    mkdir -p "$exp_name"
    echo "Running iteration folder: $exp_name"
    echo "###-------------------###"

    time srun $EXAMM/build/mpi/examm_mpi \
    --training_filenames $EXAMM/datasets/2019_ngafid_transfer/c172_file_[1-9].csv \
    --test_filenames $EXAMM/datasets/2019_ngafid_transfer/c172_file_1[0-2].csv \
    --time_offset 1 \
    --input_parameter_names "AltAGL" "AltB" "AltGPS" "AltMSL" "BaroA" "E1_CHT1" "E1_CHT2" "E1_CHT3" "E1_CHT4" "E1_EGT1" "E1_EGT2" "E1_EGT3" "E1_EGT4" "E1_FFlow" "E1_OilP" "E1_OilT" "E1_RPM" "FQtyL" "FQtyR" "GndSpd" "IAS" "LatAc" "NormAc" "OAT" "Pitch" "Roll" "TAS" "VSpd" "VSpdG" "WndDr" "WndSpd"  \
    --output_parameter_names "Pitch" \
    --number_islands $NUM_ISLAND \
    --island_size 10 \
    --max_genomes $MAX_GENOME \
    --bp_iterations 10 \
    --patience_rate 20 \
    --possible_node_types simple UGRNN MGU GRU delta LSTM \
    --normalize min_max \
    --weight_update rmsprop \
    --std_message_level INFO \
    --file_message_level INFO \
    --low_mutation_rate 0 \
    --reduced_add_function 0 \
    --patience 1 \
    --output_directory "$exp_name"

done
