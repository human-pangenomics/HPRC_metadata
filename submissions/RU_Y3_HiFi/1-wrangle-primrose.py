import pandas as pd
sample = pd.read_csv('RU_Y3_HIFI.csv',header=None)
meth_df = pd.read_csv('methylation_summary.tsv',sep='\t')
meth_df['sample_id'] = [sample.split('/')[5] for sample in sample[0].tolist()]
meth_df['s3'] = sample[0]
meth_df['flow_cell'] = [flow_cell.split('.')[0] for flow_cell in meth_df['file_name'].tolist()]
meth_df['flow_cell_5mc'] = meth_df['flow_cell'].str.contains('with_5mC')
meth_df['flow_cell_hifi'] = meth_df['file_name'].str.contains('hifi_reads')
primrose_df = meth_df[meth_df['MM_tag'].isin([False])]
primrose_df = primrose_df[['sample_id','flow_cell','s3']]
primrose_df['sample_id'] = primrose_df['sample_id'] + '_' + primrose_df['flow_cell']
primrose_df = primrose_df[['sample_id','s3']]
primrose_df.rename(columns={'s3':'input_bams'},inplace=True)
primrose_df.to_csv('primrose/primrose_sample_data.csv',index=False)