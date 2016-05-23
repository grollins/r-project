INPUT <- "summary_data_5.RData"
OUTPUT <- "plot_5.RData"

load(INPUT)

p <- plot(summary_df)

save(p, file = OUTPUT)
