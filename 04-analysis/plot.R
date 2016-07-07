INPUT <- "checkpoint/summary_data_04.RData"
OUTPUT <- "checkpoint/plot_04.RData"
load(INPUT)

COLORS <- "checkpoint/colors.RData"
load(COLORS)

p <- plot(summary_df)

save(p, file = OUTPUT)
