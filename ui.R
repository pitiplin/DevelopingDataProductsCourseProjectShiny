library(shiny)

# URL<- "ftp://cdsarc.u-strasbg.fr/pub/cats/V/50/catalog.gz"
# destfile<-"BScatalog.gz"
# download.file(URL, destfile)
# 
# widthsVect<-c(4,10,11,6,6,4,1,1,1,5,2,9,2,2,4,1,2,2,2,2,2,4,1,2,2,2,6,6,5,1,1,5,1)
# widthsVect<-c(widthsVect,5,1,5,1,20,1,6,6,1,5,4,4,2,3,1,4,6,4,2,1)
# 
# dataBSInit<-read.fwf(destfile,widthsVect,stringsAsFactors=F,strip.white=TRUE)
# 
# dataBS<-data.frame(dataBSInit[,1:12])
# dataBS$RA1900<-as.numeric(dataBSInit$V13)+as.numeric(dataBSInit$V14)/60+as.numeric(dataBSInit$V15)/3600
# dataBS$DE1900<-as.numeric(paste0(dataBSInit$V16,dataBSInit$V17))+as.numeric(dataBSInit$V18)/60+as.numeric(dataBSInit$V19)/3600
# dataBS$RA<-as.numeric(dataBSInit$V20)+as.numeric(dataBSInit$V21)/60+as.numeric(dataBSInit$V22)/3600
# dataBS$DE<-as.numeric(paste0(dataBSInit$V23,dataBSInit$V24))+as.numeric(dataBSInit$V25)/60+as.numeric(dataBSInit$V26)/3600
# dataBS<-cbind(dataBS,dataBSInit[,27:ncol(dataBSInit)])
# 
# varNames<-c("HR","Name","DM","HD","SAO","FK5","IRflag","r_IRflag","Multiple","ADS","ADScomp","VarID","RA1900","DE1900")
# varNames<-c(varNames,"RA","DE","GLON","GLAT","Vmag","n_Vmag","u_Vmag","B-V","u_B-V","U-B","u_U-B","R-I","n_R-I")
# varNames<-c(varNames,"SpType","n_SpType","pmRA","pmDE","n_Parallax","Parallax","RadVel","n_RadVel","l_RotVel","RotVel","u_RotVel")
# varNames<-c(varNames,"Dmag","Sep","MultID","MultCnt","NoteFlag")
# 
# names(dataBS)<-varNames
# 
# dataBS$IRflag<-as.factor(dataBS$IRflag)
# dataBS$r_IRflag<-as.factor(dataBS$r_IRflag)
# dataBS$Multiple<-as.factor(dataBS$Multiple)
# dataBS$n_Vmag<-as.factor(dataBS$n_Vmag)
# dataBS$u_Vmag<-as.factor(dataBS$u_Vmag)
# dataBS$"u_B-V"<-as.factor(dataBS$"u_B-V")
# dataBS$"u_U-B"<-as.factor(dataBS$"u_U-B")
# dataBS$"n_R-I"<-as.factor(dataBS$"n_R-I")
# dataBS$n_SpType<-as.factor(dataBS$n_SpType)
# dataBS$n_Parallax<-as.factor(dataBS$n_Parallax)
# dataBS$n_RadVel<-as.factor(dataBS$n_RadVel)
# dataBS$l_RotVel<-as.factor(dataBS$l_RotVel)
# dataBS$u_RotVel<-as.factor(dataBS$u_RotVel)
# dataBS$NoteFlag<-as.factor(dataBS$NoteFlag)
#
# dataBS<-dataBS[!is.na(dataBS$Vmag),]
# 
# dataBSFinal<-data.frame(dataBS$HR,dataBS$Name)
# dataBSFinal<-cbind(dataBSFinal,dataBS$Vmag)
# dataBSFinal<-cbind(dataBSFinal,dataBS$IRflag)
# dataBSFinal<-cbind(dataBSFinal,dataBS$RA1900)
# dataBSFinal<-cbind(dataBSFinal,dataBS$DE1900)
# dataBSFinal<-cbind(dataBSFinal,dataBS$RA)
# dataBSFinal<-cbind(dataBSFinal,dataBS$DE)
# dataBSFinal<-cbind(dataBSFinal,dataBS$GLON)
# dataBSFinal<-cbind(dataBSFinal,dataBS$GLAT)
# dataBSFinal<-cbind(dataBSFinal,dataBS$"B-V")
# dataBSFinal<-cbind(dataBSFinal,dataBS$"U-B")
# dataBSFinal<-cbind(dataBSFinal,dataBS$pmRA)
# dataBSFinal<-cbind(dataBSFinal,dataBS$pmDE)
# dataBSFinal<-cbind(dataBSFinal,dataBS$RadVel)
# 
# names(dataBSFinal)<-gsub("dataBS.","",names(dataBSFinal))

# write.csv(dataBSFinal, file = "BScatalog.csv", row.names = FALSE)

BScatalog <- read.csv("BScatalog.csv")
minMagnitude<-min(BScatalog$Vmag)
maxMagnitude<-max(BScatalog$Vmag)

shinyUI(fluidPage(
  headerPanel("Developing Data Products Course Project"),
  
  h4("Data Science Series"),
  h4("Christopher Garcia Ambrozaitis"),
  h4("August 2014"),
  
  sidebarPanel(
    
    sliderInput('magnitude', 'Star Magnitude:',value = c(minMagnitude,maxMagnitude), min = minMagnitude, max = maxMagnitude, step = 0.01,),
    
    radioButtons("radio", "Select Visualization:",
                choices = list("Show Table" = 1, "Show Plot" = 2),selected = 1),
    
    conditionalPanel(
      condition = "input.radio == 2",
      selectInput("xaxis", "X Axis:", choices = names(BScatalog)),
      selectInput("yaxis", "Y Axis:", choices = c("NONE",names(BScatalog)))
    )
  ),
  mainPanel(
    p('Min Star Magnitude'),
    textOutput('text1'),
    p(''),
    p('Max Star Magnitude'),
    textOutput('text2'),
    p(''),
    p('Selected Visualization'),
    textOutput('text3'),
    p(''),
    conditionalPanel(
      condition = "input.yaxis == 'NONE' & input.radio == 2",
      p('Mean'),
      textOutput('text4'),
      p(''),
      p('Standard Deviation'),
      textOutput('text5')
    )
  ),
  
  conditionalPanel(
    condition = "input.radio == 1",
    tabsetPanel(
      tabPanel(dataTableOutput("mytable"))
    )
  ),
  
  conditionalPanel(
    condition = "input.radio == 2",
    plotOutput('plot')
  ) 
  
))