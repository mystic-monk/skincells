# read in the data 
skincells <- read.csv('data/skincells.csv')

# make available the columns of the dataset directly accessible  
attach(skincells)

# install.packages("ggplot2")
library(ggplot2)

# 
jpeg('ca1_fig1.jpg',height=210,width=290,res=600,units="mm")
group_means=by(logcells, day ,t.test)
group_means=matrix(c(unlist(group_means[['1']][5:4]),unlist(group_means[['2']][5:4]),unlist(group_means[['3']][5:4]),unlist(group_means[['4']][5:4])),nrow=4,ncol=3,byrow=T)
group_means=data.frame(cbind(group_means,c('day 1','day 2','day 3','day 4')))
colnames(group_means)=c('mean','lcl','ucl','day')

# converting the variables to numeric and rounding off 
# this is to show these nicely along the y axis 
group_means$mean <- round(sapply(group_means$mean, as.numeric), digits=1)
group_means$lcl <- round(sapply(group_means$lcl, as.numeric), digits=1)
group_means$ucl <- round(sapply(group_means$ucl, as.numeric), digits=1)


p <- ggplot(group_means, aes(x=day,y=group_means[,1])) 
p <- p + geom_errorbar(aes(ymin=lcl, ymax=ucl), width=.1) 
p <- p + geom_line()
p <- p + geom_point()
p <- p + expand_limits(y=c(2.0,7))
p <- p + labs(title = "Figure 1. Plot of Mean of The logarithm (base 2) of the number of live cells by Day")
p <- p + labs(subtitle = "Showing the confidence interval of Mean logcells for each Day")
p <- p + ylab("Average log of number of live cells in the colony")
p <- p + xlab('The day (number code) that observation was recorded')
p <- p + theme_classic()
p <- p + theme(legend.position = "none")
p <- p + theme(text = element_text (size=14),axis.text.x=element_text(size=14))
p
dev.off()

# Box plot for the distribution for the time
jpeg('ca1_fig2.jpg',height=210,width=290,res=600,units="mm")
p <- ggplot(skincells, aes(x=reorder(factor(time), -logcells, FUN= median), y=logcells, fill=factor(time)))
p <- p + geom_boxplot( outlier.colour = "red", outlier.shape= 1)
p <- p + stat_boxplot(geom = 'errorbar', width=0.2)
p <- p + stat_summary(fun.data = mean_cl_boot, geom = "linerange", colour="red", size=3, alpha=0.2)
p <- p + stat_summary(fun = mean, geom = "point", colour="darkred", size=2)
p <- p + labs(title = "Figure 2. Box Plot of Mean of The logarithm (base 2) of the number of live cells by Time")
p <- p + labs(subtitle = "Showing the confidence interval of Mean logcells for each time")
p <- p + ylab("Log of the number of live cells in the colony")
p <- p + xlab("Amount of radiation exposure in minutes")
p <- p + theme_minimal()
p <- p + theme(legend.position = "none")
p <- p + theme(text = element_text (size=14),axis.text.x=element_text(size=14))
p
dev.off()


# check the first few observations
head(skincells)

# check the structure of the dataset 
str(skincells)


summary(skincells)
by(skincells$logcells, list(skincells$day), mean)

# interaction model 
fit_skincells = lm(logcells~factor(day)*time, data =skincells)
summary(fit_skincells)

jpeg('ca1_interactionmodel.jpg',height=210,width=290,res=600,units="mm")
with(skincells, plot(time,logcells,pch=20,cex=2,col=colour,main='Figure 3. Interaction model',
                     xlab='Time in minutes', 
                     ylab='Log of the number of live cells in the colony'))
abline(8.3201,-1.7451,col='blue',lwd=2)
abline(8.3201-2.4342,0.6168-1.7451,col='red',lwd=2)
abline(8.3201-1.8085,0.5065-1.7451,col='darkgreen',lwd=2)
abline(8.3201-1.4723,0.4055-1.7451,col='pink',lwd=2)
dev.off()

# drop1 function to check the interaction 
drop1(fit_skincells,test='F')

# Common Slopes
fit_skincells2 =lm(logcells~factor(day)+time, data =skincells )
summary(fit_skincells2)
# coefficients 
confint(fit_skincells2)

drop1(fit_skincells2, test='F')

# geometry of model 
# setting new column for the colour in the dataset

# create column in dataframe to code the colour 
skincells$colour='blue'
skincells$colour[skincells$day==2]='red'
skincells$colour[skincells$day==3]='darkgreen'
skincells$colour[skincells$day==4]='pink'

# save the plot to JPEG
jpeg('ca1_commonslopes.jpg',height=210,width=290,res=600,units="mm")
with(skincells, plot(time,logcells,pch=20,cex=2,col=colour,main='Figure 4. Common Slopes model',
                      xlab='Time in minutes', 
                      ylab='Log of the number of live cells in the colony')) 
abline(7.7248,-1.3615,col='blue',lwd=2)
abline(7.7248-1.4451,-1.3615,col='red',lwd=2)
abline(7.7248-1.0014,-1.3615,col='darkgreen',lwd=2)
abline(7.7248-0.8378,-1.3615,col='pink',lwd=2)
legend('topright',legend=c('Day 1', 'Day 2','Day 3','Day 4'), lwd=2, col=c('blue','red','darkgreen','pink'))
dev.off()



#attach(skincells)
fit_skincells3 = lm(logcells~time+I(time^2), data =skincells)
summary(fit_skincells3)

# overwrite the column in dataframe to code for the colour 
skincells$colour='blue'
skincells$colour[skincells$day==2]='red'
skincells$colour[skincells$day==3]='darkgreen'
skincells$colour[skincells$day==4]='pink'

# save the plot to JPEG
jpeg('ca1_curvefitting.jpeg',height=210,width=290,res=600,units="mm")
with(skincells, plot(time,logcells,pch=20,cex=2,col=colour,main='Figure 5. Quadratic Model',
                     xlab='Time in minutes', 
                     ylab='Log of the number of live cells in the colony')) 
title(sub='Least Square line and Curve fitting',cex.sub=.65)
abline(fit_skincells2,col='red',lwd=2)
curve(8.3540-4.3805*x+0.8758*x^2,lwd=2,from=0.0,3.5, col='darkgreen',add=T)
legend('bottomleft',legend=c("Simple Least Squares Line","quadratic curved line"),lwd=2,col=c('red','darkgreen'))
dev.off()

detach(skincells)