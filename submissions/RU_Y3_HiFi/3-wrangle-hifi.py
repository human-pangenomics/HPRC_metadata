import pandas as pd
import glob

ru_y3_df = pd.read_csv('RU_Y3_HIFI.csv',header=None)
ru_y3_df.rename(columns={0:'hifi_reads'}, inplace=True)
ru_y3_df = ru_y3_df[ru_y3_df['hifi_reads'].str.contains('primrose')]
ru_y3_df['sample_id'] = [sample.split('/')[-3] + '_' + sample.split('/')[-1] for sample in ru_y3_df['hifi_reads'].tolist()]

other_reads = []
for sample in [sample.split('_')[0] for sample in ru_y3_df['sample_id'].tolist()]:
	other_reads_path = glob.glob('/private/groups/hprc/human-pangenomics/1000G_local/child/cram_to_bam/'+sample+'/*/*/*/*')
	if other_reads_path == []:
		other_reads_path = glob.glob('/private/groups/hprc/1000G_local/child/fastq/' + sample + '.*')
		other_reads.append([other_reads_path[0]])
	else:
		other_reads.append([other_reads_path[0]])
ru_y3_df['other_reads'] = other_reads
ru_y3_df['perform_methylation_check'] = 'true'
ru_y3_df[['sample_id','hifi_reads', 'other_reads', 'perform_methylation_check']].to_csv('hifi_qc/hifi_qc_sample_files.csv', index=False)