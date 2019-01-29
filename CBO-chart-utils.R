pt2LineWidth <- 1/2.13

teals2 <- c("#003e53", "#3a7b93")
teals3 <- c("#002235","#105c72","#5d9db5")
teals4 <- c("#002235","#00475d","#2e7187","#5d9db5")
teals5 <- c("#002235","#003e53","#105c72","#3a7b93","#5d9db5")

spending2 <- teals2
spending3 <- teals3
spending4 <- teals4
spending5 <- teals5

greens2 <- c("#054011", "#4A7F4A")
greens3 <- c("#002400","#2a5e2c","#6aa069")
greens4 <- c("#002400","#134a1a","#3f7440","#6aa069")
greens5 <- c("#002400","#054010","#2a5e2c","#4a7e4a","#6aa069")

revenue2 <- greens2
revenue3 <- greens3
revenue4 <- greens4
revenue5 <- greens5

orange = "#d87939"
oranges2 = c("#490000", "#d87939")
oranges3 = c("#490000","#8c3900","#d87939")
oranges4 = c("#490000","#742400","#a54e0c","#d87939")
oranges5 = c("#490000","#691900","#8c3900","#b25818","#d87939")

debt <- c("#D074B4")

purples2 = c("#450035", "#D074B4")

lineWidth = 2.75 * pt2LineWidth

# recessionFill <- c("#aaaaaa")
recessionFill = "#d2d2d2"

actualProjected <- function (date, nudge = 180, historical = FALSE) {
  
  list(
    geom_vline(xintercept = as.Date(date), linetype = "22", color="#4d4d4d", size = .5 * pt2LineWidth),
    annotate("text", label="Projected", x=as.Date(date) + nudge, y=Inf, hjust="left", vjust=1.1,
               family= theme_get()$text[["family"]], 
               size=8*pt2mm, color = "#4d4d4d"),
    annotate("text", label=ifelse(historical, "Historical", "Actual"), x=as.Date(date) - nudge, y=Inf, hjust="right", vjust=1.1,
               family= theme_get()$text[["family"]], 
               size=8*pt2mm, color = "#4d4d4d")
  )
}

actualProjectedNotDate <- function (date, nudge = .5) {
  
  list(
    geom_vline(xintercept = date, linetype = "22", color="#4d4d4d", size = .5 * pt2LineWidth),
    annotate("text", label="Projected", x=date + nudge, y=Inf, hjust="left", vjust=1.1,
             family= theme_get()$text[["family"]], 
             size=8*pt2mm, color = "#4d4d4d"),
    annotate("text", label="Actual", x=date - nudge, y=Inf, hjust="right", vjust=1.1,
             family= theme_get()$text[["family"]], 
             size=8*pt2mm, color = "#4d4d4d")
  )
}

actualProjectedUnlabelled <- function (date, nudge = 180) {
  
    geom_vline(xintercept = as.Date(date), linetype = "22", color="#4d4d4d", size = .5 * pt2LineWidth)
}

baselineLine <- function () {
  
  # list(
    geom_hline(yintercept = 0, color="#4d4d4d", size = .5 * pt2LineWidth)
    # theme(axis.line.x = element_blank())
  # )
}

yScale = function (bottom, top, interval) {
  scale_y_continuous(expand = c(0,0), breaks = seq(bottom,top,interval), limits = c(bottom,top)) 
}