<?

header("Content-Type: image/png");
include('/home/mabad/www/php/plots.php');

//Ejem: http://bios.ugr.es/bioinformaticsApps/LDTDT/plots/makeRealPlots.php?file=crohnOriginal.multEM-Freq &width=10&measure=1&alpha=99
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<hTML>
<HEAD>
	<TITLE>LD Heatmap.</TITLE>
	<META name="description" content="International HapMap Project, SNP, Mendelian errors">
	<META name="keywords" content="International HapMap Project SNP Mendelian errors">
	<META content="3 days" name=Revisit>
	<META content=all name=robots>
	

</HEAD>

<BODY>
<?

//echo gd_version();

if ($argc<4)
{
echo "Error in the number of arguments";
exit(0);

}
if ($argv)
  {

for ($i=1;$i<count($argv);$i++)
   {
       $it = split("=",$argv[$i]);
       $_GET[$it[0]] = $it[1];
   }
}

$file=$_GET["file"];
$fileExt=$_GET["fileExt"];
$alpha=$_GET["alpha"];// equal to 0 means gradual shown

$hapLength=10;
if (isset($_GET["hapLength"]))
$hapLength=$_GET["hapLength"];

$onlyFound=0;
if (isset($_GET["onlyFound"]))
$onlyFound=$_GET["onlyFound"];

$noBlocks=false;
if (isset($_GET["noBlocks"]))
$noBlocks=$_GET["noBlocks"];
$noBorder=false;
if (isset($_GET["noBorder"]))
$noBorder=$_GET["noBorder"];
$onlyFound=false;
if (isset($_GET["onlyFound"]))
$onlyFound=$_GET["onlyFound"];
$validation[0]=false;
if (isset($_GET["hwe"]))
$validation[0]=$_GET["hwe"];
$validation[1]=false;
if (isset($_GET["men"]))
$validation[1]=$_GET["men"];
$validation[2]=false;
if (isset($_GET["mis"]))
$validation[2]=$_GET["mis"];

$fileChrom="";
if (isset($_GET["fileChrom"]))
$fileChrom=$_GET["fileChrom"];

$fileSecond="";
if (isset($_GET["fileSecond"]))
$fileSecond=$_GET["fileSecond"];
$totalSources=1;
if ($fileSecond!="") $totalSources=2;

$type="";
if (isset($_GET["type"]))
$type=$_GET["type"];


$distance="";
if (isset($_GET["distance"]))
$distance=$_GET["distance"];



$sizeSNP=15;
$annotationHeight=$sizeSNP*3; //5;
$totalValidation=$annotationHeight;
for ($i=0; $i<3; $i++)
if ($validation[$i]) $totalValidation=$totalValidation+$sizeSNP*2;




///////////// read blocks ///////////////
if ($noBlocks==false)
{
$fileblock = strtok($file, "."); // SNP1
$fileblock=sprintf("%s.bl", $file);
if (file_exists($fileblock)==false)
{
echo "fileblock ".$fileblock." does not exist.";
exit(0);
}
$fp = fopen($fileblock, "r");
$line=fgets($fp, 100000);
$totalBlocks=0;
while(!feof($fp))
{
$row=split( " ", $line);
$firstSNP[$totalBlocks]=$row[0]-1;
//echo "\niniblock:".$firstSNP[$totalBlocks];
$line=fgets($fp, 100000);
$totalBlocks++;
}
fclose($fp);
}
/////////////////////////////////



$fileSource=$file.$fileExt.".csv";

if (file_exists($fileSource)==false)
{
echo "File ".$fileSource." does not exist.";
exit(0);
}

if ($fileSecond!="")
{
$fileSource2=$fileSecond.$fileExt.".csv";

if (file_exists($fileSource2)==false)
{
echo "File ".$fileSource2." does not exist.";
exit(0);
}
}


$fp = fopen($fileSource, "r");
$line=fgets($fp, 100000);
if (!feof($fp)) $head=split( " ", $line);
else
{
echo "\n<br>Error, file ".$fileSource." is empty\n<br>";
exit(0);
}
//echo "cad:".$head[sizeof($head)-1]."END\n";
$head[sizeof($head)-1]=trim($head[sizeof($head)-1]);
//echo "nowcad:".$head[sizeof($head)-1]."END\n";


#echo print_r($head);


$filepng = $file; // SNP1
//$filepng=strtok(null,".");
//echo "now".$filepng;
$filepng=$filepng.$fileExt;


$filepng=sprintf("%sAlpha%dTDT-2G.png", $filepng, $alpha);
if (file_exists($filepng)==true)
{
echo "Filepng ".$filepng." already exists and will be removed.";
unlink($filepng);
}
#echo $filepng;
//$totalRealMeasures=7;
//$totalRealMeasures=11+4;
$totalMeasures=sizeof($head);

$line=fgets($fp, 100000);
$count=0;
while(!feof($fp))
{
$rowTDT[$count]=split( " ", $line);
$line=fgets($fp, 100000);
$count++;
} 
fclose($fp);
$totalRealSNPs=sizeof($rowTDT);


// second file

if ($totalSources==2)
{
$fp = fopen($fileSource2, "r");
$line=fgets($fp, 100000);
if (!feof($fp)) $head2=split( " ", $line);
else 
{
echo "file ".$fileSource2." does not have data\n";
exit(0);
}
$head2[sizeof($head)-1]=trim($head2[sizeof($head)-1]);
$count=0;
$line=fgets($fp, 100000);
while(!feof($fp))
{
$rowTDT2[$count]=split( " ", $line);
$line=fgets($fp, 100000);
$count++;
} 
fclose($fp);
}

set_time_limit(0); 
$TotalSNPs=count(file($fileSource))-1;
//echo "\n<br>There are ".$TotalSNPs." SNPs in sample ".$fileSource."\n";
$offset=$sizeSNP;
//echo "TotalSNPs".$TotalSNPs.", size:".$sizeSNP.", total measures:".$totalMeasures.", total real SNPS: ".$totalRealSNPs.", total validations: ".$totalValidation."\n";
$image = imagecreatetruecolor($totalRealSNPs*$sizeSNP, $sizeSNP*$totalSources*($totalMeasures)+$totalValidation);



$white  = imagecolorallocate($image, 255, 255, 255);
$grey  = imagecolorallocate($image, 150, 150, 150);
$black  = imagecolorallocate($image, 0, 0, 0);
$green = imagecolorallocate($image, 0, 255, 0);
$red = imagecolorallocate($image, 255, 0, 0);
$blue = imagecolorallocate($image, 0, 0, 255);
$maroon=imagecolorallocate($image, 128, 0, 0);
$orange=imagecolorallocate($image, 255, 128, 0);
$purple=imagecolorallocate($image, 160, 32, 240);
$cyan=imagecolorallocate($image, 0, 255, 255);
$violet=imagecolorallocate($image, 238, 130, 238);
$darkOrange=imagecolorallocate($image, 238, 64, 0);
$salmon=imagecolorallocate($image, 255, 160, 122);
$pink=imagecolorallocate($image, 255, 20, 147);
$scarlet=imagecolorallocate($image, 140, 23, 23);




imageFilledRectangle($image, 0, 0, $totalRealSNPs*$sizeSNP, $sizeSNP*$totalSources*($totalMeasures)+$totalValidation, $white);


$validations=Array("hwe", "men", "mis");
$validationVals[0][0]=0;
for ($i=0; $i<3; $i++)
if ($validation[$i])
{
$fileValidation = strtok($file, "."); // SNP1
$fileValidation=sprintf("%s.%s", $fileValidation, $validations[$i]);
//echo "first".$fileValidation;
if (file_exists($fileValidation)==false)
{
echo "<br>\nasnoexistusing".$fileChrom;
$fileValidation = strtok($fileChrom, "."); // SNP1
echo "<br>\nandnosfilevalis".$fileValidation;
$fileValidation=sprintf("%s.%s", $fileValidation, $validations[$i]);
}

if (file_exists($fileValidation)==false)
{
echo "\n<br>fileValidation ".$fileValidation." does not exist.";
exit(0);
}
$fp = fopen($fileValidation, "r");
for ($s=0; $s<$TotalSNPs; $s++)
{
$validationVals[$i][$s]=fgets($fp, 100);
}
fclose($fp);
}
//echo $totalMeasures;
#exit (0);

#$order=Array(5, 6, 3, 4, 1, 2, 0, 7, 8); # for G2
#$order=Array(12,11,5,7,8,9,2,3,4,0,1,6,10);
#foreach ($order as $med) #=0; $med1<$totalMeasures;$med1++)
for ($med=0;$med<$totalMeasures; $med++)
#if ($head[$med]=="stTDT" || $head[$med]=="suTDT" || $head[$med]=="exactTDT" || $head[$med]=="Yate1" || $head[$med]=="YateProp" || $head[$med]=="YateProp1" || $head[$med]=="Laplace1" || $head[$med]=="Laplace2" || $head[$med]=="exactPropTDT" || $head[$med]=="entTDT"  || $head[$med]=="lc" || $head[$med]=="sr") 

//if ($head[$med]=="stTDT" || $head[$med]=="suTDT" || $head[$med]=="Grouping" || $head[$med]=="exactTDT" || $head[$med]=="entTDT" || $head[$med]=="lc" || $head[$med]=="sr") # for 2G
{
$vertDespl=$totalValidation+$sizeSNP+$sizeSNP*$totalSources*($med);//$sizeSNP*2;
for ($source=0; $source<$totalSources; $source++)
{
$count=0;

$fp = fopen($fileSource, "r");
$snpCount=0;

if ($source==1)
{
$vertDespl=$vertDespl+$sizeSNP;
$leftx2=0;
$lefty2=$vertDespl-2*$sizeSNP;
$values2 = array(
           $leftx2,  $lefty2,  // Point 1 (x, y)^M
           $leftx2, $lefty2+$sizeSNP, // Point 2 (x, y)^M
           $leftx2+$sizeSNP*($totalRealSNPs)-1, $lefty2+$sizeSNP, // Point 3 (x, y)^M
           $leftx2+$sizeSNP*($totalRealSNPs)-1, $lefty2  // Point 4 (x, y)^M
               );
imagefilledpolygon($image, $values2, 4, $grey);// or $color^M
}
for ($count=0; $count<$TotalSNPs; $count++)
{
$height=6;
//echo "Size is ".sizeof($rowTDT)."\n";
if (sizeof($rowTDT) < ($count+1))
echo "Trying to access to pos ".$count." when there are only ".sizeof($rowTDT)." positions\n";
//print_r($rowTDT[$count]);
$color2=$grey;
//print_r($rowTDT);
if ($source==0) $val=$rowTDT[$count][$med];
else $val=$rowTDT2[$count][$med];
$val=$val*10;
//$R=GetRed($val);$G=GetGreen($val);$B=GetBlue($val);
$color=$white;
if ($totalSources==2)
if ($head[$med] !=$head2[$med])
{
echo "Error, different formats";
exit(0);
}
switch ($head[$med])
{
case "LengthConstrastTest":$color=$black;break;// length: black
case "SignedRankTest":$color=$maroon;break;// signed rank: maroon
case "mTDT_usingPermutations":$color=$purple;break;// TDT: purple
case "mTDT_minFreq10.00000":$color=$blue;break;// TDT: purple
case "EntropyTDT_usingPermutations":$color=$violet;break;// ent TDT: cyan:
case "ScoreTDT".$type.$distance:$color=$blue;break;// ent TDT: cyan
case "mTDT2G".$type.$distance:$color=$red;break;// pTDT: violet
case "mTDT2GTree".$type.$distance:$color=$black;break;// pTDT: violet
case "mTDT".$type.$distance:$color=$purple;break;// TDT: purple
case "EntropyTDT_usingPermutations":$color=$violet;break;// ent TDT: cyan:
case "ScoreTDT_minFreq10.00000":$color=$blue;break;// ent TDT: cyan
case "ScoreTDT-HWE_minFreq10.00000":$color=$red;break;// pTDT: violet
case "mTDT1".$type.$distance:$color=$green;break;// p ent TDT: blue
/*case "stTDT":$color=$orange;break;// p ent TDT: blue
case "suTDT":$color=$pink;break;// p ent TDT: blue
case "Yate":$color=$green;break;// p ent TDT: blue
case "Yate1":$color=$green;break;// p ent TDT: blue
case "YateProp":$color=$cyan;break;// p ent TDT: blue
case "YateProp1":$color=$cyan;break;// p ent TDT: blue
case "Laplace1":$color=$purple;break;// p ent TDT: blue
case "Laplace2":$color=$scarlet;break;// p ent TDT: blue
case "Grouping":$color=$red;;break;// p ent TDT: blue
case "singleTDT":$color=$blue;;break;// p ent TDT: blue
case "exactTDT":$color=$blue;break;// p ent TDT: blue
case "exactPropTDT":$color=$red;break;// p ent TDT: blue
case "TDT10M":$color=$cyan;break;// p ent TDT: blue

//case "absVarTDT p:": $color=$yellow; break;
//case "
*/
default: echo "error, bad value: ".$head[$med]."FIN\n";
echo " from:";
print_r($rowTDT[$count]);
echo "\n"; exit(0); break;
}
#echo $color."and ".$usedMed."\n";
##$height=6;
if ($color==$white) $val=-1;
if ($val!=-1)
if  (($alpha==0 && $val*10>=5) || ($alpha>0 && $alpha/10<=$val)) {$val=0; $color2=$white;}
else 
{
$color2=$color;
if ($alpha>0) $height=6; else $height=(10-$val)*10-94;
}
if ($val>=0)
{
if ($height>6) 
{
echo "Error, height is: ".$height;
echo "val is: ".$val;
exit(0);
}
$SNP=$snpCount;//$row2[$b*$width];





$leftx=$SNP*$sizeSNP;
$lefty=$vertDespl-$sizeSNP;
$values = array(
           $leftx,  $lefty,  // Point 1 (x, y)
           $leftx, $lefty-$height*$sizeSNP/6, // Point 2 (x, y)
           $leftx+$sizeSNP, $lefty-$height*$sizeSNP/6, // Point 3 (x, y)
           $leftx+$sizeSNP, $lefty  // Point 4 (x, y)
               );
if ($source==0 || $color2!=$white) imagefilledpolygon($image, $values, 4, $color2);
if ($noBorder==0)
{
$leftx2=0;
$lefty2=$vertDespl-$sizeSNP;
$values2 = array(
           $leftx2,  $lefty2,  // Point 1 (x, y)
           $leftx2, $lefty2-$sizeSNP, // Point 2 (x, y)
           $leftx2+$sizeSNP*($totalRealSNPs)-1, $lefty2-$sizeSNP, // Point 3 (x, y)
           $leftx2+$sizeSNP*($totalRealSNPs)-1, $lefty2  // Point 4 (x, y)
               );
imagepolygon($image, $values2, 4, $black);// or $color
}
if ($med==0)
for ($i=0; $i<3; $i++)
{
if ($validation[$i])
{
$col=$maroon;
if ($i==1) $col=$violet;
if ($i==2) $col=$orange;
if ($validationVals[$i][$count]>1)
{
echo "error in validation\n";
exit(0);
}
if ($i==0) // HWE
if ($validationVals[$i][$count]>=0.95) $validationVals[$i][$count]=1; else $validationVals[$i][$count]=0;
//$validationVals[$i][$count]=1;
if ($validationVals[$i][$count]>=0)
{
$values = array(
           $leftx-$sizeSNP/5, $annotationHeight+$sizeSNP*($i)+($sizeSNP*$validationVals[$i][$count]),  // Point 1 (x, y)
           $leftx+$sizeSNP/5, $annotationHeight+$sizeSNP*($i)+($sizeSNP*$validationVals[$i][$count]), // Point 2 (x, y)
           $leftx+$sizeSNP/5, $annotationHeight+$sizeSNP*($i), // Point 3 (x, y)
           $leftx-$sizeSNP/5, $annotationHeight+$sizeSNP*($i) // Point 4 (x, y)
               );
imagefilledpolygon($image, $values, 4, $col );
}
// x axis
$values = array(
           $leftx-2*$sizeSNP, $annotationHeight+$sizeSNP*($i),  // Point 1 (x, y)
           $leftx-2*$sizeSNP, $annotationHeight+$sizeSNP*($i), // Point 2 (x, y)
           $leftx+2*$sizeSNP, $annotationHeight+$sizeSNP*($i), // Point 3 (x, y)
           $leftx+2*$sizeSNP, $annotationHeight+$sizeSNP*($i) // Point 4 (x, y)
);
imagepolygon($image, $values, 4, $black );
$col=$black;
}
}
$snpCount++;
} // end no single
} // end for each SNP
fclose($fp);
}
}// for each measure
$image=rotate_right90($image);
$snpCount=0;
for ($count=0; $count<$TotalSNPs; $count++)
{
$val=0;
{
$totalHeight=$sizeSNP*$totalSources*($totalMeasures)+$totalValidation;
imagestring($image, 1, $totalHeight-$annotationHeight/2, $snpCount*$sizeSNP, $count+1, $black); // SNP number^M
$snpCount++;
}
} 
$image=rotate_left90($image);
imagepng($image, $filepng);
imagedestroy($image);
//echo "\n<br>There are ".$snpCount." actual snps";
echo "\n<br>Image written in ".$filepng;
?>

</BODY>
</HTML>
