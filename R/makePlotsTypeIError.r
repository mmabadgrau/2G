rm(list=ls()) #Remove objects used in previous programs. Like reseting the memory
source("plotFunctionTypeI.r") # Function in charge of actually painting the graphs

	offset=3
  	confidence=0 # alpha=0.01
       # confidence=1# alpha=0.05

alpha<-c(0.01, 0.05)


findDataRow<-function(MAF, mixProp)
{


    found<-0

   # browser()

    selectedData<-c(1:length(haplotypeWidths))

        # numberOfRows represents the total number of values for each test. Calculated as the number of values in column 1.
        numberOfRows=length(data[,1])


                                for (i in 1:(numberOfRows)) # for each row
                                {
                                if (data[i,2]==mixProp && data[i, 1]==MAF && data[i,3]==haplotypeWidths[found+1] && found<length(haplotypeWidths))
																{
																	selectedData[found+1]=i
                                  found<-found+1
                                }

                                }
    if (found<(length(haplotypeWidths))) 
{
write("found","")
write (found, "")
write ("no data were chosen for", "")
write("maf","")
write(MAF,"")
write("mixprop","")
write(mixProp,"")
write (selectedData, "")
selectedData<-c(0);

exit
}
selectedData
}


############
# Init variables
############

        # Select font

     #   foo <- getOption("X11fonts")
#        foo[1] <- "-urw-nimbus sans l-%s-%s-*-*-%d-*-*-*-*-*-*-*"
#        options(X11fonts=foo)
#        dev.set() 
	


        # Root directory
        basicDir<-"../results/simulations/"
        dir=basicDir



            
        # dataSource is the name of the file to read
        dataSource<-paste("resultsTypeIOneBlocksimulationsDiffAfricanLongHaps_AlsoHomo_OnlyHetero_Size500", sep="")




############
# Reading data
############

# All data for the graphs is stored in a table like file (csv).
        

        data=read.table(paste(dir, dataSource, ".csv", sep=""), header=TRUE, row.names=NULL)
                        

############
#  End of reading data
############





testModel<-"TypeIError"



        MAFs<-c(0.1, 0.3, 0.5)
        haplotypeWidths <-c(1, 2, 4, 6, 8, 10);
   #haplotypeWidths <-c(10);
        mixProps<-c(0.5, 0.75, 0.833)

confidences<-c(0,1)
offset=3
  for(confidence in confidences){

if (confidence==0) alpha=0.01
if (confidence==1) alpha=0.05



dev.set() 

png("text", bg="white", width=900, height=900)

        par(mfcol=c(length(MAFs),length(mixProps)))
  






                for (mixProp in mixProps){     


        for ( MAF in MAFs ){                   

                        # Look for the data for the configuration

                        selectedRows = findDataRow(MAF, mixProp)
                      
                        if ( length(selectedRows) >= 0) { # Si existen los datos que buscamos

                                # Graph data and captions
                                title=paste(testModel, " ", " - MAF ", MAF, " - mix prop ", mixProp, " - alpha ", alpha, sep="")
                                xLabels = haplotypeWidths
                                yAxis<-c((0:1000)*0.01)

                                
                                # Paint graph
#write (title, "")




yFirst=0
yLast=alpha*2
#write(selectedRows,"")

makeOnePlot(1:length(haplotypeWidths), data, selectedRows,  "haplotype length", "Association rate", yFirst, yLast, xLabels, title, offset, confidence) 




                            } # end for each row with recomb 0 (first group of rows)

            } # for MAF
                   } # for mixProp






name=paste(dir, "simulationsTypeIError", sep="")
name=paste(name, "Alpha", sep="")
if (confidence==0) name=paste(name, "01",sep="") else name=paste(name, "05",sep="")


name=paste(name, ".png", sep="")
write(name,"")

#bitmap(name, type="png256", width=1200, height=1200) 
                      
command=paste("mv text ", name, sep="") 
 
system(command)

dev.off()
graphics.off()

} # for each confidence











