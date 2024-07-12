file = list.files(pattern = ".xlsx")
length(file)
file_2 = NULL
for (i in file) 
  {
  print(i)
   file_1 = readxl::read_xlsx(i)
   file_2 = rbind(file_2,file_1)
}
write.csv(file_2,"all_species_combined_results.csv")

file_names = list.files(pattern = "result.csv")
for( j in file_names)
{
  print(j)
  air = read.csv(j)
  air = air[,c(2,3,4)]
  colnames(air)=c("pmc","term2","evidence2")
  merged_air = merge.data.frame(air,file_2,by = "pmc")
  file_result = paste(strsplit(j,".csv")[1],"merged.csv")
  write.csv(merged_air,file_result)
}

#writing all factor files in a single combined file 
file_names = list.files(pattern = "result.csv")
length(file_names)
file_3 = NULL
for (i in file_names) 
{
  print(i)
  file_1 = read.csv(i)
  file_3 = rbind(file_3,file_1)
}
write.csv(file_3,"all_factors_combined_results.csv")

length(unique(file_3$evidence))
length(unique(file_3$X.1))

#combining all 3 species,factor,extinct
file_names = list.files(pattern = "result.csv")
for( j in file_names)
{
  print(j)
  air = read.csv(j)
  air = air[,c(2,3,4)]
  colnames(air)=c("pmc","term2","evidence2")
  merged_air = merge.data.frame(air,file_2,by = "pmc")
  merged_air = merge.data.frame(merged_air,extinct,by = "pmc")
  file_result = paste(strsplit(j,".csv")[1],"extinct_merged.csv",collapse = "_")
  write.csv(merged_air,file_result)
}

extinct = read.csv("extinct.csv")
View(extinct)
xx = intersect(extinct$X.1,file_3$X.1)
xx = intersect(xx,file_2$X.1)
length(xx)


#writing all 3 species,factor,extinct in a single combined file 
file_names = list.files(pattern = "extinct_merged.csv")
length(file_names)
file_4 = NULL
for (i in file_names) 
{
  print(i)
  file_1 = read.csv(i)
  file_4 = rbind(file_4,file_1)
}
write.csv(file_4,"all_species_factor_extinct_combined_results.csv")

length(unique(file_4$evidence))
length(unique(file_4$pmc))
