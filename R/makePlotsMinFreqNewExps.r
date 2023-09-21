rm(list=ls()) #Remove objects used in previous programs. Like reseting the memory
source("plotFunctionNewExps.r") # Function in charge of actually painting the graphs


getYFirst<-function(data, range, selectedRows,offset)
{
min=1
for (i in 1:length(selectedRows))
for (j in 1:length(range))
if (data[selectedRows[i],range[j]*4+offset+1]<min) min=data[selectedRows[i],range[j]*4+offset+1]
if (min>0) min=min-min(0.01, min)
min
}

getYLast<-function(data, range, selectedRows,offset)
{
max=0
for (i in 1:length(selectedRows))
for (j in 1:length(range))
if (data[selectedRows[i],range[j]*4+offset+1]>max) max=data[selectedRows[i],range[j]*4+offset+1]
if (max<1) max=max+min(0.01, 1-max)
max
}


findDataRow<-function(testModel, haplotypeWidth, relativeRisk, diseaseModel, data, recombinations)
{
   # browser()
    found = 1
    selectedData<-c(1:length(recombinations))

        # numberOfRows represents the total number of values for each test. Calculated as the number of values in column 1.
        numberOfRows=length(data[,1])

                                for (i in 1:(numberOfRows)) # for each row
                                if (data[i,1]==testModel && data[i, 3]==relativeRisk  && data[i, 2]==diseaseModel && data[i, 4]==haplotypeWidth && data[i,5]==recombinations[found] && found<=length(recombinations))
{
    selectedData[found]=i
                                    found<-found+1
                                }

    if (found<(length(recombinations)+1)) selectedData<-c(0);
selectedData
}


############
# Init variables
############

        # Select font

        foo <- getOption("X11fonts")
        foo[1] <- "-urw-nimbus sans l-%s-%s-*-*-%d-*-*-*-*-*-*-*"
        options(X11fonts=foo)
       # dev.set() 
	


        # Root directory
        basicDir<-"../results/simulations/"
        dir=basicDir
        dir2<-"simulationsDiffGeneral"
        #chiSquare="ChiSquare"
       # sizeT="_Size200"
type="Holdout"
type="Training"

 #       recombinations<-c(0.0000000, 0.0000500, 0.0001000, 0.0002000, 0.0004000, 0.0008000, 0.0016000, 0.0032000)

 recombinations<-c(0.0000000, 0.0000500, 0.0001000, 0.0001500, 0.0002000) #, 0.0002500, 0.0003000) #0.0004000)

# recombinations<-c(0.0000000, 0.0000500, 0.0001000, 0.0002000, 0.0003000) #, 0.0004000)

            
        # dataSource is the name of the file to read
        dataSource<-paste("resultsPowerOneBlocksimulationsDiffAfricanLowRisk_AlsoHomo_OnlyHetero_Size500", type, sep="")


##################
# End of Init variables
##################


############
# Reading data
############

# All data for the graphs is stored in a table like file (csv).
        
        print(paste(dir, dataSource, ".csv", sep=""))
        data=read.table(paste(dir, dataSource, ".csv", sep=""), header=TRUE)

        
############
#  End of reading data
############








      



confidences<-c(1,0)
  	#confidence=0 # alpha=0.01
        #confidence=1# alpha=0.05


testModels<-c("PowerOneLocus", "PowerTwoLoci", "PowerTwoLoci")

        haplotypeWidths <-c("1", "2", "4", "6", "8", "10");
#haplotypeWidths<-c("10")
        RR<-c(2,4,6,8,10)
RR<-c(1.2,1.6,2,2.4,2.6)
 

	offset=5
    for (confidence in confidences)
{

  offset=offset+confidence

        oneGeneModel<-1
        for(testModel in testModels){
    if (testModel=="PowerOneLocus") 
{
diseaseModelsCaption<-c("Additive"="Additive", "DomOrDom"="Dominant",  "RecOrRec"="Recessive")
diseaseModels<-c("Additive", "DomOrDom",  "RecOrRec")
}       
else
{
if (oneGeneModel==1)
{
diseaseModelsCaption<-c("Additive"="Additive", "DomOrDom"="DomOrDom",  "RecOrRec"="RecOrRec")
diseaseModels<-c("Additive", "DomOrDom",  "RecOrRec")
}
else 
{
diseaseModelsCaption<-c("DomAndDom"="DomAndDom", "Threshold"="Threshold",  "Modified"="Modified")
diseaseModels<-c("DomAndDom", "Threshold",  "Modified")
}
}  




  

        for ( haplotypeWidth in haplotypeWidths ){

dev.set() 

png("text", bg="white", width=1800, height=1800)

        par(mfcol=c(3,length(RR)))

                for (relativeRisk in RR){                        
                    for ( diseaseModel in diseaseModels){
                        # Look for the data for the configuration
                        selectedRows = findDataRow(testModel, haplotypeWidth, relativeRisk, diseaseModel, data, recombinations)
                      
                        if ( length(selectedRows) >= 0) { # Si existen los datos que buscamos

                                # Graph data and captions
                                title=paste(diseaseModelsCaption[[diseaseModel]], " ", " - Relative risk ", relativeRisk, " - length ", haplotypeWidth, sep="")
                                xLabels = recombinations
                                yAxis<-c((0:10)*0.1)

                                
                                # Paint graph
write (title, "")


if (type=="Training")
range<-c(0,1,2,3)
#range<-c(1+desp,3+desp, 17) 
else range<-c(0,1,2) #0:2 holdout for 2G and score respectively


#  0: 2G cv5, 1: 2Gcv5distances, 2: TDT1cv5, 3: TDT1cv5distances, 4: TDT1Tcv5, 5: TDT1Tcv5distances, 6: TDT1Ucv5, 7: TDT1Udistances, 8: 2G cv5, 9: 2Gcv5distances, 10: TDT1cv5, 11: TDT1cv5distances, 12: TDT1Tcv5,13: TDT1Tcv5distances, 14: TDT1Ucv5, 15: TDT1Ucv5distances, 16: TDT, 17: ScoreTDT
#range<-c(8,9,10,11) 

#yFirst=getYFirst(data, range, selectedRows, offset)
#yLast=getYLast(data, range, selectedRows, offset)
yFirst=0
yLast=1
makeOnePlot(1:length(recombinations), data, selectedRows, range, "Recombination fraction", "Association rate", yFirst, yLast, xLabels, title, offset, type) 




                            } # end for each row with recomb 0 (first group of rows)


                   } # for diseaseModels
                } # for RR 






                            #dev2bitmap(paste(dir, "plots/", dataSource, testModel, ".jpg", sep=""), type="jpeg", width=12, height=6)
                            #dev2bitmap(paste(dir, "plots/", dataSource, testModel, ".pdf", sep=""), type="pdfwrite", width=12, height=6)
 


#name=paste(dir,"simulationsBOneLocuspTDTAlpha95Length", 10, ".png", sep="")
#write ("now","")
                          #  dev2bitmap(name, type="png256", width=300, height=200) 

#bitmap(name, bg="white", width=80, height=30)
#dev.off()
#graphics.off()







name=paste(dir, "simulationsLowRisk", sep="")
if (type=="Holdout") name=paste(dir, "Holdout", sep="")
if (testModel=="PowerOneLocus")
name=paste(name,"OneLocus",sep="") else
{
name=paste(name,"TwoLoci",sep="")
if (oneGeneModel)  name=paste(name,"A",sep="") else  name=paste(name,"B",sep="")
}

#if (desp==0 && type=="Training") name=paste(name,"cv5ForMultipleTest",sep="")
#if (desp==1 && type=="Training")  name=paste(name,"cv2ForMultipleTest",sep="")
 name=paste(name, "Length", haplotypeWidth, "Alpha", sep="")
if (confidence==0) name=paste(name, "01",sep="") else name=paste(name, "05",sep="")


name=paste(name, ".png", sep="")
write(name,"")

#bitmap(name, type="png256", width=1200, height=1200) 
                      
command=paste("mv text ", name, sep="") 
 
system(command)

dev.off()
graphics.off()


            } # for haplotypeWidths

if (oneGeneModel==1 && testModel=="PowerTwoLoci") oneGeneModel=0

        } # for testModels

} # for confidences








