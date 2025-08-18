import sys
import ranchero as ranchero

data_table = ranchero.from_tsv(sys.argv[1], auto_standardize=False, auto_rancheroize=False, index="new_filename")
data_table = ranchero.translate_HPRC_IDs(data_table, "sampleID", "Sample")
ranchero.to_tsv(data_table, f"{sys.argv[1]}_HPRC_BioSamples.tsv")