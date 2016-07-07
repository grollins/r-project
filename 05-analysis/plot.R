INPUT <- "checkpoint/summary_data_05.RData"
OUTPUT <- "checkpoint/plot_05.RData"
load(INPUT)

COLORS <- "checkpoint/colors.RData"
load(COLORS)

p <- plot(summary_df)

save(p, file = OUTPUT)
