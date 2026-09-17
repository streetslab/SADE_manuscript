#!/bin/bash
THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${THIS_DIR}/specify_path.sh"  # Load sample's sade result dir variables 

manuscript_reproducibility_dir="$(dirname "${THIS_DIR}")"
output_dir="$sade_outdir_VIB_PBMC_MO_V2"

echo "          your local manuscript reproducibility directory is :"
echo "$manuscript_reproducibility_dir"
echo "           your local sade output directory of sample VIB_10xmultiome_2 (i.e. MO_V2) is :" 
echo "$output_dir"


# Prepare script
cp -r  "${manuscript_reproducibility_dir}/Step3_script_for_intermediate_results/scripts" "${output_dir}/."
cp -r "${manuscript_reproducibility_dir}/Step3_script_for_intermediate_results/_ArchR_TSS" "${output_dir}/."
cp -r  "${manuscript_reproducibility_dir}/Step3_script_for_intermediate_results/_cell_calling_comparison" "${output_dir}/"
cp -r "${manuscript_reproducibility_dir}/Step3_script_for_intermediate_results/_CR_FRIP" "${output_dir}/"