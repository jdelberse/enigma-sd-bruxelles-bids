import os
import pandas as pd

# Load, add sub-labels, set sub as index
tsv = pd.read_csv("participants.tsv", sep="\t")
tsv.set_index('participant_id', inplace=True)

for sub in tsv.index:
    first_ses = "NN"

    if first_ses == "NN":
        ses_labs = {"ses-1" : "ses-nn", "ses-2" : "ses-sd"}
    else:
        ses_labs = {"ses-1" : "ses-sd", "ses-2" : "ses-nn"}
    
    for ses in ["ses-1", "ses-2"]:
        old_scan = f"{sub}/{ses}/{sub}_{ses}_T1w.nii.gz"
        new_scan = f"{sub}/{ses}/{sub}_{ses_labs[ses]}_T1w.nii.gz"
        
        if not os.path.exists(new_scan):
            print(f"{old_scan} >>> {new_scan}")
            os.rename(old_scan, new_scan) #TODO: uncomment when running for real
        else:
            print(f"{new_scan} exists. Skipping...")
        
        old_dir = f"{sub}/{ses}"
        new_dir = f"{sub}/{ses_labs[ses]}"

        if not os.path.exists(new_dir):
            print(f"{old_dir} >>> {new_dir}")
            os.rename(old_dir, new_dir) #TODO: uncomment when running for real
        else:
            print(f"{new_dir} exists. Skipping...")
