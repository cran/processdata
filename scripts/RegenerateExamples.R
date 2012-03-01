library(processdata)
## load("/Users/nielsrichardhansen/programs/multdiff/pkg/processdata/data/exampleDataFrames.RData")
data(exampleDataFrames)
        
contExam <- continuousProcess(continuousProcess(continuousData = continuousData,
                                                unitData = unitData)[c("A","B","C","D"),])
                   

pointExam <- markedPointProcess(markedPointProcess(pointData = pointData,
                                                   continuousData = continuousData,
                                                   unitData = unitData)[c("A","B","C","D"),])


factExam <- continuousProcess(continuousProcess(continuousData = cbind(continuousData[,-4],
                                data.frame(bar = factor(rep(c(0,1,0,1,0,1,0,1,0,1),
                                             times = c(500,300,1600,600,400,500,800,300,700,306))))),
                              unitData = unitData)[c("A","B","C","D"),])

load("/Users/nielsrichardhansen/programs/multdiff/pkg/processdata/scripts/jumpExampleDataFrames.RData")

jumpExam <- jumpProcess(markedPointProcess(markedPointProcess(pointData, continuousData, unitData)[c("A","B","C","D"),]))

save(contExam, factExam, pointExam, jumpExam, file = "/Users/nielsrichardhansen/programs/multdiff/pkg/processdata/data/example.RData")


### Some more examples

set.seed(1324)
tmp <- do.call(rbind, replicate(100, pointData, simplify = FALSE))
tmp$time <- rnorm(dim(tmp)[1], tmp$time)
tmp$value <- rnorm(dim(tmp)[1], sd = 50)
manyPointExam <- markedPointProcess(tmp, continuousData)
plot(manyPointExam, point_alpha = 0.1)
plot(manyPointExam, point_alpha = 0.3, point_shape = 15)
plot(manyPointExam, "value", point_alpha = 0.4, point_shape = 15)
ttemp <- subset(manyPointExam, pointSubset = value > 0)
plot(ttemp, "value", point_alpha = 0.4, point_shape = 15)

countingProcess <- integrator(subset(manyPointExam, select = -ALPHA))
countingProcess <- integrator(subset(manyPointExam, select = ALPHA))
countingProcess <- integrator(manyPointExam)
plot(countingProcess, point_size = 1)
getMarkValue(countingProcess)
