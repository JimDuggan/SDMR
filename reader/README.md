#### Translator for Vensim files into deSolve files
This folder contains a utility that can be used to generate deSolve files in R based on the equations outputted from Vensim. Equations should be outputted in computational order. 

Maths functions that are available in R can be translated (once they have the same name and parameter list), but specialised Vensim functions are not implemented.

The instructions are as follows:

* Save the Vensim equations to <file1>.txt
* Create a conversion script <file1>.R
* Run the conversion script

Here is a sample conversion script (TestScript.R) that converts Vensim equations from SIR.txt into a deSolve file SIR.R


```R
source("reader/conv_to_deSolve.R")

output<-sim$translate_vensim("./reader/SIR.txt")

sim$save_model(output,"./reader/SIR.R")
```
