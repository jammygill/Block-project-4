# In this code i am downloading all miRNA files from ftp server of RNACentral database. 

for file in ftp://ftp.ebi.ac.uk/pub/databases/RNAcentral/current_release/genome_coordinates/*.gff3.gz; # fetch the files from webserver. 
do
  echo "Downloading $file file..."
	wget $file		
done
