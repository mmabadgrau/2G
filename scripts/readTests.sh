basicDir="/home/gte/mabad/"
basicDir="/home/mabad/"
dir=$basicDir"commonc++/main/"
alsoHomo="_AlsoHomo"
name="simulationsDiffAfricanLongHaps"
#name="simulationsDiffAfricanJan2010"
#name="simulationsDiffYuOneHaplotype"
sampleSize="_Size500"
#minFreq="_minFreq0"
dir2=$basicDir"bioinformaticsApps/LDTDT/"$name$alsoHomo$sampleSize"/"
dir2=$basicDir"bioinformaticsApps/LDTDT/"$name$alsoHomo$sampleSize"/"
name="simulationsDiffAfricanLowRisk"
dir2=$basicDir"TDT/html/2G/results/simulations/power/"


dir3="../results/simulations/";
testMode="HalfTraining"
testMode="CrossValidation_fold5"
testMode="Training"
#testMode="HalfTraining"
testMode="Holdout"
alpha="01 05 001 005"
rec="0.0000000 0.0000500 0.0001000 0.0001500 0.0002000" # 0.0002500 0.0003000 0.0003500 0.0004000 0.0004500 0.0005000 0.0008000 0.0016000 0.0032000"

common="ScoreTDT_minFreq10.00000 ScoreTDT mTDT1T EntropyTDT_usingPermutations mTDT2G LengthContrastTest SignedRankTest" 

common="ScoreTDT_minFreq10.00000 mTDT2G_cv2 mTDT1_cv2 mTDT1T_cv2 mTDT1U_cv2"

common="mTDT2G_cv5 mTDT2G_cv5_useDistances mTDT1_cv5 mTDT1_cv5_useDistances mTDT1T_cv5 mTDT1T_cv5_useDistances mTDT1U_cv5 mTDT1U_cv5_useDistances mTDT2G_cv2 mTDT2G_cv2_useDistances mTDT1_cv2 mTDT1_cv2_useDistances mTDT1T_cv2 mTDT1T_cv2_useDistances mTDT1U_cv2 mTDT1U_cv2_useDistances mTDT mTDT_minFreq10.00000 ScoreTDT ScoreTDT_minFreq10.00000" # mTDT1T mTDT1T_minFreq10.00000 mTDT2G mTDT2G_minFreq10.00000 mTDT1 mTDT1_minFreq10.00000"

common="mTDT2G_cv5 mTDT2G_cv5_useDistances mTDT1_cv5 mTDT1_cv5_useDistances mTDT1T_cv5 mTDT1T_cv5_useDistances mTDT1U_cv5 mTDT1U_cv5_useDistances mTDT2G_cv2 mTDT2G_cv2_useDistances mTDT1_cv2 mTDT1_cv2_useDistances mTDT1T_cv2 mTDT1T_cv2_useDistances mTDT1U_cv2 mTDT1U_cv2_useDistances mTDT ScoreTDT"

common="mTDT2G_cv2_useDistances ScoreTDT mTDT mTDT2G_cv5_useDistances"

if [ $testMode == "Holdout" ]
then
common="mTDT2G_useDistances ScoreTDT mTDT"
fi

#####rename f0_w8_LengthContrastTest.multOnlyHetero resultsForTestModeTraining_SWOfSize8AndOffsetOf1_LengthContrastTest.mult *LengthContrastTest.multOnlyHetero
#####rename f0_w10_EntropyTDT_100permutations.multOnlyHetero resultsForTestModeTraining_SWOfSize10AndOffsetOf1_EntropyTDT_usingPermutations.mult *EntropyTDT_100permutations.multOnlyHetero
#aTestMode=${testModes[0]}
filePower=$dir3"resultsPowerOneBlock"$name$alsoHomo"_OnlyHetero"$sampleSize$totalPermutations$testMode".csv" # ${testModes[0]}".csv"
#rm $fileTypeI
rm $filePower
echo -n "test model relativeRisk haplotypeLength recFrac " >> $filePower
#echo -n "MAF MAF mixProp mixProp haplotypeLenght haplotypeLength "  >> $fileTypeI
echo $common
for fk in $common
do
for a in $alpha
do
echo -n $testMode"_"$fk"_"$a" " >> $filePower 
#echo -n $testMode"_"$fk"_"$a" " >> $fileTypeI
done
done
echo >> $filePower
#echo >> $fileTypeI
test="PowerTwoLoci PowerOneLocus"
#test="PowerTwoLoci"
testCont=1
for t in $test
do
echo test $t
c=0
firstPos=0
length="1 2 4 6 8 10"
#length="10"
for l in $length
do
echo length $l
model="Additive DomOrDom DomAndDom RecOrRec Threshold Modified"
modelCont=1
for m in $model
do
if [ $testCont == 1 -o $modelCont == 1 -o $modelCont == 2 -o $modelCont == 4 ]
then
RR="2 4 6 8 10"
RR="1.2 1.6 2.0 2.4 2.6"
echo model $m
for RRCont in $RR
do
for recCont in $rec
do
firstPos=0
#echo RR $RRCont
#echo rec $recCont
echo -n $t $m $RRCont $l $recCont >> $filePower 
rm temp
rm temp2
for fk in $common
do
$dir"readSimulationsResults" $dir2$t"Rec"$recCont"_RR"$RRCont"0000_"$m$sampleSize$alsoHomo"_resultsForTestMode"$testMode"_SWOfSize"$l"AndOffsetOf1_"$fk".mult" temp
#exit 0
done
tr -d '\n' < temp >> temp2  # remove \n
cat temp2 >> $filePower 
echo >> $filePower
done # end for each rec
done # for each RR
fi # end if model correct
modelCont=$[$modelCont+1]
done # end for each model
done # for each length
testCont=$[$testCont+1]
done # end for each test 
echo Results have been saved in $filePower
