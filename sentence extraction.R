library(europepmc)
library(XML)
library(pubmed.mineR)
library(stringr)

#function to extract sentence with a given word form .XML file 
give_epmc_sentences2 <- function (file,term)
{ 
  checkxml = xmlParse(file)
  check3 = lapply(getNodeSet(checkxml, "//p"), function(x) {xmlValue(x)})
  test = NULL
  if(length(check3)>0){
  for (i in 1:length(check3)) {
    tempA = SentenceToken(check3[[i]])
    tempB = regexpr(term, tempA[[1]] ,ignore.case = TRUE)
    tempC = which(attr(tempB, "match.length") == nchar(term))
    if (length(tempC) != 0)
      tempD = tempA[tempC]
    else tempD = NULL
    test = c(test, tempD)
    evidence_flattened = str_flatten(test,collapse = "::")
    if(str_count(evidence_flattened)==0)
    {evidence_flattened = "NO match found"} 
  }
  }else{evidence_flattened="Full text NA"}
  return(evidence_flattened)
}


#funcion to create table with given list of terms using give_epmc_sentences2() function
sentence_extraction=function(term_to_be_searched, outfilename, start_pos,end_pos)
{
  all_files = list.files(pattern = ".xml")
  
  result_df = NULL
  term <- term_to_be_searched ##write specific term here
  for(i in all_files[start_pos:end_pos])
  { print(i)
    for(j in term)
    { #print(j)
      evidence = give_epmc_sentences2(i,j)
      if(evidence != "NO match found")
      {
        pmcid = str_split(i,".xml")
        z = cbind(pmcid[[1]][1],j,evidence)
        result_df = rbind(result_df,z)
      }
    }
  }
  write.csv(result_df, outfilename)
  return(result_df)
}

#reading all species factor and conservaton file in R
species_name = read.csv("species_name.csv")
factor_terms = read.csv("factor_terms.csv")
conservation_status = read.csv("conservation_status.csv")

#running sentence_extraction fucion on species factor and conservation
species_result = sentence_extraction(species_name, "all_species_result.csv" )
colnames(species_result) = c("pmc","term1","evidence1")
factor_result = sentence_extraction(factor_terms, "all_factor_result.csv" )
colnames(factor_result) = c("pmc","term2","evidence2")
conservation_result = sentence_extraction(conservation_status, "all_consevation_result.csv" )
colnames(conservation_result) = c("pmc","term3","evidence3")

#finding commomn 
merged_species_factor = merge.data.frame(species_result,factor_result,by = "pmc")
merged_species_factor_conservation = merge.data.frame(merged_species_factor,conservation_result,by = "pmc")

write.csv(merged_species_factor_conservation,"merged_species_factor_conservation.csv")
