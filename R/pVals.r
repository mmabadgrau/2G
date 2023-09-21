
args <- commandArgs(trailingOnly = TRUE)

write(args, "")
foo <- getOption("X11fonts")
foo[1] <- "-urw-nimbus sans l-%s-%s-*-*-%d-*-*-*-*-*-*-*"
options(X11fonts=foo)

#options("device")
fileconts<-args[5]
yl<-as.numeric(args[6])
write(yl, "")
filea<-args[1]
write ("here", "")
write (filea, "")
#filea<-paste(filea, "_onlyKnownNull", sep="")
#if (args[5]==0) file<-paste(file, "_AlsoHomo", sep="")
colors<-c("yellow", "pink", "violet", "orange", "aquamarine", "green", "cyan", "brown", "purple", "red","blue", "black", "brown", "aquamarine", "red")
colors<-c("red", "blue", "purple", "orange", "red", "orange", "aquamarine", "green", "brown", "black", "red", "blue", "blue")
hea<-c("tTDT", "suTDT", "Yate", "Yate1", "YateProp", "YateProp1", "Laplace1", "Laplace2", "Grouping", "singleTDT", "exactTDT", "exactPropTDT", "TDTminFreq10")
#file1<-paste(filea, args[2], sep="")

file2<-paste(filea, args[2], sep="")
#data1<-read.table(file1, header=TRUE)
#write(file1, "")
write ("written", "")
write("now trying ", "")
write(file2, "")
data2<-read.table(file2, header=TRUE)
#write(file2, "")
write ("written", "")
#data1
#data2
pchA<-c(1,0,2)
fileR<-paste(file2, "Function.png", sep="")
png(fileR, bg="white", width=600, height=600)
xLabels<-c(1:length(data2[,1]))
data2<--log10(data2)
#logs<-data2[,1] # c(1:length(data2[,1]))*0+yl
#for (a in 1:length(data2[1,]))
#if (-log10(data2[a,1]) < yl)
#logs[a]<--log10(data2[a,1])
#plot(xLabels, -log10(data2[,1]), type="l", lty=1, main=paste(args[3], args[4], sep="-"), col="white", xlab="initial SNP in window", ylab="-log(p value)", ylim=c(0,10), axes=TRUE) else
plot(xLabels, data2[,1], type="l", lty=1, main=paste(args[3], args[4], sep="-"), col="white", xlab="initial SNP in window", ylab="-log(p value)", ylim=c(0,yl), axes=TRUE) #, asp=20.5 LD 

if (length(data2[1,])==2)
colors<-c("red", "blue")
for (l in 1:(length(data2[1,])))
#if ((l>(length(data1[1,])-4) ) && l<(length(data1[1,])-2))
#if (l<3 || l==9 || l==11) # || l==13)
{
logs<-data2[,l] # c(1:length(data2[,1]))*0+yl
for (a in 1:length(logs))
if (logs[a] > yl)
logs[a]<-yl

lines(xLabels,logs, type="b", col=colors[l], pch=pchA[l], lty=1, cex=2)#also homo
#lines(xLabels, data1[,l], type="l", pch=22,lty=2, col=colors[l]);
#if (l==11) lines(xLabels, data2[,l], type="l", col="green");
write(file2, "")
write("pVal<01", "")
write(length(data2[data2<0.05 & data2>=0,l]), fileconts)
write("pVal<05", "")
write(length(data2[data2<0.01 & data2>=0,l]), fileconts)
}

alpha<-0.05+c(0*(1:length(xLabels)))
#lines(xLabels, alpha, type="o", col="black")

extra <- ""
#legend(0, 1, colnames(data), cex=0.8, col=colors, lty=1);
#legend(0, length(N), N, col=colors);
#fileR<-paste(file, "Function.png", sep="")
dev.off()
#dev2bitmap(fileR, type="png256", width=12, height=6) 
write("Results written in", "")
write(fileR, "")
#fileR<-paste(file, "Function.jpg", sep="")
#dev2bitmap(fileR, type="jpeg", width=12)

#fileR<-paste(file, "Function.pdf", sep="")
#dev2bitmap(fileR, type="pdfwrite", width=12)
#dev2bitmap(paste(dir, "plots/", dataSource, model, ".pdf", sep=""), type="pdf", width=12)



