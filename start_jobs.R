peptide_size <- 30
n_peptides <- 30
percentile <- 0.02
mhc_haplotypes <- bbbq::get_mhc_haplotypes()

i <- 1
for (peptide_index in seq_len(n_peptides)) {
  protein_sequence <- bbbq::create_random_tmh(n_aas = 30)
  for (mhc_haplotype in mhc_haplotypes) {
    filename <- paste0(i, ".csv")
    cmds <- c("../peregrine/scripts/run_r_script.sh", "calc_p_trans.R", filename, protein_sequence, mhc_haplotype, percentile)

    if (peregrine::is_on_peregrine()) {
      cmds <- c("sbatch", cmds)
    }

    system2(cmds[1], cmds[-1])
    i <- i + 1
  }
}
