makeOnePlot<-function(xAxis, data, selectedRows, columnIndexes, xLab, yLab, yFirst, yLast, xLabels, title, offset, type, paper=0)
{
#if (type=="Training")
colors<-c("red", "purple", "blue", "green", "pink",  "brown", "violet", "blue","cyan", "red", "black", "green", "yellow", "yellow", "yellow", "yellow", "yellow", "blue")
#else
#colors<-c("red", "blue", "purple", "aquamarine", "pink",  "brown", "violet", "blue","cyan", "red", "black", "green", "red", "yellow", "green", "yellow", "yellow", "blue", "blue", "blue")

hea<-c("2Gcv5", "2Gcv5distances","TDT1cv5","TDT1cv5distances", "TDT1Tcv5", "TDT1Tcv5distances", "TDT1Ucv5", "TDT1Ucv5distances", "2Gcv2", "2Gcv2distances", "TDT1cv2", "TDT1cv2distances", "TDT1Tcv2", "TDT1Tcv2distances", "TDT1Ucv2", "TDT1Ucv2distances", "mTDT", "scoreTDT", "scoreTDTdistances", "scoreTDTminFreq10", "scoreTDTminFreq10distances") # from 19 to 28


ltyA<-c(1,1,1,1,1,6, 1, 3,2, 1,1,2,3,4, 6, 8, 4, 3,2,3,4,5,6, 5, 5, 1, 2,3,4,5)
pchA<-c(1,2,0,1,5,6, 21, 22,23, 21, 1,22,21,2, 22, 25, 24, 23,23,23,25) # 1: circle; 2: triangle, 3: latin cross, 4 cross, 5: diamond, 0: squares
cexA<-c(2,2,2,2,2,2, 2, 2,2, 2, 2,2,2,2, 2, 2, 2, 2,2,2,2,2)


#lines(x, data[first:second, offset+9*4], type="b", lty=5, pch=10, cex=2, col="violet")#entropy TDT
#lines(x, data[first:second, offset+16*4], type="b", pch=21, cex=2, lty=1, col="red")# grouping TDT
#lines(x, data[first:second, offset+17*4], type="b", pch=22, lty=3, cex=2, col="green")#single TDT
#lines(x, data[first:second, offset+18*4], type="b", pch=23, cex=2, lty=2, col="blue")#exact TDT
#lines(x, data[first:second, offset+0*4], type="b", pch=24, cex=2, lty=4, col="brown")#similarity
#lines(x, data[first:second, offset+1*4], type="b", pch=25, cex=2, lty=6, col="black")#rank test wilcoxon



selectedData<-c(1:length(selectedRows))

for (i in 1:length(selectedRows))
selectedData[i]=data[selectedRows[i],columnIndexes[1]*4+offset+1]




    plot(xAxis, selectedData, type="l", main=title, col="white",xlab=xLab, ylab=yLab, ylim=c(yFirst,yLast), axes=FALSE) #, 

    axis(1, at=xAxis, lwd=1, labels=xLabels, tick=TRUE, outer=FALSE)
    axis(2, at=yAxis, lwd=1, labels=yAxis, tick=TRUE, outer=FALSE)


   # colorIndex=0;
    for (columnIndex in columnIndexes){        
        #browser()


for (i in 1:length(selectedRows))
selectedData[i]=data[selectedRows[i],columnIndex*4+offset+1]

write (paste(hea[columnIndex+1]," in ",colors[columnIndex+1], ": ",sep=""),"")

write(selectedData,"")

#write (title, "")
#write (paste (hea[columnIndex+1]," is", ""),"")
#write(selectedData[, offset+columnIndex*4+1], "")



# lines(xAxis, selectedData, type="b", col=colors[columnIndex+1])# hetero in samples with also homo

#write (ltyA[columnIndex+1],"")
#write (pchA[columnIndex+1],"")
#write (cexA[columnIndex+1],"")
# lty=ltyA[columnIndex+1],
if (type=="Training")
{
if (!paper)
lines(xAxis, selectedData, type="l",col=colors[columnIndex+1])#single TDT
else lines(xAxis, selectedData, type="b",  pch=pchA[columnIndex+1], cex=2,col=colors[columnIndex+1], lty=1) # hetero in samples with also homo
}
else # Reproducibility
{
if (!paper)
{
if (columnIndex<=3) # Holdout
lines(xAxis, selectedData, type="l",col=colors[columnIndex+1])#
#else lines(xAxis, selectedData, type="o",col=colors[columnIndex+1], lty=2)#halftraining
}
else #paper
if (columnIndex<=3) # Holdout
lines(xAxis, selectedData, type="b",pch=pchA[columnIndex+1], cex=2,col=colors[columnIndex+1], lty=1)#
#else 
#lines(xAxis, selectedData, type="b",  pch=pchA[columnIndex+1], cex=2,col=colors[columnIndex+1], lty=2) # hetero in samples with also homo
}
    
#lty=ltyA[columnIndex+1]  ) #
}

}



