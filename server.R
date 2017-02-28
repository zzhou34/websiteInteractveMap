shinyServer(function(input,output){
  
output$plot1 <- renderPlot({
  library(tmap)
  library(rgdal)
  admin <- readOGR("export","Export_Output")
  qtm(admin,fill=input$x)
})

output$plot2 <- renderPlot({
  library(tmap)
  library(rgdal)
  admin <- readOGR("export","Export_Output")
  df <- admin@data
  df$Median_num <- as.numeric(df$Median_num)
  df$Median_val <- as.numeric(df$Median_val)
  hist(df[,input$x],xlab = "variables",main="histogram of the vaiables")
})  


output$plot3 <- renderPlot(
 {
   library(tmap)
   library(rgdal)
   admin <- readOGR("export","Export_Output")
   df <- read.csv("1.csv")
   df <- df[2:12]
   k=1
   p=0
   while(k>0){
     p=p+1
     i=0
     j=0
     k=0
     t=0
     for1 <- vector()
     pr <- princomp(df,cor = T,scores = T) 
     a <- summary(pr)
     h <- as.vector(a[[1]])
     h <- h^2 
     for(i in 1:length(h)){
       if(h[i]<1)
       {
         for1 <- cbind(for1,i)       
         t=t+1
       }
     }
     a$loadings <- a$loadings[,-for1[1,]]
     h1 <- as.data.frame(h)
     #h1 <- h[-for1[1,],]
     o <- 11-t
     for( j in 1:o){
       if (sum(a$loadings[j,]^2)<0.5){
         df <- df[,-j]
         k=k+1
       }
       break
     }
   }
   
   i=1
   j=1
   f <- a$loadings
   df <- as.matrix(df)
   f <- as.matrix(f)
  # h1 <- matrix()
   #for(j in 1:9){
    # h1[i,j] <- h[j,i]
   #}
   
   result1 <- df%*%f 
   df1 <- cbind(df,result1)
   df1 <- as.data.frame(df1)
   names(df1)[10:13] <- c("Factor_1","Factor_2","Factor_3","Factor_4")
   admin@data <- df1
   qtm(admin,fill=input$x2)
   }
)

})