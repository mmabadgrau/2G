<html>
<head>
<title>simulations</title>
<?include($_SERVER['DOCUMENT_ROOT'].'/readlanguage.php');$idioma=readLanguage("es");?>
        <META content="3 days" name=Revisit>
        <META content=all name=robots>
        <META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
        <link href="/css/normal.css" rel="stylesheet" type="text/css">

</head>
<body>
<h1>Multimarker TDTs</h1>
</body>

<?
$model=0;
if (isset($_GET['model']))
$model=$_GET['model'];

$sampleSize="200";
if (isset($_GET['sampleSize']))
$sampleSize=$_GET['sampleSize'];

$length=1;
if (isset($_GET['length']))
$length=$_GET['length'];

$models=Array("One disease susceptibility locus", "Two disease susceptibility loci: Additive - DomOrDom - RecOrRec disease models", "Two disease susceptibility loci: DomAndDom - Threshold - Modified disease models");
echo "<h2>".$models[$model]."</h2>";
?>
<h4>Color codes:</h4>
<ul>
<? if ($sampleSize==200)
echo "<li><font color=blue>Blue: mTDT<sub>S</sub></li>
<li><font color=purple>Purple: mTDT</li>
<li><font color=brown>Brown: mTDT<sub>SR</sub></li>
<li><font color=violet>Violet: mTDT<sub>E</sub></li>
<li><font color=black>Black: mTDT<sub>LC</sub></li>";
if ($sampleSize=="Holdout" || $sampleSize=="Training")
{
echo "<li><font color=red>Red: mTDT<sub>2G</sub></li>";
echo "<li><font color=blue>Blue: mTDT<sub>S</sub></li>";
echo "<li><font color=purple>Purple: mTDT</li>";
}
if ($sampleSize=="Training")
echo "<li><font color=green>Green: mTDT<sub>2G-cv5</sub></li>";
if ($sampleSize=="Training-cv5")
{
echo "<li><font color=pink>Pink: mTDT<sub>2G-cv5</sub></li>";
echo "<li><font color=blue>Blue: mTDT<sub>S</sub></li>
<li><font color=aquamarine>Light green: mTDT<sub>1-cv5</sub></li>";
echo"<li>";
}

#if ($sampleSize=="Holdout")
#{
#echo "</ul><ul><li><font color=black>Dotted line: simple-sample testing</li>";
#echo "<li><font color=black>Continuous line: holdout testing (test reproducibility)</li></ul>";
#}
?>
</ul>
</ul> <font color=black>

<?

/*$files=Array("crohnOriginal", "chromosome5_CEUMarch2008WithCrohnReduced");

for ($cont=0; $cont<2; $cont++)
{
echo "<tr><td>".$files[$cont].":<br>";
echo "<a href=\"tdt.php?alpha=".$alpha."&res=".($res/2)."&ext=".$ext."&sampleSize=".$sampleSize."\"> ";
echo "<img src=\"../realSamples/".$files[$cont].".mult".$ext."Alpha".$alpha.".png\" height=".$size[$cont]/$res."px></a>";
echo "</td></tr>";
}
*/

//if ($m=="One locus") echo "OneLocus";
//else if ($t==1) {echo "TwoLociA"; $t=0;} 
//else echo "TwoLociB";
//echo "Length".($widthA[$w])."Alpha05.png

$simulations="simulations";
if ($sampleSize=="200") $simulations=$simulations."OldRisks";

if ($sampleSize!="200") $simulations=$simulations."LowRisk";
if ($sampleSize=="Holdout") $simulations="Holdout";
//if ($sampleSize!="TypeIError")
{
if ($model==0) $simulations=$simulations."OneLocus"; 
else if ($model==1) $simulations=$simulations."TwoLociA";
else $simulations=$simulations."TwoLociB";
#if ($sampleSize=="Training") $simulations=$simulations."cv2ForMultipleTest";
#if ($sampleSize=="Training-cv5") $simulations=$simulations."cv5ForMultipleTest";

$sims=Array("05", "01");
foreach ($sims as $sim)

//echo "sim:".$simulations;
//echo "model is: ".$model;
echo "\n<img src=\"".$simulations."Length".$length."Alpha".$sim.".png\" height=1200px border=0>\n";
}
//else
//echo "\n<img src=\"simulationsTypeIErrorAlpha05.png\" height=900px border=0>\n";

?>

</body>
</html> 

