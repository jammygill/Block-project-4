# In this code i am downloading all miRNA files from ftp server of RNACentral database. 



# This code is working nicely. Solution 1
#https://lists.gnu.org/archive/html/help-bash/2013-05/msg00018.html

function readconf () {
	conf_file=/home/jammy/miRNA_collection/configration.conf # create variable and stores the path. 
while read line; do
# skip comments
  [[ ${line:0:1} == "#" ]] && continue
  
# skip empty lines
  [[ -z "${line}" ]] && continue
  eval ${line}
done < "$conf_file"
}
readconf #calling the function


# Making folder current db having file for current release. and other folder "Release_Notes" having latest release files.

current_db=$PROJECT_PATH"current"
release_notes_folder="Release_Notes"
mkdir -p $release_notes_folder


echo "Downloading $ file..."
	
wget ftp $WEB_LINK_FETCH_RELEASE_NOTES -P $release_notes_folder	

# Comparing downloaded release notes with that of release notes in current_db	
if [ -s `diff --normal $release_notes_folder $current_db/release_notes.txt` ];
	
then
	echo "The files are same"
	exit 

else	
	echo "The files are modified"		
    
fi 				  	

# change the link in configuration file to download the whole database. right now i am only checking for a single organism "Arabidopsis_thaliana.TAIR10.gff3.gz" 
for seqfiles in $WEB_LINK_FETCH_SEQ_DATA;
do 
    echo "Downloading $seqfiles file..."
  
    #Below i am making 3 folder under version_1, downloaded file is in folder Seq_files. 
    # {"I am trying to do gunzip on the file and save it in folder miRNA_bed but there is some problem "}

	mkdir -p version_1/{Seq_files,RNASeq,miRNA_Bed}$(date +%d-%m-%Y)| wget ftp $seqfiles -P ~/miRNA_collection_test/version_1/Seq_files$(date +%d-%m-%Y) | gunzip -c ~/miRNA_collection_test/version_1/Seq_files$(date +%d-%m-%Y)*.gz | awk 'BEGIN{OFS="\t"}$3=="transcript" && $9~/type=miRNA$/{split($9,id,";");sub(/Name=/,"",id[2]); print "chr"$1,$4-1,$5,id[2],"0",$7}' >> $seqfiles.bed 

done 	 


