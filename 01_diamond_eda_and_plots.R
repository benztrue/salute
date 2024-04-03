library(tidyverse)
library(ggpointdensity)
library(viridis)
library(data.table)
library(scales)
df <- ggplot2::diamonds
setDT(df)
df %>% summary()
df %>% 
  ggplot(aes(x=carat)) +
  geom_histogram(bins=50)
df %>% 
  ggplot(aes(x=price)) +
  geom_histogram() +
  coord_flip()
df %>% 
  ggplot(aes(x = carat, y = price)) +
  geom_pointdensity(alpha=5/100) +
  scale_color_viridis() -> p1
p2_diam_small <- p1 + coord_cartesian(xlim = c(0, 3)) +
  theme_minimal()
p2_smoothed <- p2_diam_small +
  geom_smooth(aes(x=carat, y=price), method="loess", se=FALSE)
#
diamonds <- ggplot2::diamonds
ggplot(diamonds, aes(carat, price)) +
  geom_boxplot(mapping = aes(group = cut_width(price, 1000))) -> plot_price
plot_price <- plot_price + scale_y_continuous(labels = dollar)
# add breaks every $1,000. 
## Note ##
# A large portion of diamonds cost less than $1000 and are omitted from plot
# x axis begins at 1.5
plot_price
diamonds %>% 
  ggplot(aes(x = carat, y = price)) +
  geom_smooth(aes(group = cut_width(carat, 0.25)), colour = "purple", linetype = 2) +
  geom_point(alpha = 4/100, method="gam") +
  xlim(0, 2) +
  ylim(0, 19000)
diamonds %>% 
  ggplot(aes(x = log2(carat), y = price)) +
  geom_smooth(colour = "purple", linetype = 2) +
  geom_point(alpha = 4/100,) +
  xlim(-3, 3) +
  ylim(0, 19000)
ggplot(diamonds, aes(price, cut)) +
  geom_violin() +
  coord_flip() -> violin
## colour = color.. data contains variable named 'color' (diamonds$color)
diamonds %>% 
  ggplot(aes(x = carat, y = price, colour = color)) +
  geom_point(alpha = 50/100) +
  scale_color_discrete() +
  facet_wrap(~cut)
outlier_plot <- diamonds %>% 
  ggplot(aes(x = x, y = y)) +
  geom_point()
outlierplot2 <- diamonds %>% 
  ggplot(aes(x = x, y = z)) +
  geom_point()

02 ### Clean data ###
library(tidyverse)
library(data.table)
raw_data <- ggplot2::diamonds
diamonds <- ggplot2::diamonds
dupes <- ggplot2::diamonds %>%
  janitor::get_dupes()
summary(raw_data)
diamonds <- diamonds %>% 
  filter(x > 0, y > 0, y < 20, z > 0, z < 20)
## Removed outliers (outlier_plot, outlierplot2) ## 
setDT(diamonds)
diamonds <- unique(diamonds)
anyDuplicated(diamonds)
is.na(diamonds) %>% summary()
summary(dupes)
## Clean data: 'diamonds' ##