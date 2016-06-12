library(RUnit)

testsuite.SIR<-defineTestSuite("SIR Model Tests",
                              dirs=file.path("models/06 Chapter/tests/"),
                              testFileRegexp = "^TestSuite.+\\.R",
                              testFuncRegexp = "^T.+")
if(isValidTestSuite(testsuite.SIR))
{
  test.result<-runTestSuite(testsuite.SIR,verbose=0)
  summary(test.result)
}

