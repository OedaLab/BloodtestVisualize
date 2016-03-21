
library(plyr)
library(mclust)

#datに３年分揃っているものを入れる
#dat<-subset(data.om,受診年==2014|受診年==2013|受診年==2012)
#dp<-ddply(dat,.(番号),summarize,num=length(番号))
#dp<-subset(dp,num==3)
#dp<-t(t(dp$番号))
#colnames(dp)<-"番号"
#dat<-subset(dat,番号%in%dp)

#年度ごとにデータを分割し「薬なし情報提供」を健康グループとして追加
#2012年度時にそうであったものを抜き出す
#dat.2012<-subset(dat,受診年==2012)
#dat.2012<-subset(dat.2012,!(階層化_結果=="情報提供"&(服薬１_血圧==1|服薬２_血糖==1|服薬３_脂質==1)))

#num<-t(t(dat.2012["番号"]))
#colnames(num)<-"番号"
#dat<-subset(dat,番号%in%num)
PNGON   = 1
GCLASS  = 8
IFCLUST = 0

dat.2012<-subset(dat,受診年==2012 & 個人_性別_テキスト=="女")
dat.2013<-subset(dat,受診年==2013 & 個人_性別_テキスト=="女")
dat.2014<-subset(dat,受診年==2014 & 個人_性別_テキスト=="女")

dat.2013["階層化_結果"]<-dat.2012["階層化_結果"]
dat.2014["階層化_結果"]<-dat.2012["階層化_結果"]

kaisou<-c("情報提供","動機づけ支援","積極的支援")

pcac<-c(6:22,24,26,27)

###clustering
if( IFCLUST ){
for( year in 2012:2014){
    print(year)
    for( i in 1:3 ){
        assign(paste("class",i,".",year,sep=""),
               subset(get(paste("dat.",year,sep="")),階層化_結果==kaisou[i])[pcac])
        if( year == 2012 ){
            assign(paste("gmm",i,sep=""),
                   Mclust(get(paste("class",i,".",year,sep="")),G=GCLASS))
        }
    }
}
###classi.year add class
for( i in 1:3 ){
    tmp<-get(paste("gmm",i,sep=""))$classification
    tmp<-t(t(tmp))
    colnames(tmp)<-"class"
    for( year in 2012:2014 ){
        tmpdat<-get(paste("class",i,".",year,sep=""))
        tmpdat<-cbind(tmpdat,tmp)
        assign(paste("class",i,".",year,sep=""),tmpdat)
    }
}

###leader point
for( year in 2012:2014 ){
    for( i in 1:3 ){
        for( clsi in 1:GCLASS ){
            tmp<-get(paste("class",i,".",year,sep=""))
            assign(paste("tmp",clsi,sep=""),
                   subset(tmp,class==clsi))
            if( clsi == 1 ){
                assign(paste("dat",year,".",i,sep=""),
                       colMeans(get(paste("tmp",clsi,sep=""))))
            }else{
                tmpdat<-get(paste("dat",year,".",i,sep=""))
                assign(paste("dat",year,".",i,sep=""),rbind(tmpdat,
                       colMeans(get(paste("tmp",clsi,sep="")))))
            }
        }
    }
}
} ##IFCLUST

for( year in 2012:2014 ){
    for( i in 1:3 ){
        assign(paste("tmp",i,sep=""),
               get(paste("dat",year,".",i,sep="")))
        tmp<-get(paste("tmp",i,sep=""))
        kai<-t(t(rep(i,GCLASS)))
        colnames(kai)<-"階層化_結果"
        tmp<-cbind(tmp,kai)
        if( i == 1 ){
            assign(paste("data",year,sep=""),tmp)
        }else{
            assign(paste("data",year,sep=""),
                   rbind(get(paste("data",year,sep="")),tmp))
        }
    }
}

#pcac<-c(10:11,17:18,22)

#dat.2012<-scale(dat.2012[pcac])
#dat.2013<-scale(dat.2013[pcac])
#dat.2014<-scale(dat.2014[pcac])

##### IF GMM ADD #####
#if( IFCLUST ){
pcac<-1:20
dat.2012<-data.frame(data2012)
dat.2013<-data.frame(data2013)
dat.2014<-data.frame(data2014)
#}
######################

pc.2012<-princomp(dat.2012[,pcac])
col<-c(1,5)
col<-dat.2012[,col]

##### IF GMM ADD #####

col<-t(t(dat.2012[,22]))
colnames(col)<-"階層化_結果"

######################

ziku<-1:2
#ziku<-c(5,6)
score.2012<-cbind(data.frame(pc.2012$scores[,ziku]),col)
score.2013<-predict(pc.2012,dat.2013[,pcac])[,ziku]
score.2014<-predict(pc.2012,dat.2014[,pcac])[,ziku]

library(animation)
oopt<-ani.options(interval=0.1,nmax=10)

#score.2012[,1:2]
#score.2013
#score.2014

max<-30

##### IF GMM ADD #####
co<-t(t(score.2012[,3]))
colnames(co)<-"階層化_結果"
######################

#co<-score.2012[4]
#co[co$階層化_結果=="情報提供",]<-1
#co[co$階層化_結果=="動機づけ支援",]<-2
#co[co$階層化_結果=="積極的支援",]<-3

#co<-subset(co,階層化_結果!=1)
res<-score.2012[,1:2]
#res<-score.2012[score.2012$階層化_結果!=1,1:2]
#score.2013<-score.2013[score.2012$階層化_結果!=1,]
#score.2014<-score.2014[score.2012$階層化_結果!=1,]
res<-score.2012[,1:2]
diff<-(score.2013-res[,1:2])/max

pchc=c('+','o','*')

co[co==1]<-8
co[co==2]<-4
co[co==3]<-2
co[co==4]<-5
classnum<-t(t(c(table(class1.2012["class"]),table(class2.2013["class"]),table(class1.2014["class"]))))
clcex=sqrt(sqrt(classnum))

for( i in 1:max ){
    if( PNGON ){
        if( i < 10 )name=paste('plot/00',i,'plot.png',sep='')
        else name=paste('plot/0',i,'plot.png',sep='')
        png(name)
    }
    res<-res+diff
    plot(res,xlim=c(-1000,200),ylim=c(-300,100),cex=clcex,col=t((co)))#pch=pchc[co])
    #plot(res,xlim=c(-1000,200),ylim=c(-200,100),col=t(t(co)))
    #plot(res,xlim=c(-200,100),ylim=c(-200,200),col=t(t(co)))
    #plot(res,xlim=c(0,50),ylim=c(0,50),col=t(t(co)))
    #legend("topleft",toString(i))
    points(i*20-1000,103,pch=2,col=3,cex=2)
    abline(95,0,col=1)
    if( PNGON )dev.off()
    ani.pause()
}
diff<-(score.2014-res)/max
for( i in 1:max ){
    if( PNGON ){
        if( i < 10 )name=paste('plot/10',i,'plot.png',sep='')
        else name=paste('plot/1',i,'plot.png',sep='')
        png(name)
    }
    res<-res+diff
    plot(res,xlim=c(-1000,200),ylim=c(-300,100),cex=clcex,col=t((co)))
    #plot(res,xlim=c(-1000,200),ylim=c(-200,100),col=t(t(co)))
    #plot(res,xlim=c(-200,100),ylim=c(-200,200),col=t(t(co)))
    #plot(res,xlim=c(0,50),ylim=c(0,50),col=t(t(co)))
    #legend("topleft",toString(i+30))
    points(i*20-400,103,pch=2,col=3,cex=2)
    abline(95,0,col=1)
    if( PNGON )dev.off()
    ani.pause()
}


#convert *.png -delay 3 -loop 0 anime.gif
#rm *.png
