dir="/home/mabad/commonc++/main/"
dir2="/home/mabad/bioinformaticsData/trios/"
dir3="../results/realSamples/"
files="chromosome1_CEUMarch2008Fuen chromosome1_CEUMarch2008WithGWAS ms_1WithHapMap"
files="Crohn EVI5 IL2R IL7R HLA KIAA0350 CD226 CD58 IRF5 CLEC" # NL Crohn C8"
chrom=("5" "1" "10" "5" "6" "16" "18" "1" "7" "16") # "1" "5" "8")
#files="Crohn EVI5 IL2R IL7R KIAA0350 CD226 CD58 IRF5" # NL Crohn C8"
#chrom=("5" "1" "10" "5" "16" "18" "1" "7") # "1" "5" "8")

#files="Crohn"
#chrom=("5")
sampleTypes="chromosome ms"
#sampleTypes="ms"
#testMode="HalfTraining"
#testMode="Holdout"
testModes="Holdout Training HalfTraining CrossValidation_fold5"
testModes="Training" 
testModes="Holdout"
#testModes="CrossValidation_fold5"
for testMode in $testModes
do
#echo $testMode
type="mTDT2G ScoreTDT mTDT1 LengthContrastTest SignedRankTest"
type="mTDT2G_useDistances ScoreTDT mTDT" # SignedRankTest" # LengthContrastTest SignedRankTest"
if [ $testMode == "Training" ] || [ $testMode == "HalfTraining" ]
then
type="mTDT2G_cv2_useDistances ScoreTDT mTDT" # mTDT1_cv2_useDistances"
fi
#type="ScoreTDT mTDT1T"
#type="ScoreTDT-HWE ScoreTDT mTDT mTDT1T EntropyTDT_usingPermutations mTDT_usingPermutations"
#type="minFreq10_mTDT_minFreq10.00000 minFreq0_mTDT minFreq10_ScoreTDT_minFreq10.00000 minFreq0_ScoreTDT minFreq10_ScoreTDT-HWE_minFreq10.00000 minFreq0_ScoreTDT-HWE minFreq0_EntropyTDT_100permutations minFreq0_mTDT_100permutations minFreq10_mTDT1T_minFreq10.00000 minFreq0_mTDT1T minFreq0_LenghtContrastTest minFreq0_SignedRankTest"

SW="1 2 4 6 8 10"
for s in $sampleTypes
do
for sw in $SW
do
cont=0
for f in $files
do
c=${chrom[$cont]}
#echo $f
#echo $c
final=$dir3$s"_"$c"CEUFebruary2009"$f"Phased_resultsForTestMode"$testMode"_SWOfSize"$sw"AndOffsetOf1.csv"
echo > $final
cont2=0
for t in $type
do 
file=$dir3$s"_"$c"CEUFebruary2009"$f"Phased_averageResultsForTestMode"$testMode"_SWOfSize"$sw"AndOffsetOf1_"$t".mult"
#echo $file
#exit 0
if [ $cont2 == 0 ]
then
if [ -f $file ]
then 
cp $file $final
else
echo File $file does not exist
exit 0
fi
else
$dir"PasteFilesByColumns" $final $file  temp
mv temp $final
fi
#echo  $file added to $final
cont2=$[$cont2+1]
done # end each measure
sed '1d' $final > temp
mv temp $final
#echo first line removed
sed -i "1i\\$type" $final 
#echo last line removed
cont=$[$cont+1]
echo $final written
done # end each sample
done # end each width
done # end each sampleTypes
done # for each testMode

