import glob
import pandas as  pd
hic_df = pd.read_csv('HIC_Y3_fillin_and_Y4_part1-redo.csv',header=None)
hic_df['file_id'] = [sample.split('/')[-1] for sample in hic_df[0].tolist()]
hic_df.rename(columns={0:'hic_reads'},inplace=True)
other_reads = []
for sample in [sample.split('/')[-4] for sample in hic_df['hic_reads'].tolist()]:
	other_reads_path = glob.glob('/private/groups/hprc/human-pangenomics/1000G_local/child/cram_to_bam/'+sample+'/*/*/*/*')
	
	if other_reads_path == []:
		other_reads_path = glob.glob('/private/groups/hprc/1000G_local/child/fastq/' + sample + '.*')
		other_reads.append([other_reads_path[0]])
	else:
		other_reads.append([other_reads_path[0]])
hic_df['other_reads'] = other_reads
hic_df[['file_id','hic_reads','other_reads']].to_csv('hic_qc/hic_qc_sample_files.csv',index=False)