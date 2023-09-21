makeOnePlot<-function(xAxis, data, selectedRows, columnIndexes, xLab, yLab, yFirst, yLast, xLabels, title, offset)
{

colors<-c("green", "green", "cyan", "cyan", "purple",  "darkred", "green", "green","blue", "red", "cyan", "black", "pink", "brown", "violet", "black", "brown", "green", "blue", "green", "aquamarine", "brown", "green", "violet", "violet")
hea<-c("Yate", "Yate1", "YateProp", "YateProp1", "Laplace1", "Laplace2", "Grouping", "singleTDT", "exactTDT", "exactPropTDT", "propTDTWithHomo", "TDTminFreq10", "propTDTminFreq10", "propTDTWithHomominFreq10", "EntTDT", "LC", "SR",
"green", "blue", "green", "aquamarine", "brown", "green", "permEntTDT", "permEntTDT") # from 19 to 28

ltyA<-c(1,2,3,4,5,6, 1, 3,2, 1,1,2,3,4, 6, 8, 4, 1,2,3,4,5,6, 5, 5)
pchA<-c(1,2,3,4,5,6, 21, 22,23, 21, 1,2,3,4, 10, 25, 24, 1,2,3,4,5,6, 10, 10)
cexA<-c(1,2,3,4,5,6, 2, 2,2, 2, 1,2,3,4, 2, 2, 2, 1,2,3,4,5,6, 2, 2)








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


write(selectedData,"")

#write (title, "")
#write (paste (hea[columnIndex+1]," is", ""),"")
#write(selectedData[, offset+columnIndex*4+1], "")



# lines(xAxis, selectedData, type="b", col=colors[columnIndex+1])# hetero in samples with also homo

write (ltyA[columnIndex+1],"")
write (pchA[columnIndex+1],"")
write (cexA[columnIndex+1],"")
write (colors[columnIndex+1],"")


lines(xAxis, selectedData, type="l",col=colors[columnIndex+1])#single TDT
#lines(xAxis, selectedData, type="b",  pch=pchA[columnIndex+1], lty=ltyA[columnIndex+1], cex=cexA[columnIndex+1],col=colors[columnIndex+1]) # hetero in samples with also homo
    
#lty=ltyA[columnIndex+1]  ) #
}

}



