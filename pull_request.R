# R script to introduce and prctice pull requests
library(tidyverse)
load(url('https://github.com/Rucla-ed/rclass2/raw/master/_data/recruiting/recruit_school_somevars.RData'))

#4. Perform the following data manipulations and save the resulting dataframe in an object to use later:
# create 0/1 dummy of whether high school received visit from CU Boulder
#Filter observations to keep only high schools that are located in the same state as the university
# Subset your dataframe to include the following variables: `school_type`, `ncessch`, `name`, `total_students`, `avgmedian_inc_2564`, `visits_by_[univ]`, `visited`

df_boulder <- df_school %>% 
  ## create 0/1 indicator of whether received a visit from CU boulder
  mutate(
    visited = if_else(visits_by_126614>=1 & is.na(visits_by_126614) ==0,1,0)
  ) %>% 
  ## Filter observations to keep only high schools that are located in the same state as the university
  filter(state_code == inst_126614) %>% 
  ## keep only selected variables
  select(school_type,ncessch,name,total_students,avgmedian_inc_2564,visits_by_126614,visited)

#5. Use the dataframe from the previous step to create a scatterplot of total enrollment by median household income and have different point colors based on whether the high school has been visited or not by the university.

getwd()
list.files()
#open png file  
png("plots/scatterplot_color.png")

#create plot
ggplot(data = df_boulder, mapping = aes(x = total_students, y = avgmedian_inc_2564, color = as.factor(visited))) + geom_point() +
  xlab("Total students") + ylab("Avg. median income") + scale_color_discrete(name = "Legend", labels = c("No visit", "Visits"))

#close file
dev.off()