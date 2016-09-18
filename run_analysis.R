if(.Platform$OS.type == 'windows') .Platform$file.sep <- "\\"
# For some reason R doesn't do this automatically on my computer

datadir <- file.path(getwd(), "UCI HAR Dataset")

actinames <- read.table(file.path(datadir, "activity_labels.txt"))
# names in actinames$V2

featnames <- read.table(file.path(datadir, "features.txt"), as.is=T)
keepfeats <- grep('(mean|std)\\(\\)', featnames$V2)
tidy_name <- function(name) gsub("bodybody", "body", 
                                 tolower(gsub('-|\\(|\\)', '', name)))
new_featnames <- sapply(featnames$V2, tidy_name)

dataout = data.frame()
nrows = -1
for(usage in c("train", "test")) {
    datasubdir <- file.path(datadir, usage)
    
    filename <- paste("X_", usage, ".txt", sep="")
    print(paste("Reading ", filename))
    data <- read.table(file.path(datasubdir, filename), nrows=nrows)
    
    filename <- paste("subject_", usage, ".txt", sep="")
    subjects <- read.table(file.path(datasubdir, filename), nrows=nrows)
    
    filename <- paste("y_", usage, ".txt", sep="")
    acticodes <- read.table(file.path(datasubdir, filename), nrows=nrows)
    
    names(data) <- new_featnames
    data <- data[,keepfeats]
    
    dataSplit <- split(data, list(acticodes$V1, subjects$V1))
    for(kb in 1:length(dataSplit)){
        blockname <- names(dataSplit)[kb]
        block <- dataSplit[[kb]]
        featureAverages <- as.list(colMeans(block))
        actiSubj <- strsplit(blockname, "\\.")[[1]]
        acti <- actinames$V2[as.integer(actiSubj[1])]
        subj <- as.integer(actiSubj[2])
        usagename <- if(usage == "train") "TRAINING" else "TESTING"
        categories <- list(activity=acti, subject=subj, usage=usagename)
        dataout <- rbind(dataout, cbind(data.frame(categories), 
                                        data.frame(featureAverages)))
    }
}
