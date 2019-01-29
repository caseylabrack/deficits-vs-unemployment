library(tidyverse)
library(viridis)
library(ggrepel)

source("theme_cbo.R")
source("CBO-chart-utils.R")

# faint = "#f4dfed"
faint = "#cf74b4"
dark = "#450035"
neutral = "#4C4B4C"
labelledYear = c(1969, 1974, 1982, 2000, 2007, 2010)
nudgeDown = c(1976, 1990)
labelledYear2 = c(1969, seq(1970,2010,5))
highlightedStartYear = 2014

deficit = read_csv("data.csv") %>% 
  select(-jobs) %>% 
  filter(year < 2019)

unemployment = read_csv("unemployment.csv") %>% 
  gather(key = month, value = value, 2:13) %>% 
  group_by(year) %>% 
  summarize(average = mean(value))

data = deficit %>% 
  cbind("unemployment" = unemployment$average)

ggplot(data, aes(x = unemployment, y = baseline)) +
  # geom_point(data = data %>% filter(year==1969), color = faint, size = 2, shape = 15) +
  geom_path(color = faint, size = 1) +
  geom_path(data = data %>% filter(year > highlightedStartYear), color = dark, size = 1, 
            arrow = arrow(type = "open", angle = 30, length = unit(0.1, "inches"))) +
  geom_hline(yintercept = 0, linetype = "22", color="#4C4B4C", size = .75 * pt2LineWidth) +
  geom_vline(xintercept = 5, linetype = "22", color="#4C4B4C", size = .75 * pt2LineWidth) +
  scale_x_continuous(expand = c(0,0), limits = c(3,10)) +
  scale_y_continuous(expand = c(0,0), limits = c(-10,5), breaks = seq(-10,5,5),
                     labels = function (x) { if_else(x==0, "0", as.character(x))}) +
  labs(x = "Unemployment Rate", y = "Budget Surplus\nor Deficit\n(% of GDP)") +
  geom_text(data = data %>% filter(year %in% labelledYear), aes(label = year), 
            family = "Proxima Nova T Cond", size = 8*pt2mm, fontface = "bold", color = faint, nudge_y = .3, nudge_x = .05) +
  geom_text(data = data %>% filter(year %in% nudgeDown), aes(label = year), 
            family = "Proxima Nova T Cond", size = 8*pt2mm, fontface = "bold", color = faint, nudge_y = -.3) +
  # geom_text(data = data, aes(label = year), 
  #           family = "Proxima Nova T Cond", size = 8*pt2mm, fontface = "bold", color = neutral, alpha = .2) +
  geom_text(data = data %>% filter(year > highlightedStartYear), aes(label = year), 
            nudge_y = -.5, family = "Proxima Nova T Cond", size = 8*pt2mm, fontface = "bold", color = dark) +
  annotate("text", label = "Low Unemployment,\nBudget Deficit", x = 4, y = -9,
           family = "Proxima Nova T Cond", size = 9*pt2mm, fontface = "bold", color = "#4C4B4C", lineheight = .9, alpha = .5) +
  annotate("text", label = "High Unemployment,\nBudget Deficit", x = 8, y = -9,
           family = "Proxima Nova T Cond", size = 9*pt2mm, fontface = "bold", color = "#4C4B4C", lineheight = .9, alpha = .5) +
  annotate("text", label = "Low Unemployment,\nBudget Surplus", x = 4, y = 4,
           family = "Proxima Nova T Cond", size = 9*pt2mm, fontface = "bold", color = "#4C4B4C", lineheight = .9, alpha = .5) +
  annotate("text", label = "High Unemployment,\nBudget Surplus", x = 8, y = 4,
           family = "Proxima Nova T Cond", size = 9*pt2mm, fontface = "bold", color = "#4C4B4C", lineheight = .9, alpha = .5) +
  theme(axis.title = element_text(family = "Proxima Nova T Cond", size = 9, face = "bold", color = "#4C4B4C")) +
  theme(axis.title.y = element_text(angle = 0, vjust = .68, hjust = 1)) +
  theme(axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0, unit = "pt")))

ggsave("plot.pdf", width = 5.5, height = 4, units = "in")
