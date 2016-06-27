#set a working directory. 
setwd("/media/rth/datasets_new/")

#loading the data.
datasets_new <- read.table("final_venn_Mus_musculus.GRCm38_v_1.bed", h=F)

#giving column names to the data.
colnames(datasets_new) <- c("ids","overlap_score_1","overlap_score_2")

#loading the library for Venn_Diagram.
library(limma)

#Ignoring all the values that are zeros in the column.
Rna_central <- (datasets_new$overlap_score_1 != "0")

##Ignoring all the values that are zeros in the column.
mirBase <- (datasets_new$overlap_score_2 != "0")

#Binding the both columns the data is now in form of TRUE and FALSE values. 
final.col <- cbind(Rna_central,mirBase)

#Counting the Venn Counts for each column. 
cal.venn <- vennCounts(final.col)

#Plotting the Venn_Diagram. 
vennDiagram(cal.venn,circle.col = c("blue","darkgreen"),counts.col = "red", main = "Venn Diagram of mouse" )
