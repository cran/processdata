### R code from vignette source 'Introduction.Rnw'

###################################################
### code chunk number 1: Introduction.Rnw:40-42
###################################################
library(processdata)
set.seed(10101)


###################################################
### code chunk number 2: BM
###################################################
n <- 2001
p <- 2
X <- apply(matrix(rnorm(n*p), n, p), 2, cumsum)


###################################################
### code chunk number 3: processBM
###################################################
processX <- continuousProcess(X)


###################################################
### code chunk number 4: processBMsummary
###################################################
print(processX)
summary(processX)


###################################################
### code chunk number 5: argmentedBM
###################################################
X <- cbind(seq(0, 1, length.out = n), X)
colnames(X) <- c("time", "Brownian", "Motion")
processX <- continuousProcess(X)


###################################################
### code chunk number 6: argmentedprocessBMsummary
###################################################
summary(processX)


###################################################
### code chunk number 7: XX
###################################################
XX <- apply(matrix(rnorm(n*p), n, p), 2, cumsum)
XX <- cbind(seq(0, 1, length.out = n), XX)
X <- as.data.frame(rbind(X, XX))
X <- cbind(data.frame(id = rep(c("A", "B"), each = n)), X)
processX <- continuousProcess(X)


###################################################
### code chunk number 8: processXXsummary
###################################################
summary(processX)


###################################################
### code chunk number 9: augmentedprocessXX
###################################################
unitData <- data.frame(id = c("A", "B"), 
                       location = c("town", "country"))
processX <- continuousProcess(X, unitData = unitData)


###################################################
### code chunk number 10: processXXsummary
###################################################
summary(processX)


###################################################
### code chunk number 11: processMP
###################################################
pointData <- data.frame(id = c("A", "A", "A", "B", "B"),
                       time = c(0.2413, 0.7622, 0.9724, 0.1100, 0.6414))
processX <- markedPointProcess(pointData, continuousData = processX)
summary(processX)


###################################################
### code chunk number 12: coarsenprocessX
###################################################
processX <- markedPointProcess(pointData, continuousData = X, 
                               unitData = unitData, coarsen = 'right')
summary(processX)


###################################################
### code chunk number 13: Introduction.Rnw:260-261
###################################################
print(plot(processX))  ##print only needed for Sweave


###################################################
### code chunk number 14: Introduction.Rnw:272-274
###################################################
p <- plot(processX) + facet_null() + aes(colour = id)
print(p) ##print only needed for Sweave


###################################################
### code chunk number 15: Introduction.Rnw:297-300
###################################################
processX[ ,c(1,2)]
processX[1:3000, ]
processX[-(3001:4000), c(1,4)]


###################################################
### code chunk number 16: Introduction.Rnw:303-304
###################################################
summary(processX["A", c("location", "Brownian", "point")])


###################################################
### code chunk number 17: Introduction.Rnw:316-319
###################################################
processX[, -4, drop = TRUE]
head(processX[ , 2, drop = TRUE])
processX[ , 4, drop = TRUE]


###################################################
### code chunk number 18: Introduction.Rnw:325-326
###################################################
print(plot(processX["A",c(2,4)]))  ##print only needed for Sweave


###################################################
### code chunk number 19: Introduction.Rnw:339-341
###################################################
##print only needed for Sweave
print(plot(subset(processX, time > 0.75 & time < 0.95))) 


###################################################
### code chunk number 20: Introduction.Rnw:408-410
###################################################
str(processX)
object.size(processX)


###################################################
### code chunk number 21: Introduction.Rnw:431-433
###################################################
processXsubset <- processX[1:1000, c(2,4)]
object.size(processXsubset)


###################################################
### code chunk number 22: Introduction.Rnw:444-448
###################################################
processXtruesubset <- markedPointProcess(processXsubset)
object.size(processXtruesubset)
identical(unsubset(processXtruesubset), processXtruesubset)
identical(unsubset(processXsubset), processX)


