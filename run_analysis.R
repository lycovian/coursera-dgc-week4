# setup
# install.packages("dplyr")
# install.packages("downloader")
library(dplyr)
library(downloader)

# variables
cur_dir <- normalizePath(".")
fixture_dir <- file.path(cur_dir, "fixture")
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zip_file <- "data.zip"
zip_fqp <- file.path(fixture_dir, zip_file)
csv_dir <- file.path(fixture_dir, "UCI HAR Dataset")
csv_dir_test <- file.path(csv_dir, "test")
csv_dir_train <- file.path(csv_dir, "train")

# setup directory to host raw data
if (!file.exists(fixture_dir)) {dir.create(fixture_dir)}

# download & extract data
if (!file.exists(csv_dir)) {
    download(data_url, dest=zip_fqp)
    unzip(zip_fqp, exdir=fixture_dir)
}

# get feature names
features <- read.table(file.path(csv_dir, "features.txt"), stringsAsFactors = FALSE)
activities <- read.table(file.path(csv_dir,"activity_labels.txt"), stringsAsFactors = FALSE)

# build X/features
## attach subject lables to train data
x_train <- read.table(file.path(csv_dir_train, "X_train.txt"))
subject_train <- read.table(file.path(csv_dir_train, "subject_train.txt"))
x_train <- bind_cols(subject_train, x_train)

## attach subject lables to test data
x_test <- read.table(file.path(csv_dir_test, "X_test.txt"))
subject_test <- read.table(file.path(csv_dir_test, "subject_test.txt"))
x_test <- bind_cols(subject_test, x_test)

x <- bind_rows(x_train, x_test)
colnames(x) <- c("subject", features$V2)

# build y/label
y_train <- read.table(file.path(csv_dir_train, "y_train.txt"))
y_test <- read.table(file.path(csv_dir_test, "y_test.txt"))
y <- bind_rows(y_train, y_test)
colnames(y) <- c("activity")

# rename -> activity label
y$activity <- as.factor(y$activity)
levels(y$activity) <- activities$V2

# bind labels to features
dat <- as_tibble(bind_cols(y, x))

# reorder columns (optional)
dat <- dat %>%
    select(subject, activity, grep("mean()|std()", colnames(dat)))

# compute averages for all columns.
grp <- dat %>%
    group_by(subject, activity) %>%
    summarize_all(funs(mean))


# write tidy-dataframe out to csv
write.csv(grp, "result.txt", row.names=FALSE)
