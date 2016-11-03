#!/bin/sh

#Job parameters:
#PBS -l walltime=05:00:00
## This is hours, seconds, minutes

#PBS -l select=1:ncpus=16:mem=30gb:tmpspace=10gb
## This is n nodes with n CPUs with x gb compute capacity each with x gb storage (at $TMPDIR) each.

#PBS -q med-bio 

#Use current working directory
##$ -cwd

#Save standard error and out to files:
#PBS -e QC_plink_individuals.stderr
#PBS -o QC_plink_individuals.stdout

# Use submission environment:
#PBS -V

#Module commands:


# Input/output files:
INFILE="airwave_b37_antonio"
SNPs_INTEREST="fibrinogen_snps.txt"
SCRIPTS_BASE_DIR="/home/aberlang/bin/bin_symlinks/"
HAPMAP_FILES="hapmap"
FLASHPCA_FILES="flashpca"
EXCLUDED_REGIONS="exclusion_regions_hg19.txt"

#File management:
cp $PBS_O_WORKDIR/${INFILE}* $TMPDIR
cp $PBS_O_WORKDIR/$SNPs_INTEREST $TMPDIR
cp $PBS_O_WORKDIR/${HAPMAP_FILES}* $TMPDIR
cp $PBS_O_WORKDIR/${FLASHPCA_FILES}* $TMPDIR
cp $PBS_O_WORKDIR/$EXCLUDED_REGIONS $TMPDIR


#Command:
pbsexec -grace 20 /apps/memusage/memusage /bin/bash /export131/home/aberlang/bin/scripts_devel.dir/cgat_projects/BEST-D/genotype_analysis/QC_plink_individuals.sh $INFILE $SNPs_INTEREST $SCRIPTS_BASE_DIR

# The first part allows memory profiling at Imperial's HPC, see:
#https://wiki.imperial.ac.uk/display/HPC/Memory+usage+monitor+for+cx1

# For plotting memory usage results, use in the directory containing 'memusage.*' files:
#module load gnuplot/5.0.0
#gnuplot /apps/memusage/plot


#Notify by email:
# mail alert at (b)eginning, (e)nd and (a)bortion of execution:
#PBS -m bea

#Notify by email:
##PBS -M aberlang@ic.ac.uk

#File management:
cp $TMPDIR/* $PBS_O_WORKDIR
cp $TMPDIR/memusage.* $PBS_O_WORKDIR
