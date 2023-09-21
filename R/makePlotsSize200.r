rm(list=ls()) #Remove objects used in previous programs. Like reseting the memory
source("plotFunctionSize200.r") # Function in charge of actually painting the graphs


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
        sizeT="_Size200"


 #       recombinations<-c(0.0000000, 0.0000500, 0.0001000, 0.0002000, 0.0004000, 0.0008000, 0.0016000, 0.0032000)

 recombinations<-c(0.0000000, 0.0000500, 0.0001000, 0.0001500, 0.0002000, 0.0002500, 0.0003000, 0.0003500, 0.0004000, 0.0004500, 0.0005000)

# recombinations<-c(0.0000000, 0.0000500, 0.0001000, 0.0002000, 0.0003000, 0.0004000)

            
        # dataSource is the name of the file to read
        dataSource<-paste("resultsPowerOneBlocksimulationsDiffGeneralNewOnlyHetero", sizeT, "_minFreq10All", sep="")


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




testModels<-c("PowerOneLocus", "PowerTwoLoci", "PowerTwoLoci")
#testModels<-c("PowerTwoLoci")



confidences<-c(0,1)

        
#testModels<-c("PowerTwoLoci")
# testModels<-c("PowerOneLocus")
#testModels<-c("PowerTwoLoci")

      #  corrections<-c(0,1)
corrections<-c(0)

     #   diseaseModels<-c("Additive", "DomOrDom", "DomAndDom", "RecOrRec", "Threshold", "Modified")
        haplotypeWidths <-c("1", "2", "4", "6", "8", "10");
        RR<-c(2,4,6,8,10)
       # RR<-c(2)  
      #specify the grid of graphs: 3x#RR   (3 files by length(RR) columns)   
     #   totalVars=length(testModels)
      #  if (length(testModels)==2) totalVars=totalVars+1;

        for(confidence in confidences){
        offset=5+confidence
if (confidence==0) alpha=0.01
if (confidence==1) alpha=0.05
        for(correction in corrections){
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

png("text", bg="white", width=2000, height=1000)

        par(mfcol=c(3,length(RR)))

                for (relativeRisk in RR){                        
                    for ( diseaseModel in diseaseModels){

                        # Look for the data for the configuration
                        selectedRows = findDataRow(testModel, haplotypeWidth, relativeRisk, diseaseModel, data, recombinations)
                      
                        if ( length(selectedRows) >= 0) { # Si existen los datos que buscamos

                                # Graph data and captions
                                title=paste(diseaseModelsCaption[[diseaseModel]], " ", " - Relative risk ", relativeRisk, " - length ", haplotypeWidth, " - alpha ", alpha, sep="")
                                xLabels = recombinations
                                yAxis<-c((0:10)*0.1)

                                
                                # Paint graph
write (title, "")

if (correction==1) 
range<-c(1,3,4,5,9) else range<-c(7,8,24,15,16)

#yFirst=getYFirst(data, range, selectedRows, offset)
#yLast=getYLast(data, range, selectedRows, offset)
yFirst=0
yLast=1
makeOnePlot(1:length(recombinations), data, selectedRows, range, "Recombination fraction", "Association rate", yFirst, yLast, xLabels, title, offset) 




                            } # end for each row with recomb 0 (first group of rows)


                   } # for diseaseModels
                } # for RR 











name=paste(dir, "simulations", sep="")
if (correction) name=paste(name, "Correction", sep="")
if (testModel=="PowerOneLocus")
name=paste(name,"OneLocus",sep="") else
{
name=paste(name,"TwoLoci",sep="")
if (oneGeneModel)  name=paste(name,"A",sep="") else  name=paste(name,"B",sep="")
}
 name=paste(name, "Length", haplotypeWidth, "Alpha", sep="")
if (confidence==0) name=paste(name, "01",sep="") else name=paste(name, "05",sep="")


name=paste(name, ".png", sep="")
write(name,"")


                      
command=paste("mv text ", name, sep="") 
 
system(command)

dev.off()
graphics.off()


            } # for haplotypeWidths

if (oneGeneModel==1 && testModel=="PowerTwoLoci") oneGeneModel=0

        } # for testModels
} # for corrections
} # for confidences





