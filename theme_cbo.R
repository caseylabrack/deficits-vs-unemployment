# This program sets the specifications for most of elements of a graph
# Including the use of CBO's Proxima Nova T Condensed fonts
# The theme stays in effect for the R session as is used for all ggplots
# Howwever, any of these settings can be over-ridden in a particular ggplot

library(extrafont) # functions to use particular truetype fonts

# NB: The following lines are used to create a table of fonts that R can use
# They are commented out because they only need to be run once
# Once the font table is ready for R, you don't have to rerun the commands until you want to add more fonts to the font table
 
# This imports all of the TrueType system fonts on the C: drive
# font_import() # added the proxima fonts to the database

# This reads the fonttable database and registers those fonts with R
# loadfonts() # registered 3 fonts; note that bold is regular with face bold

# NB: Next two functions are just to verify the installation.
# fonts() # 3 proximia fonts at the end
# fonttable() %>% filter(str_detect(FamilyName, "^Proxima"))

# this is necessary to embed the fonts in the pdf files of the graphs
# Ghostscript is used by the embed_fonts() function
Sys.setenv(R_GSCMD="C:/Program Files/gs/gs9.23/bin/gswin64c.exe") # NB: c indicates the command line version

# In order to specify line widths in points 
pt2mm <- c(0.35277831682244)
pt2LineWidth <- 1/2.13

require(ggplot2)

# a theme list that can be "+"'d to the plot
# OR wrap in theme_set()
# theme_cbo <- 
theme_set(
  theme_minimal() +
    theme(
      text = element_text(family = "Proxima Nova T Cond"),  
      plot.title = element_text(family = "Proxima Nova T Cond Semibold", 
                                size = 10, face = "plain", hjust = 0),
      plot.subtitle = element_text(family = "Proxima Nova T Cond", 
                                   margin = margin(t = 0, r = 0, b = 12, l = 0, unit = "pt"),
                                   size = 9, face = "plain", hjust = 0, color = "#4C4B4C"),
      # axis.title = element_blank(),  # saves specifying x = NULL, y = NULL
      # hjust does responds to negative but better to modify layout
      # no background color
      plot.background = element_blank(),
      # if two plots are to by stacked, change b to 24 - 5.5 on the top one
      # if two plots are to be side-by-side change r to 18 - 5.5 on the left one
      # plot.margin = margin(t = 5.5, r = 5.5, b = 5.5, l = 5.5, unit = "pt"),
      plot.margin = margin(t = 5.5, r = 10, b = 5.5, l = 0, unit = "pt"),
      # no background color or grid lines
      panel.background = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      # .5 pt axes & ticks
      axis.line = element_line(size = .5*pt2LineWidth, color = "#4C4B4C"),
      axis.ticks = element_line(size = .5*pt2LineWidth, color = "#4C4B4C"),
      # draw ticks on the inside (negaive unit)
      axis.ticks.length = unit(-3, "pt"),
      # push x tick labels down & y tick labels left off of the inside of tick
      axis.text.x = element_text(family = "Proxima Nova T Cond", 
        size = 9, face = "plain", margin = margin(t = 10 , r = 0, b = 0, l = 0, unit = "pt"),
      # gray color
        color = "#4d4d4d"),
      axis.text.y = element_text(family = "Proxima Nova T Cond", 
        size = 9, face = "plain", margin = margin(t = 0 , r = 10, b = 0, l = 0, unit = "pt"),
        color = "#4d4d4d"),
      # saves labs(x = NULL, y = NULL)
      # axis.title.x = element_blank(), axis.title.y = element_blank(),
        complete = F, 
      validate = T,
      legend.position="none"
    )
)
