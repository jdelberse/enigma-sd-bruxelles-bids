# Bruxelles sleep deprivation MRI dataset (`bruxelles-bids`)

## Overview

This dataset contains MRI data from a sleep manipulation study conducted at the ULB Neurosciences Institute (Belgium). It is part of the ENIGMA-Sleep Working Group collection used to study the effects of sleep loss on brain structure and perivascular spaces. The data are organized according to the Brain Imaging Data Structure (BIDS) and managed with DataLad (git-annex).

## Sample

| Item | Value |
|---|---|
| Site | Bruxelles |
| Affiliation | ULB Neurosciences Institute |
| Country | Belgium |
| Participants (N) | 21 |
| Age, mean (SD), years | 21.2 (2.5) |
| Male (%) | 47.6 |

## Sleep protocol

- **SD**: total sleep deprivation, 22 h

Participants were scanned under baseline and sleep manipulation conditions. [Add session order, interval between sessions, and time of day of scanning.]

## Imaging data

- T1-weighted structural MRI (`T1w`)
- Diffusion-weighted MRI (`dMRI`)

[Add scanner model, field strength, and key acquisition parameters.]

## Data organization

- `sub-<ID>/ses-<label>/`: raw BIDS data (`anat/`, `dwi/`)
- `participants.tsv`: participant-level information
- `sub-<ID>/sub-<ID>_sessions.tsv`: session-level information (condition, visit, date, time)
- `derivatives/`: processed outputs, if present

File contents are tracked with git-annex. After cloning, retrieve data with `datalad get <path>`.

## Original publication

Stee et al.  [Add full citation and DOI.]

## Ethics and consent

[Add ethics approval and consent statement from the original study.]

## Contact

[Add site PI and contact email.]
