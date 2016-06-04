INPUT <- "checkpoint/summary_data_3.RData"
OUTPUT <- "checkpoint/plot_3.RData"

load(INPUT)

p <- plot(summary_df)

save(p, file = OUTPUT)
