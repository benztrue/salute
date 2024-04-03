library(tidyverse)
library(data.table)
raw_data <- ggplot2::diamonds
diamonds <- ggplot2::diamonds
dupes <- ggplot2::diamonds %>%
  janitor::get_dupes()
summary(raw_data)
diamonds <- diamonds %>% 
  filter(x > 0, y > 0, y < 20, z > 0, z < 20)
## Removed outliers: View(ggplot2::diamonds). 
# Could use M.A.D to filter
setDT(diamonds)
diamonds <- unique(diamonds)
anyDuplicated(diamonds)
is.na(diamonds) %>% summary()
summary(dupes)
## Clean data: 'diamonds' ##

 