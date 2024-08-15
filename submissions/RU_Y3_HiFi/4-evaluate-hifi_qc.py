import pandas as pd
hifi_df = pd.read_csv('/private/groups/hprc/human-pangenomics/test-setup/HPRC_metadata/submissions/RU_Y3_HiFi/hifi_qc/hifi_qc_sample_output.csv')
hifi_qc = pd.concat([pd.read_csv(qc,sep='\t') for qc in hifi_df['hifi_qc_summary'].tolist()])
hifi_qc['sample_id'] = [sample.split('_')[0] for sample in hifi_qc['filename'].tolist()]
hifi_qc['coverage'] = [bp/3.1 for bp in hifi_qc['total_Gbp'].tolist()]
hifi_qc.to_csv('RU_Y3_HIFI_sample_file_hifi_qc_aggregate.csv',index=False)