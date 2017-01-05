all: \
	index.html \
	Statistics/lecture/Statistics.html \
	Data_Visualization/lecture/Data_Visualization.html \
	Knitr/lecture/Knitr.html \
	Data_Summarization/lecture/Data_Summarization.html \
	RStudio/lecture/RStudio.html \
	Manipulating_Data_in_R/lecture/Manipulating_Data_in_R.html \
	Data_Cleaning/lecture/Data_Cleaning.html \
	Data_IO/lecture/Data_IO.html \
	Data_Classes/lecture/Data_Classes.html \
	Simple_Knitr/lecture/Simple_Knitr.html \
	Basic_R/lecture/Basic_R.html \
	Functions/lecture/Functions.html \
	Arrays_Split/lecture/Arrays_Split.html \
	Subsetting_Data_in_R/lecture/Subsetting_Data_in_R.html \
	Intro/lecture/Intro.html
	
Statistics/lecture/Statistics.html: Statistics/lecture/Statistics.Rmd
	Rscript -e "source('renderFile.R'); renderFile('Statistics/lecture/Statistics.Rmd')"

Data_Visualization/lecture/Data_Visualization.html: Data_Visualization/lecture/Data_Visualization.Rmd
	Rscript -e "source('renderFile.R'); renderFile('Data_Visualization/lecture/Data_Visualization.Rmd')"

Knitr/lecture/Knitr.html: Knitr/lecture/Knitr.Rmd
	Rscript -e "source('renderFile.R'); renderFile('Knitr/lecture/Knitr.Rmd')"

Data_Summarization/lecture/Data_Summarization.html: Data_Summarization/lecture/Data_Summarization.Rmd
	Rscript -e "source('renderFile.R'); renderFile('Data_Summarization/lecture/Data_Summarization.Rmd')"

RStudio/lecture/RStudio.html: RStudio/lecture/RStudio.Rmd
	Rscript -e "source('renderFile.R'); renderFile('RStudio/lecture/RStudio.Rmd')"

Manipulating_Data_in_R/lecture/Manipulating_Data_in_R.html: Manipulating_Data_in_R/lecture/Manipulating_Data_in_R.Rmd
	Rscript -e "source('renderFile.R'); renderFile('Manipulating_Data_in_R/lecture/Manipulating_Data_in_R.Rmd')"

Data_Cleaning/lecture/Data_Cleaning.html: Data_Cleaning/lecture/Data_Cleaning.Rmd
	Rscript -e "source('renderFile.R'); renderFile('Data_Cleaning/lecture/Data_Cleaning.Rmd')"

Data_IO/lecture/Data_IO.html: Data_IO/lecture/Data_IO.Rmd
	Rscript -e "source('renderFile.R'); renderFile('Data_IO/lecture/Data_IO.Rmd')"

Data_Classes/lecture/Data_Classes.html: Data_Classes/lecture/Data_Classes.Rmd
	Rscript -e "source('renderFile.R'); renderFile('Data_Classes/lecture/Data_Classes.Rmd')"

Simple_Knitr/lecture/Simple_Knitr.html: Simple_Knitr/lecture/Simple_Knitr.Rmd
	Rscript -e "source('renderFile.R'); renderFile('Simple_Knitr/lecture/Simple_Knitr.Rmd')"

Basic_R/lecture/Basic_R.html: Basic_R/lecture/Basic_R.Rmd
	Rscript -e "source('renderFile.R'); renderFile('Basic_R/lecture/Basic_R.Rmd')"

Functions/lecture/Functions.html: Functions/lecture/Functions.Rmd
	Rscript -e "source('renderFile.R'); renderFile('Functions/lecture/Functions.Rmd')"

Arrays_Split/lecture/Arrays_Split.html: Arrays_Split/lecture/Arrays_Split.Rmd
	Rscript -e "source('renderFile.R'); renderFile('Arrays_Split/lecture/Arrays_Split.Rmd')"

Subsetting_Data_in_R/lecture/Subsetting_Data_in_R.html: Subsetting_Data_in_R/lecture/Subsetting_Data_in_R.Rmd
	Rscript -e "source('renderFile.R'); renderFile('Subsetting_Data_in_R/lecture/Subsetting_Data_in_R.Rmd')"

Intro/lecture/Intro.html: Intro/lecture/Intro.Rmd
	Rscript -e "source('renderFile.R'); renderFile('Intro/lecture/Intro.Rmd')"	

HW/homework3_key.html: HW/homework3_key.Rmd
	Rscript -e "source('renderFile.R'); renderFile('HW/homework3_key.Rmd')"	

index.html:
	Rscript -e "source('render.R')"
	Rscript -e "rmarkdown::render('index.Rmd')"

clean:
	rm -f Statistics/lecture/Statistics.html
	rm -f Data_Visualization/lecture/Data_Visualization.html
	rm -f Knitr/lecture/Knitr.html
	rm -f Data_Summarization/lecture/Data_Summarization.html
	rm -f RStudio/lecture/RStudio.html
	rm -f Manipulating_Data_in_R/lecture/Manipulating_Data_in_R.html
	rm -f Data_Cleaning/lecture/Data_Cleaning.html
	rm -f Data_IO/lecture/Data_IO.html
	rm -f Data_Classes/lecture/Data_Classes.html
	rm -f Simple_Knitr/lecture/Simple_Knitr.html
	rm -f Basic_R/lecture/Basic_R.html
	rm -f Functions/lecture/Functions.html
	rm -f Arrays_Split/lecture/Arrays_Split.html
	rm -f Subsetting_Data_in_R/lecture/Subsetting_Data_in_R.html 
	rm -f Intro/lecture/Intro.html
