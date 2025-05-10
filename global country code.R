##발표 2


##load data
w <- read.csv("C:/mva/mva2/world_data_2023.csv")

#NA check
sapply(w, function(x) sum(is.na(x)))

#remove NA
cw <- w[complete.cases(w),]

#empty data -> 0
cw <- cw %>%
  mutate(across(everything(), ~ ifelse(. == "" | is.na(.), 0, .)))

#re-check
sapply(cw, function(x) sum(is.na(x)))

#----------------------------------------------------------------------------------------------


str(cw)  

library(ggplot2)
library(dplyr)
library(ggrepel)

#변수 선택 
convert <- c("Density..P.Km2.", "Agricultural.Land....", "Land.Area.Km2.","Armed.Forces.size","Co2.Emissions","CPI","CPI.Change....","Forested.Area....","Gasoline.Price","GDP","Gross.primary.education.enrollment....","Gross.tertiary.education.enrollment....","Life.expectancy","Minimum.wage","Out.of.pocket.health.expenditure","Tax.revenue....","Total.tax.rate","Unemployment.rate","Urban_population","Population", "Population..Labor.force.participation....")

#선택한 열들만 %와 , 제거하고 숫자형으로 변환
cw[convert] <- lapply(cw[convert], function(x) {
    as.numeric(gsub("[%|,|$]", "", x))
})

#remove NA
g <- cw[complete.cases(cw),]

#check
sapply(g, function(x) sum(is.na(x)))

#structure
str(g)

print(colnames(g))

##column re-name 
g <- g %>% 
  rename(pd = Density..P.Km2., Agric_Land = Agricultural.Land...., Land = Land.Area.Km2.,CPI_R = CPI.Change....,forest_R = Forested.Area...., GER_P = Gross.primary.education.enrollment...., GER_T = Gross.tertiary.education.enrollment...., OOP = Out.of.pocket.health.expenditure, LFP = Population..Labor.force.participation....,  TR = Tax.revenue....)

global <- g
summary(global)
print(colnames(global))


#################################################################################################
#PCA

#PCA data choice

pca_data <- global[,c("pd", "Agric_Land", "Land","Armed.Forces.size","Co2.Emissions","CPI","CPI_R","forest_R","Gasoline.Price","GDP","GER_P","GER_T","Life.expectancy","Minimum.wage","OOP","TR","Total.tax.rate","Unemployment.rate","Urban_population","Fertility.Rate","Infant.mortality","Physicians.per.thousand", "Population", "LFP", "Birth.Rate","Maternal.mortality.ratio")]

#cor
sc <- cor(global[,c("pd", "Agric_Land", "Land","Armed.Forces.size","Co2.Emissions","CPI","CPI_R","forest_R","Gasoline.Price","GDP","GER_P","GER_T","Life.expectancy","Minimum.wage","OOP","TR","Total.tax.rate","Unemployment.rate","Urban_population","Fertility.Rate","Infant.mortality","Physicians.per.thousand", "Population", "LFP", "Birth.Rate","Maternal.mortality.ratio")])

#standardized
scaled_data <- scale(pca_data)
pca_result <- prcomp(scaled_data, center =T, scale=T)

scaled_cor <- scale(sc)
pca_result_cor <- prcomp(sc, center =T, scale=T)
print(pca_result_cor)
summary(pca_result_cor)

#주성분의 표준편차와 주성분 점수
print(pca_result)

summary(pca_result)
#pc12 정도 되어야 설명 분산 비율이 88%되며, pc13은 설명분산 비율이 90%정도 된다. 

#고유값
eigenvalues <- pca_result$sdev^2
eigenvalues

#각각의 설명분산
explained_variance <- eigenvalues / sum(eigenvalues)
print(explained_variance)

pca_data <- as.data.frame(pca_result$x[, 1:26])
pca_data$Country <- global$Country 


#scree plot
screeplot(pca_result, main = "Scree Plot", col = "blue", pch = 16)
abline(h = 1, col = "red", lty = 2)

#누적분산 비율
plot(pca_result, type = "l", main="Scree Plot & Cumulative Variance")
abline(h = 1, col = "red", lty = 2)

##scree plot 보았을 때, 주성분 표준편차의 제곱이 고유값을 의미하며, kaiser 기준에 따라 고유값이 1 이상인 포인트를 찾으면 개수가 8개가 되고, 
##누적 분산 비율에서 볼 때, 그 개수가 급격히 감소하다가 완만해지는 포인트를 찾으면, 그 개수가 5개 또는 6개 정도이다.


#biplot

biplot(pca_result, scale = 0, main="Biplot of PC1 vs PC2")
abline(h=0,v=0, lty=2)
#시각화를 했을 때, 37, 187이 확연히 다른 국가들의 중심 포인트와 달랐고,
#PC1, PC2에 기여하는 정도가 다른 관측치들에 비해 높다는 것을 알 수 있다.
#추가로, PC2에 기여하는 정도가 높은 관측치는 144,24 정도이다.

#실제 data 상으로 보니, 37은 중국, 187은 미국, 78은 인도, 144는 러시아, 24는 브라질이다.
#



#PCA visualization
plot(pca_result$x[, 1], pca_result$x[, 2], 
     xlab = "PC1", ylab = "PC2", 
     main = "PCA Plot", 
     pch = 19, col = "black")
grid()
text(pca_result$x[, 1], pca_result$x[, 2], 
     labels = rownames(pca_result$x), 
     cex = 0.6, pos = 4, col = "red") 



#loading
loadings <- pca_result$rotation

#loading visualization
plot(loadings[, 1], loadings[, 2], 
     xlab = "PC1", ylab = "PC2", 
     main = "PCA Loading Plot",
     pch = 19, col = "blue")  
text(loadings[, 1], loadings[, 2], 
     labels = rownames(loadings), 
     cex = 0.7, pos = 1, col = "red")
abline(h=0,v=0, lty=2)





#각각 scatter plot
pairs(pca_result$x[,1:12], main="Pairs plot of PC1 to PC12")


