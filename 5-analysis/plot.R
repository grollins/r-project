INPUT <- "checkpoint/summary_data_5.RData"
OUTPUT <- "checkpoint/plot_5.RData"

load(INPUT)

p <- plot(summary_df)

save(p, file = OUTPUT)
