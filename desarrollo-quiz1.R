# TODO: Add comment
# 
# Author: pacha
###############################################################################

#Question 1
#Which of the following is a principle of analytic graphics?

#Show comparisons *	
#Show box plots (univariate summaries) 			
#Don't plot more than two variables at at time 			
#Make judicious use of color in your scatterplots 			
#Only do what your tools allow you to do

#Question 2
#What is the role of exploratory graphs in data analysis?

#Only a few are constructed. 			
#They are made for formal presentations. 			
#The goal is for personal understanding. * 	
#Axes, legends, and other details are clean and exactly detailed.

#Question 3
#Which of the following is true about the base plotting system?

#Margins and spacings are adjusted automatically depending on the type of plot and the data 			
#Plots are typically created with a single function call 			
#Plots are created and annotated with separate functions *
#The system is most useful for conditioning plots

#Explanation: Functions like 'plot' or 'hist' typically create the plot on the graphics device and functions like 'lines', 'text', or 'points' will annotate or add data to the plot

#Question 4
#Which of the following is an example of a valid graphics device in R? 

#A Microsoft Word document 			
#A PDF file *	
#A socket connection 			
#A file folder

#Question 5
#Which of the following is an example of a vector graphics device in R?

#TIFF 			
#JPEG 			
#PNG 			
#Postscript *

#Question 6
#Bitmapped file formats can be most useful for 

#Plots that may need to be resized 			
#Scatterplots with many many points *
#Plots that are not scaled to a specific resolution 			
#Plots that require animation or interactivity

#Question 7
#Which of the following functions is typically used to add elements to a plot in the base graphics system?

#boxplot() 			
#lines() *
#plot() 			
#hist()

#Question 8
#Which function opens the screen graphics device on Windows?

#postscript() 			
#jpeg() 			
#xfig() 			
#windows() *

#Question 9
#What does the 'pch' option to par() control?

#the plotting symbol/character in the base graphics system *	
#the line width in the base graphics system 			
#the orientation of the axis labels on the plot 			
#the size of the plotting symbol in a scatterplot

#Question 10
#If I want to save a plot to a PDF file, which of the following is a correct way of doing that?

#Open the PostScript device with postscript(), construct the plot, then close the device with dev.off(). 			
#Open the screen device with quartz(), construct the plot, and then close the device with dev.off(). 			
#Construct the plot on the screen device and then copy it to a PDF file with dev.copy2pdf() *
#Construct the plot on the PNG device with png(), then copy it to a PDF with dev.copy2pdf().