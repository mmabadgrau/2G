makeOnePlot<-function(xAxis, data, selectedRows, columnIndexes, xLab, yLab, yFirst, yLast, xLabels, title, offset, paper)
{

colors<-c("red", "violet", "blue", "cyan", "pink",  "brown", "violet", "blue","purple", "purple", "black", "blue", "yellow", "yellow", "white", "black", "brown", "white", "white","white","white","white","white","purple","violet")

hea<-c("YateAlpha1", "YateAlpha2", "YatePAlpha1", "YatePAlpha2", "LaplaceAlpha1", "LaplaceAlpha2", "2G", "scoreTDT", "mTDT", "TDTP", "TDTPWithHomo", "mTDTminFreq10", "TDTPminFreq10", "TDTPWithHomominFreq10","EntropyTDT", "LengthContrast",  "SignedRank", "variance", "LD", "variance", "LD", "variance", "LD", "TDTpermutations100", "EntropyTDTpermutations100") # from 19 to 28

ltyA<-c(1,2,3,4,5,6, 1, 3,2, 1,1,2,3,4, 6, 8, 4, 1,2,3,4,5,6, 2, 5)
pchA<-c(1,2,3,4,5,6, 21, 22,23, 21, 1,2,3,4, 10, 25, 24, 1,2,3,4,5,6, 10, 10)
cexA<-c(1,2,3,4,5,6, 2, 2,2, 2, 1,2,3,4, 2, 2, 2, 1,2,3,4,5,6, 2, 2)




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


if (!paper)
lines(xAxis, selectedData, type="l",col=colors[columnIndex+1])#single TDT
else lines(xAxis, selectedData, type="b",  pch=pchA[columnIndex+1], lty=ltyA[columnIndex+1], cex=cexA[columnIndex+1],col=colors[columnIndex+1]) # hetero in samples with also homo



#lines(xAxis, selectedData1, type="l",col=colors[columnIndex+1])#single TDT
#lines(xAxis, selectedData2, type="b",  pch=23, lty=1, cex=2,col=colors[columnIndex+1])

    
#lty=ltyA[columnIndex+1]  ) #
}

}



