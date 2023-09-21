<html>
<head>

<?php include($_SERVER['DOCUMENT_ROOT'].'/readlanguage.php');$idioma=readLanguage("es");?>
        <META content="3 days" name=Revisit>
        <META content=all name=robots>
        <META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
        <link href="/css/normal.css" rel="stylesheet" type="text/css">

</head>
<body>
<h1>TDT<sub>2G</sub>: A 2-groups &Chi;<sup>2</sup> multimarker TDT for genome-wide exploration</h1>
<h1>Supplementary material</h1>
<h2>Simulations</h2>
<a href="../simulations/simulations.pdf">Download a detailed description of the way simulations were performed</a>
<br>
<a href="../simulations/simulationsDetails.pdf">Download a detailed description of the configurations used to run msHOT</a>
<br><a href="../trioSampling/">trioSampling: software used to generate trio SNP genotype samples from populations</a>
<br>
<?php
$baseDir="results/";
$widthA=Array("1", "2", "4", "6", "8", "10");
$sampleSize=Array("200", "Training", "Holdout");
$a=1;
foreach ($sampleSize as $c)
{
$t=0;
if ($c=="TypeIError")
{
$models=Array("Type I error");
echo "<h3>Robustness and reproducibility to admixture and population stratification for TDT<sub>2G</sub> and state-of-the-art multimarker TDTs</h3>"; 
}
else
$models=Array("One locus", "Two loci: Additive - DomOrDom - RecOrRec disease models", "Two loci: DomAndDom - Threshold - Modified disease models");
if ($c=="200")
echo "<h3>Power and locus specificity: Comparisons among several multimarker TDTs using samples with 200 trios</h3>";
if ($c=="Training") echo "<h3>Power and locus specificity using samples with 500 trios and low relative risks: TDT<sub>2G</sub>, TDT<sub>2G-cv5</sub> and TDT<sub>S</sub></h3>";
if ($c=="Training-cv5") echo "<h3>Power and locus specificity using samples with 500 trios and low relative risks: TDT<sub>2G-cv5</sub>, TDT<sub>1-cv5</sub> and TDT<sub>S</sub></h3>";
if ($c=="Holdout") echo "<h3>Test reproducibility: TDT<sub>2G</sub> and TDT<sub>S</sub></h3>";
foreach ($models as $m)
{
if ($c!="TypeIError") echo "<h4>".$m."</h4>";
for ($w=0; $w<sizeOf($widthA); $w++)
if (($c!="TypeIError" && ($w>0 || $c!="200")) || ($c=="TypeIError" && $w==0))
{
echo "<a href=\"".$baseDir."simulations/simulations.php?sampleSize=".$c."&model=".$t."&length=".$widthA[$w];
//if ($m=="One locus") echo "OneLocus";
//else if ($t==2) {echo "TwoLociA"; $t=0;} 
//else echo "TwoLociB";
//echo "Length".($widthA[$w])."Alpha05.png
if ($c!="TypeIError")
echo "\">Figure S".($a).". Simulations for haplotype width ".$widthA[$w]."</a><br>";
else echo "\">Figure S".($a).". All simulations</a><br>";

$a++;
}
$t++;
}
}
//echo "<br><a href=\"".$baseDir."simulations/simulationsTwoLociBHomo-HeteroAnd2Ho.png\">Human population, coalescent model, two loci, genetic models: domANDdom, threshold, modified</a>";
//echo "<br><a href=\"".$baseDir."simulations/simulationsOneLocusYuHomo-HeteroAnd2Ho.png\">Simplified evolution model, one locus</a>";
//echo "<br><a href=\"".$baseDir."simulations/simulationsTwoLociAYuHomo-HeteroAnd2Ho.png\">Simplified evolution model, two loci, genetic models: additive, domORdom, recORrec</a>";
//echo "<br><a href=\"".$baseDir."simulations/simulationsTwoLociBYuHomo-HeteroAnd2Ho.png\">Simplified evolution model, two loci, genetic models: domANDdom, threshold, modified</a>";
?>
<h2>Real data</h2>
<?php
$month="February";
if (isset($_GET['month']))
$month=$_GET["month"];
$year=2009;
if (isset($_GET['year']))
$year=$_GET["year"];
//echo "<a href=\"tdtCont.php?month=".$month."&year=".$year."&type=plots&ext=".$PhaseMethod[0]."_".$EMDist[0]."_".$EMRest[0]."&phased=Phased\">"."Phase solved with EM-Max UTDistr, TriosBasedRestriction".$PhaseMethod[0].", ".$EMDist[0].", ".$EMRest[0]."</a><br>";
$widthA=Array("1", "2", "4", "6", "8", "10");




echo "<h3>Sliding window maps</h3>";
for ($w1=0; $w1<sizeOf($widthA); $w1++)
echo "<a href=\"tdtContPlots.php?month=".$month."&year=".$year."&type=maps&phased=Phased&w=".$widthA[$w1]."\">Figure S".($w1+$a)."</a> Sliding window maps for window width of ".$widthA[$w1]."<br>";
echo "<h3>CTDT maps</h3>";

$a=$a+sizeOf($widthA);
for ($w=0; $w<sizeOf($widthA); $w++)
echo "<a href=\"tdtCont.php?month=".$month."&year=".$year."&type=maps&ext=&phased=Phased&w=".$widthA[$w]."\">Figure S".($a+$w)."</a> CTDT maps for window width of ".$widthA[$w]."<br>";

//echo "<p><a href=\"tdtNoBlocks.php?alpha=0&res=5&ext=IgnoreUnknownPhase_OneDistr_NoRestriction&sampleSize=0&month=February&year=2009">Real data Hapmap 2009 results no blocks</a></li> 
?>

<h2>Data sets</h2>
<a href="/BioData/CrohnPhased.gou">Crohn data set in makeped format</a><br>
<a href="/BioData/chromosome_5CEUFebruary2009Crohn.gou">CEU IHMP data set in makeped format same locus as Crohn data set</a>


<h2>Software</h2>
<a href="2G1.0.tar.gz">Download source code</a>
<br>
<a href="2G1.0.gz">Download compiled version for linux 64</a>
<br>
<a href="HowToInstall.html">README</a>


</body>
