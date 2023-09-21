<html>
<head>

<?include($_SERVER['DOCUMENT_ROOT'].'/readlanguage.php');$idioma=readLanguage("es");?>
        <META content="3 days" name=Revisit>
        <META content=all name=robots>
        <META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
        <link href="/css/normal.css" rel="stylesheet" type="text/css">

</head>
<body>
<h1>Multimarker TDT maps</h1>


<?
$month="February";
if (isset($_GET['month']))
$month=$_GET["month"];
$year=2009;
if (isset($_GET['year']))
$year=$_GET["year"];
$res=1;
if (isset($_GET['ext']))
$ext=$_GET['ext'];
else $ext="EM-Freq";
$phased="";
if (isset($_GET['phased']))
$phased=$_GET['phased'];
$w=2;
if (isset($_GET['w']))
$w=$_GET['w'];


//echo "<h2>Haplotype inference method: ".$ext."</h2>";
if ($phased=="Phased")
echo "<h2>Phased using EM-Max, UT distr, trios restriction</h2>";
?>
<h4>Color codes:</h4>
TDT results:
<ul>
<li><font color=red>Red: mTDT<sub>2G</sub></li>
<li><font color=blue>Blue: mTDT<sub>S</sub></li>
<li><font color=purple>Purple: mTDT</sub></li>
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
$files=Array("Crohn", "EVI5", "IL2R" , "IL7R",  "HLA",  "KIAA0350", "CD226", "CD58", "IRF5"); #, "CLEC");
$chrom=Array("5", "1", "10", "5", "6", "16", "18" ,"1", "7"); #, "16");
#$widthA=Array("2", "4", "6", "8", "10");
$testModes=Array("CrossValidation_fold5", "Training");
$testModes=Array("Holdout");
echo "<table>";
for ($cont=0; $cont<sizeof($chrom); $cont++)
{
$fileGWAS=$files[$cont];
#for ($width=0; $width<sizeof($widthA); $width++)
{
echo "\n<tr><td>Width: ";
echo $w;
echo "</td></tr>";
echo "<tr><td>".$files[$cont]."</td></tr>";
foreach ($testModes as $testMode)
{
//echo "<tr><td>".$testMode."</td></tr><tr>";
for ($type=0; $type<2; $type++)
{
if ($type==0) echo "<tr>";
echo "<td>";
if ($type==0) echo "<h4>Affected</h4>"; else echo "<h4>Unaffected</h4>";
echo "</td>";
if ($type==1) echo "</tr><tr>";
}
for ($type=0; $type<2; $type++)
{
echo "\n<td><img src=\"results/realSamples/";
if ($type==0)
echo "ms_".$chrom[$cont]."CEU".$month.$year.$fileGWAS.$phased;
else echo "chromosome_".$chrom[$cont]."CEU".$month.$year.$files[$cont].$phased;
#echo  "_onlyKnownNull";
echo "_resultsForTestMode".$testMode."_SWOfSize".$w."AndOffsetOf1";
echo ".csvFunction.png\"  border=0></td>\n";
if ($type==1) echo "</tr>";
}
echo "</tr>";
}
}
}
?>
</table>

</body>
</html> 

