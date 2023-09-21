basicDir="/home/mabad/"
dir="/home/mabad/genome/main/"
dir2="/home/mabad/bioinformaticsData/trios/"
dir3=$dir2
dir3=$basicDir"TDT/html/2G/results/realSamples/"
month="February"
year="2009"
pr=24
testModesT=("Holdout" "HalfTraining" "Training")
testModesT=("HalfTraining")
testModesT=("CrossValidation" "Holdout" "HalfTraining" "Training")
testModesT=("Training") 
testModesT=("CrossValidation" "CrossValidation")
testModesT=("CrossValidation")
testModes=("1" "1")
testModesT=("Holdout")
testModes=("2")
#numberOfFolds=("-1")
numberOfFolds=("5" "2")
numberOfFolds=("1")
testModeForInsideMeasure=1
testModeForInsideMeasure=0
measure="mTDT2G"
#measure="SignedRankTest"
#measure="mTDTYateAlpha_2.00000"
#measure="mTDT_minFreq10.00000"
sampleSize="0"
onlyHetero="1"
alleleOrderType="3"
widths="9 2 1"
widths="1 2 4 6 8 10"
#widths="4 6 8 10"
widths="1 2 4 6 8 10"
widths="1 2 4 6 8 10"
offset="1"
minFreq="0"
ct=0
for testModeT in $testModesT
do
testMode=${testModes[$ct]}
fold=${numberOfFolds[$ct]}
echo testMode is $testMode
echo fold is $fold
for w in $widths
do
echo width $w
#offset=${offsets[$o]}
tail="_averageResultsForTestMode"$testModeT"_SWOfSize"$w"AndOffsetOf"$offset"_"$measure".mult"
processes=0
phase=0
phaseT="IgnoreUnknownPhase"
EMDist=0
EMDistT="_OneDistr"
EMRest=0
EMRestT="_NoRestriction"
file="r"$EMDist"-"$EMRest"-"$phase"-sampleSize"$sampleSize"-width"$w-"onlyKnownNull"$useOnlyKnownDistrs"Hapmap"
n=""
n="Phased"
file=$file"Phased"
rm $file
files="CLEC"
files="Crohn"
files="Crohn EVI5 IL2R IL7R HLA KIAA0350 CD226 CD58 IRF5 CLEC"
#files="IRF5"
#files="HLA"
#files="EVI5"
chrom=("16")
chrom=("5" "1" "10" "5" "6" "16" "18" "1" "7" "16")
#chrom=("6")
#chrom=("5" "1" "10"  "6" "16" "7")
#chrom=("7")
#chrom=("1")
cont=0
for f in $files
do
c=${chrom[$cont]}
echo $f >> $file
echo $f
size=0
resultFile=$dir3"chromosome_"$c"CEU"$month$year$f$n$tail
#size=$(stat -c%s "$resultFile")
rm $resultFile
if [ -f $resultFile ]
then
size=$(stat -c%s "$resultFile")
fi
if [ $size -gt 0  ]
then
echo $resultFile already exists and has size $size
else
echo $resultFile does not exist
echo testmode is $testMode
#echo $dir"makeTUGWAS" $dir2"chromosome_"$c"CEU"$month$year$f$n".gou" 1 $alleleOrderType $EMDist $EMRest $phase 0 -1 $w $offset $onlyHetero $minFreq 100 $testMode $fold 1 1 0   # >> $file &
$dir"makeTUGWAS" $dir2"chromosome_"$c"CEU"$month$year$f$n".gou" 1 $alleleOrderType $EMDist $EMRest $phase 0 -1 $w $offset $onlyHetero $minFreq 100 $testMode $fold $testModeForInsideMeasure 1 0 $dir3   >> $file &


#exit 0
#echo $resultFile does not exist
processes=$[$processes+1]
echo " "
fi
if [  $(($processes%$pr)) == 0 ]
then
wait
fi


if [ $sampleSize -ne "0" ]
then
fGWAS=$f"_Only"$sampleSize"T"
else
fGWAS=$f
fi
fGWAS="ms_"$c"CEUFebruary2009"$fGWAS
size=0
resultFile=$dir3$fGWAS$n$tail
#size=$(stat -c%s "$resultFile")
rm $resultFile
if [ -f $resultFile ]
then
size=$(stat -c%s "$resultFile")
fi
if  [ $size -gt 0  ]
then
echo $resultFile already exists and has size $size
else
echo $resultFile does not exist
echo $dir"makeTUGWAS" $dir2$fGWAS$n".gou" 1 $alleleOrderType $EMDist $EMRest $phase 0 -1 $w $offset $onlyHetero $minFreq 100 $testMode $fold $testModeForInsideMeasure 1 0 $dir3  # >> $file &
$dir"makeTUGWAS" $dir2$fGWAS$n".gou" 1 $alleleOrderType $EMDist $EMRest $phase 0 -1 $w $offset $onlyHetero $minFreq 100 $testMode $fold $testModeForInsideMeasure 1 0  $dir3  >> $file &
echo " "
processes=$[$processes+1]
fi
cont=$[$cont+1]
if [  $(($processes%$pr)) == 0 ]
then
wait
fi
done # for each file
echo "Results written in "$file
o=$[$o+1]
done # for each width
ct=$[$ct+1]
done # for each testMode
#echo new dir is $path2
#w=$dir2"*.cal"
#echo source is $w
#cp $w $dir3
w=$dir2"*.2g.csv"
#cp $w $dir3
#echo moved to $path2 
