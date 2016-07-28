# p195 data set 1, project effort, project duration and product size
ds1.pe<-c(16.7,22.6,32.2,3.9,17.3,67.7,10.1,19.3,10.6,59.5)
ds1.pd<-c(23.0,15.5,14.0,9.2,13.5,24.5,15.2,14.7,7.7,15.0)
ds1.ps<-c(6050,8363,13334,5942,3315,38988,38614,12762,13510,26500)
ds1.df<-data.frame(Effort=ds1.pe,Duration=ds1.pd,Size=ds1.ps)

# p195 data set 2, module size, fan-out, fan-in, control flow paths, faults
ds2.ms<-c(29,29,32,33,37,41,55,64,69,101,120,164,205,232,236,270,549)
ds2.fo<-c(4,4,2,3,7,7,1,6,3,4,3,14,5,4,9,9,11)
ds2.fi<-c(1,1,2,27,18,1,1,1,1,4,10,10,1,17,1,1,2)
ds2.cfp<-c(4,4,2,4,16,14,12,14,8,12,22,221,59,46,38,80,124)
ds2.mf<-c(0,2,1,1,1,4,2,0,1,5,6,11,11,11,12,17,16)
ds2.df<-data.frame(Size=ds2.ms,Fan.Out=ds2.fo,Fan.In=ds2.fi,
                       C.F.Paths=ds2.cfp,Faults=ds2.mf)

# p203, measures for 17 software systems. KLOC, Av. mod size, FD
ds3.sys<-LETTERS[1:18][LETTERS[1:18] != "O"]
ds3.KLOC<-c(10,23,26,31,31,40,47,52,54,67,70,75,83,83,100,110,200)
ds3.MOD<-c(15,43,61,10,43,57,58,65,50,60,50,96,51,61,32,78,48)
ds3.FD<-c(36,22,15,33,15,13,22,16,15,18,10,34,16,18,12,20,21)
ds3.df<-data.frame(System=ds3.sys,KLOC=ds3.KLOC,MOD=ds3.MOD,FD=ds3.FD)


M<-cor(ds1.df)
corrplot(M, method = "circle") #plot matrix
corrplot(M,method="square") #plot matrix






