<html>
<head>

<?php include($_SERVER['DOCUMENT_ROOT'].'/readlanguage.php');$idioma=readLanguage("es");?>
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
$EMDist=Array("OneDistr", "UTDistr");
$EMRest=Array("NoRestriction", "TriosBasedRestriction");
$PhaseMethod=Array("IgnoreUnknownPhase", "EM-Max", "EM-Freq");
echo "<a href=\"tdtCont.php?month=".$month."&year=".$year."&ext=".$PhaseMethod[0]."_".$EMDist[0]."_".$EMRest[0].".cal&phased=Phased\">"."Phase solved with EM-Max UTDistr, TriosBasedRestriction".$PhaseMethod[0].", ".$EMDist[0].", ".$EMRest[0]."</a><br>";
/*for ($ED=0; $ED<sizeof($EMDist); $ED++)
for ($EM=0; $EM<sizeof($EMRest); $EM++)
for ($P=0; $P<sizeof($PhaseMethod); $P++)
echo "<a href=\"tdtCont.php?month=".$month."&year=".$year."&ext=".$PhaseMethod[$P]."_".$EMDist[$ED]."_".$EMRest[$EM].".cal\">".$PhaseMethod[$P].", ".$EMDist[$ED].", ".$EMRest[$EM]."</a><br>";
*/
?>
</table>

</body>
