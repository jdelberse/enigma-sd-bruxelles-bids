root=$(pwd)
deriv=$root/derivatives
smriprep=$deriv/smriprep

wpss=$deriv/wpss
train=$wpss/train
test=$wpss/test

for dir in $wpss $train $test; do
    mkdir -p $dir
done

for subdir in $smriprep/sub-*; do
    sub=${subdir#$smriprep/}
    echo Preparing $sub

    for sesdir in $subdir/ses-*; do
        ses=${sesdir#$subdir/}
        echo Session: $ses
            
        to_train=$train/${sub}_${ses}
        to_test=$test/${sub}_${ses}
        mkdir -p $to_train $to_test
        echo Created $to_train and $to_test
            
        # Input files
        scan=$sesdir/${sub}_${ses}_desc-preproc_T1w.nii.gz
        mask=$sesdir/${sub}_${ses}_desc-brain_mask.nii.gz

        # Ouput files
        scan_train=$to_train/epc.nii.gz
        scan_test=$to_test/epc.nii.gz
        mask_train=$to_train/mask.nii.gz
        mask_test=$to_test/mask.nii.gz
        target=$to_test/target.nii.gz


        for dest in $scan_train $scan_test $target; do
            cp $scan $dest
            echo Copied $scan to $dest
        done

        for dest in $mask_train $mask_test; do
            cp $mask $dest
            echo Copied $mask to $dest
        done
    done
    echo Finished
done




    

    

