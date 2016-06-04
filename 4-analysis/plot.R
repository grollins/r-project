INPUT <- "checkpoint/summary_data_4.RData"
OUTPUT <- "checkpoint/plot_4.RData"

load(INPUT)

p <- plot(summary_df)

save(p, file = OUTPUT)
