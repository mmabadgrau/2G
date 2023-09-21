


getColumnIndex<-function(measure, test, totalMeasures)
{
columnIndex<-(measure-1)*4+offset+1+confidence
if (test==2) #Halftraining
columnIndex<-columnIndex+totalMeasures*4
if (test==3) #Training
columnIndex<-(measure-1)*4+offset+1+confidence+totalMeasures*8
columnIndex
}

makeOnePlot<-function(xAxis, data, selectedRows, xLab, yLab, yFirst, yLast, xLabels, title, offset, confidence)
{
totalMeasures=(length(data[1,])-offset)/12
write (totalMeasures, "")
colors<-c("blue", "green", "red","blue", "green", "red", "blue", "green", "red")
#ScoreTDT mTDT1T mTDT2G


ltyA<-c(1,2,3,4,5,6, 1, 3,2, 1,1,2,3,4, 6, 8, 4, 1,2,3,4,5,6, 5, 5)
pchA<-c(1,2,3,4,5,6, 21, 22,23, 21, 1,2,3,4, 10, 25, 24, 1,2,3,4,5,6, 10, 10)
cexA<-c(1,2,3,4,5,6, 2, 2,2, 2, 1,2,3,4, 2, 2, 2, 1,2,3,4,5,6, 2, 2)





selectedData<-c(1:length(selectedRows))

for (i in 1:length(selectedRows))
{
selectedData[i]=data[selectedRows[i],getColumnIndex(1,1,totalMeasures)]
}
#write("beforeplot","")
#write(xAxis,"")
#write(selectedData,"")
#write(xLab,"")
#write(yLab,"")

    plot(xAxis, selectedData, type="l", main=title, col="white",xlab=xLab, ylab=yLab, ylim=c(yFirst,yLast), axes=FALSE) #, 
#write("afterplot","")

    axis(1, at=xAxis, lwd=1, labels=xLabels, tick=TRUE, outer=FALSE)
    axis(2, at=yAxis, lwd=1, labels=yAxis, tick=TRUE, outer=FALSE)


for (t in 1:totalMeasures)
for (j in 1:3)
if (j!=2)
if ((t==3 && j==1) || t!=3)
{   
columnIndex= getColumnIndex(t, j, totalMeasures);
	for (i in 1:length(selectedRows))
	selectedData[i]=data[selectedRows[i],columnIndex]
#	write (ltyA[columnIndex],"")
#	write (pchA[columnIndex],"")
#	write (cexA[columnIndex],"")
#	write (colors[columnIndex],"")
write(title, "")
write("selected rows:","")
write(selectedRows,"")
write("measure is:","")
write(t,"")
write("testing method is:","")
write(j,"")
#write("col is:","")
#write(getColumnIndex(t, totalMeasures),"")
write(selectedData,"")

if (j==1) 
lines(xAxis, selectedData, type="l",col=colors[t])# type="b"
else 
lines(xAxis, selectedData, type="l",col=colors[t],  lty=2, pch=10, cex=2)# type="b"
m<-c(1:length(selectedRows))*0
if (confidence==0) 
m<-m+0.01
else 
m<-m+0.05
lines(xAxis, m, type="l",col="black")
}
}



