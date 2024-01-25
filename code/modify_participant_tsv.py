import pandas as pd

# Load, add sub-labels, set sub as index
tsv = pd.read_csv("participants.tsv", sep="\t")
tsv.dropna(how="all", inplace=True)
tsv['participant_id'] = "sub-" + tsv['participant_id']
tsv.set_index('participant_id', inplace=True)

# Meq to Chronotype
tsv.loc[tsv["chronotype"].between(16,41), "chronotype"] = 2 # Evening
tsv.loc[tsv["chronotype"].between(42,58), "chronotype"] = 3 # Intermediate
tsv.loc[tsv["chronotype"].between(59,86), "chronotype"] = 1 # Morning

# Factorise handedness
tsv["handedness"] = tsv["handedness"].apply(str)
tsv.loc[tsv["handedness"] < 0, "handedness"] = "L" # Left
tsv.loc[tsv["handedness"] > 0, "handedness"] = "R" # Right
tsv.loc[tsv["handedness"] == 0, "handedness"] = "A" # Ambidextrous

# Save
tsv.to_csv("participants.tsv", sep="\t")
