data<-read.csv("data.csv",header=T,stringsAsFactor=F)
data<-subset(data,階層化_結果!="判定不能")
tmp<-1:nrow(data)
tmp<-t(t(tmp))
colnames(tmp)<-"ID"
data<-cbind(data,tmp)

c<-c(1:3,5,6:22,24,27,29:32,37)
data2<-data[c]
data2$階層化_結果[data2$階層化_結果=="情報提供"]<-1
data2$階層化_結果[data2$階層化_結果=="動機づけ支援"]<-2
data2$階層化_結果[data2$階層化_結果=="積極的支援"]<-3
data2.om<-na.omit(data2)
for(i in 1:dim(data2)[2]){
    if( i != 3 ){
    data2[,i]<-as.integer(data2[,i])
    data2.om[,i]<-as.integer(data2.om[,i])
    }
}

data.om<-subset(data,ID%in%data2.om$ID)
write.csv(data.om,"data.om.csv",quote=F,row.names=F)
