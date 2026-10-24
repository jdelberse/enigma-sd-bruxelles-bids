# Bruxelles Dataset (`bruxelles-bids`)

## Overview

This dataset contains MRI data from a sleep manipulation study conducted at the ULB Neurosciences Institute (Belgium). It is part of the ENIGMA-Sleep Working Group collection used to study the effects of sleep loss on glymphatic MRI indices. The data are organized according to the Brain Imaging Data Structure (BIDS) and managed with DataLad (git-annex).

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

- **BL**: baseline (habitual) sleep
- **SD**: total sleep deprivation, 22 h

## Imaging data

### T1-weighted (`anat/`)

| Parameter | Value |
|---|---|
| Scanner | Siemens Prisma |
| Sequence | MPRAGE |
| TR (ms) | 1900 |
| TE (ms) | 2.19 |
| TI (ms) | 900 |
| Flip angle (°) | 9 |

### Diffusion-weighted (`dwi/`)

| Parameter | Value |
|---|---|
| Scanner | Siemens Prisma |
| Sequence | Multiband EPI (acceleration factor 2) |
| Resolution (mm³) | 2 x 2 x 2 |
| TR (ms) | 4070 |
| TE (ms) | 70 |
| b-values (s/mm²) | 0, 650, 1000, 2000 |
| Phase-encoding direction | AP/PA |


## Data organization

- `sub-<ID>/ses-<label>/`: raw BIDS data (`anat/`, `dwi/`)
- `participants.tsv`: participant-level information
- `sub-<ID>/sub-<ID>_sessions.tsv`: session-level information (condition, visit, date, time)
- `derivatives/`: processed outputs

File contents are tracked with git-annex. After cloning, retrieve data with `datalad get <path>`.

## Original publication

Stee, W. et al. Microstructural dynamics of motor learning and sleep-dependent consolidation: A diffusion imaging study. iScience 26, 108426 (2023).
DOI: [10.1016/j.isci.2023.108426](https://doi.org/10.1016/j.isci.2023.108426)


## Contact

- Jorik D. Elberse: j.elberse@fz-juelich.de
- Masoud Tahmasian: m.tahmasian@fz-juelich.de
