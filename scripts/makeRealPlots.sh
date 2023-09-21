home="/home/mabad/repGenome/"
path="../results/realSamples/"
path2=$path #$home"bioinformaticsApps/LDTDT/realSamples/"
sampleSize="0"
noSingle=1
noBlocks=1
s=1
noBorder=0
#testMode="Training"
#testMode="Holdout"
testModes="Training Holdout"
testModes="HalfTraining"
testModes="HalfTraining Training Holdout CrossValidation_fold5"
testModes="Holdout"
type="PHP"
#type="R"
dir="/home/mabad/genome/main/"
widths="1 2 4 6 8 10"
#widths="1"
#rm countsHapmap
#rm countsAffected
for testMode in $testModes
do
for width in $widths
do
files="Crohn EVI5 IL2R IL7R HLA KIAA0350 CD226 CD58 IRF5 CLEC" # NL C8 Hapmap"
#files="EVI5 IL2R IL7R HLA KIAA0350 CD226 CD58 IRF5" 
#files="HLA"
chrom=("5" "1" "10" "5" "6" "16" "18" "1" "7" "16")  # "1" "8" "8")
#chrom=("1" "10" "5" "6" "16" "18" "1" "7") 
#chrom=("6")
cont=0
for f in $files
do
c=${chrom[$cont]}
echo "cont is" $cont
echo $c
#bl="1 2"
#bl="2"
#for b in $bl
#do
fGWAS=$f"Phased"
if [ $sampleSize -ne "0" ]
then
fGWAS=$fGWAS"_Only"$SampleSize"T"
fi 
measures="0 95 99"
measures="0"
for m in $measures
do
#echo $fGWAS
file=$path"chromosome_"$c"CEUFebruary2009"$fGWAS"_resultsForTestMode"
file2=$path"ms_"$c"CEUFebruary2009"$fGWAS"_resultsForTestMode"
#echo $file
#echo $file2
#echo ${10}
#echo noblocks $nb
#echo $file
#echo $file2
fileExt=$testMode"_SWOfSize"$width"AndOffsetOf1"
if [ $type == "PHP" ]
then
echo $file2$fileExt
echo $file$fileExt
#echo php ../php/makeRealPlots.php file=$file alpha=$m noSingle=1 mis=0 hwe=0 men=0 noBlocks=1 fileChrom=$file noBorder=0 hapLength=$width fileExt=$fileExt fileSecond=$file
php ../php/makeRealPlots.php file=$file alpha=$m noSingle=1 mis=0 hwe=0 men=0 noBlocks=1 fileChrom=$file noBorder=0 hapLength=$width fileExt=$fileExt fileSecond=$file
#file=""
fileExt=$testMode"_SWOfSize"$width"AndOffsetOf1"

php ../php/makeRealPlots.php file=$file2 alpha=$m noSingle=1 mis=0 hwe=0 men=0  noBlocks=1 fileChrom=$file noBorder=0 hapLength=$width fileExt=$fileExt fileSecond=$file 
else
fileExt=$fileExt".csv"
#echo $file
#echo $fileExt
if [ $f == "HLA" ]
then
ylim=10
else
ylim=10
fi
R CMD BATCH "--args $file $fileExt $f Hapmap countsHapmap $ylim" ../R/pVals.r
echo $file
R CMD BATCH "--args $file2 $fileExt $f Affected countsAffected $ylim" ../R/pVals.r
fi
#done
done
cont=$[$cont+1]
done
#echo new dir is $path2
#w=$path"*.png"
#echo source is $w
#cp $w $path2
#rm $w
#echo moved to $path2 
done # for each width
done 


