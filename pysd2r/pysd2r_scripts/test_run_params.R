# Link https://pysd.readthedocs.io/en/master/basic_usage.html
# Ref: temp = pd.Series(index=range(30), data=range(20,80,2))
# model.run(params={'Room Temperature':temp})
#Sys.setenv(RETICULATE_PYTHON="/Users/jim/anaconda3/bin/python3")
# https://rstudio.github.io/reticulate/articles/calling_python.html
library(reticulate)
library(pysd2r)


target <- "pysd2r/pysd2r_scripts/models/TimeSeriesTest.mdl"

py <- pysd_connect()

py <- read_vensim(py, target)




d <- data.frame(data=0:20)

l <- list("TS"=0:20)
conv2 <- reticulate::r_to_py(d,convert=TRUE)

py$model$run

py$model$run(params = conv2)
