library(Matrix)
library(ggplot2)
lapply(c("AllGeneric.R", "ProcessData.R", "ContinuousProcess.R",
         "MarkedPointProcess.R", "JumpProcess.R"), source)

load("/Users/nielsrichardhansen/programs/multdiff/pkg/processdata/data/example.RData")
exData <- continuousProcess(continuousData = continuousData,
                            idData = idData)
exData <- markedPointProcess(pointData = pointData,
                             continuousData = exData)


### Generation of example data.

eidData <- data.frame(id = c("A","B","C","D","E","F"),
                     gender = rep(c("M","F"), each = 3))
id <- factor(rep(c("A","B","C","D","E","F"), each = 1001))
continuousData <- data.frame(id = id,
                             time = rep(seq(0,10,0.01), 6),
                             foo = unlist(tapply(rnorm(1001*6),id,cumsum)),
                             bar =  unlist(tapply(rnorm(1001*6,0.1),id,cumsum)))

time <- cumsum(rexp(100)) %% 10
id <- cumsum(c(1,diff(time) < 0))
id <- id[id <= 6]
time <- time[seq_along(id)]
id <- c("A","B","C","D","E","F")[id]
mark <- sample(c("ALPHA", "BETA"), length(id), replace = TRUE)

pointData <- data.frame(id = id,
                        time = time,
                        markType = mark)

### save("idData","continuousData","pointData",file="../data/example.RData")


### Generation of example2 data




time <- cumsum(rexp(100)) %% 10
id <- cumsum(c(1,diff(time) < 0))
id <- id[id <= 6]
time <- time[seq_along(id)]
id <- c("A","B","C","D","E","F")[id]
mark <- sample(c("foo", "bar"), length(id), replace = TRUE)
pointData <- data.frame(id = id,
                        time = time,
                        markType = mark,
                        jump = c(-rgamma(length(id), 20, 0.5), rgamma(length(id), 20, 0.5))[sample(2*length(id),length(id))])


unitData <- data.frame(id = c("A","B","C","D","E","F"),
                     gender = rep(c("M","F"), each = 3))
id <- factor(rep(c("A","B","C","D","E","F"), each = 1001))

continuousData <- data.frame(id = id,
                             time = rep(seq(0,10,0.01), 6))

continuousData <- rbind(pointData[,c("id", "time")],
                        continuousData)

ord <- tapply(continuousData$time, continuousData$id, order)
ord <- unlist(lapply(levels(continuousData$id),
                      function(id) which(continuousData$id == id)[ord[[id]]]),
               use.names=FALSE)
continuousData <- continuousData[ord, ]

foo <- rnorm(dim(continuousData)[1])
bar <- rnorm(dim(continuousData)[1])

foo[which(ord %in% seq(1,dim(pointData)[1])[pointData$mark == "foo"])] <-  pointData$jump[pointData$mark == "foo"]
bar[which(ord %in% seq(1,dim(pointData)[1])[pointData$mark == "bar"])] <-  pointData$jump[pointData$mark == "bar"]

foo = unlist(tapply(foo,continuousData$id,cumsum))
bar =  unlist(tapply(bar,continuousData$id,cumsum))

continuousData$foo <- foo
continuousData$bar <- bar

save(unitData, continuousData, pointData, file = "/Users/nielsrichardhansen/programs/multdiff/pkg/processdata/scripts/jumpExampleDataFrames.RData")






