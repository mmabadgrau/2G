#echo $1 $2 $3 $4 $5
#exit 0
basicDir="/home/gte/mabad/"
basicDir="/home/mabad/"
dir=$basicDir"genome/main/"
dir2=$basicDir"bioinformaticsApps/LDTDT/simulationsDiffAfricanLongHaps"
dir2=$basicDir"bioinformaticsApps/LDTDT/simulationsTypeIDiffAfricanLongHapsRec0.5"
dir3=$basicDir"TDT/html/2G/results/simulations/TypeIRec0.5/"
#
#dir2=$basicDir"bioinformaticsApps/LDTDT/simulationsDiffGeneralNew/"
#dir2=$basicDir"bioinformaticsApps/LDTDT/simulationsDiffYuOneHaplotype/"
#dir2=$basicDir"bioinformaticsApps/LDTDT/simulationsDiffAfricanJan2010/"
sampleSize="_Size500"
onlyHetero=1
alsoHomoT="_AlsoHomo"
#testMode=2
dir2=$dir2$alsoHomoT$sampleSize"/"
pr=12
testModeInsideMeasure=1
testModes="2 4"
testModes="1 2 3 4"
#testModes="1 3 4" 
#testModes="2" # holdout
#testModes="1 2 3 4"
#testModes="3" # testing
testModes="1" # crossValidation
#testModes="3" # training
folds="5 2"
#folds="-1"
for fold in $folds
do
processes=0
for testMode in $testModes
do
if [ $testMode == "1" ]
then
testModeT="CrossValidation_fold"$fold
testModeT="Training" # cross validation is for internal measures 
fi
if [ $testMode == "2" ]
then
testModeT="Holdout"
fi
if [ $testMode == "3" ]
then
testModeT="Training"
fi
if [ $testMode == "4" ]
then
testModeT="HalfTraining"
fi
alsoHomoT="_AlsoHomo"
totalSamples=1000 #0 # 0
#totalSamples=100
#totalPermutations=1000
#totalPermutations=100
totalPermutations=0
maxHap=1
cd $dir2
test="TypeIError"
c=0
#length="10 8 6 4 2 1"
length="1 2 10"
length="2 4 6"
length="1 2 4 6 8 10"
length="10 8 6 4 2 1"
#length="1"
for l in $length
do
freq="0.1 0.3 0.5"
#freq="0.1" # 0.5"
mixtureProp="0.5 0.75 0.833"
#mixtureProp="0.75 0.833"
#mixtureProp="0.5"
for mix in $mixtureProp
do
for f in $freq
do
echo $dir2$test"_MAF"$f"mixProp"$mix
file=$dir2$test"_MAF"$f"mixProp"$mix$sampleSize$alsoHomoT"_resultsForTestMode"$testModeT"_SWOfSize"$l"AndOffsetOf1_mTDT2G_cv"$fold".mult"
#echo $file
rm $file
if [ ! -f $file ]
then
#rm "resMAF"$f"minProp"$mix"size"$l 
#echo "resMAF"$f"minProp"$mix"size"$l
#echo error= $dir"makeTUGWAS" $dir2$test"_MAF"$f"mixProp"$mix$sampleSize$alsoHomoT"_" $totalSamples $2 $3 $4 $5 0 $l $l 1 $onlyHetero 0 $totalPermutations $testMode $fold 1 0
error= $dir"makeTUGWAS" $dir2$test"_MAF"$f"mixProp"$mix$sampleSize$alsoHomoT"_" $totalSamples $2 $3 $4 $5 0 $l $l 1 $onlyHetero 0 $totalPermutations $testMode $fold $testModeInsideMeasure 0 0 $dir3  &   # >& "resMAF"$f"minProp"$mix"size"$l  #&
#exit 0

#error= $dir"makeTUGWAS" $dir2$test"_MAF"$f"mixProp"$mix$sampleSize$alsoHomoT$shuffled"_" $totalSamples $2 $3 $4 $5 0 $l $l 1 $onlyHetero 0 $totalPermutations 3 0 0 $verticalOutput $returnPVals  $dir3  &   # >& "resMAF"$f"minProp"$mix"size"$l  &



#exit 0
#exit 0
processes=$[$processes+1]
fi
if [ $(($processes%$pr)) == 0 ]
then
wait
fi
done
done
done
done # for each testMode
done # for each number of folds
