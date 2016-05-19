
# In this code i do preprocessing or filtering of the datasets from RNAcentral.

for filename in /home/jammy/Desktop/Datasets/gff3_files/*.gz; # Takes the files as input 
do
  echo "Processing $filename file..."
	 
    # Here i unzip the file and only take mirna with a single transcript and save into a bed format file. 

	gunzip -c $filename | awk 'BEGIN{OFS="\t"}$3=="transcript" && $9~/type=miRNA$/{split($9,id,";");sub(/Name=/,"",id[2]); print "chr"$1,$4-1,$5,id[2],"0",$7}' >> $filename.bed
	

done


# This code helps to calculate all the sequences downloded from mirBASE database. I am doing this in order to verify if RNACentral covers
#all the datasets from mirBASE. 

# Note: I need to do total of all the files .. like a sum. how can i do that ? 
# Counting /home/jammy/Desktop/Datasets/mirbase_seqs/aae.gff3
# 252 
# Counting /home/jammy/Desktop/Datasets/mirbase_seqs/aca.gff3
# 704 
# Counting /home/jammy/Desktop/Datasets/mirbase_seqs/aga.gff3
# 146 
#Total ? 

for files in /home/jammy/Desktop/Datasets/mirbase_seqs/*.gff3; 
do 
  echo "Counting $files"

  awk 'BEGIN{i=0}{i++;}END{print i}' $files # Count total number of lines in each file. 

done
  
  
