## WUSTL_HPRC_HiFi_Year1

So these lads are a little weird. What got uploaded to SRA was the usual bams, but also the subreads. Also, for some reason, we (Ivo and Ash) can't get the metadata-xxxxxx-processed-ok.tsv file from NCBI's submissions wizard for the not-subread bams -- maybe they were submitted by someone at another institute?

There was already a WUSTL_HPRC_HiFi_Year1_post_sra_metadata.tsv file in here, which seems to be the non-subreads version. This has the accession IDs we actually want -- well, probably. Since the provance of this file is mysterious, I can't proper validate anything here.

In my opinion I think there's no reason to take the subreads off SRA since there doesn't seem to be anything wrong with them. They are labeled as subreads in the title and their metadata links them to the non-subread versions via the field `ccs_link` as shown in `metadata-11041174-processed-ok__APPARENTLY_JUST_SUBREADS.tsv`... now, it doesn't seem that linkage carried over to SRA itself, but, the linkage is indeed there.

One other thing we noticed -- the subread files should be about 4x larger than what SRA will actually deliver to you. In fact each subread file seems about the same size on SRA as its not-subread version. It seems the SRA Normalized file conversion is removing or heavily compressing subread information beyond what we thought?

With all this in mind there is no `__final` table here -- just use `WUSTL_HPRC_HiFi_Year1_post_sra_metadata__NOT_SUBREADS.tsv` as it's the best we got.