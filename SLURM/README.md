To run a simple job array on SLURM (HARVAD FASRC) execute the following

`sbatch` `--array=<NUM_START>-<NUM_END>` `transm_array.sbatch`

Where `<NUM_START>` is an integer for the start number in the job array and `<NUM_END>` is the final number in a sequence.

NOTE: Filenames has to be named sequentially numbered: `1.xml`, `2.xml`, `3.xml`,...

