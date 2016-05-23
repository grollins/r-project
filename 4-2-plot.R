INPUT <- "summary_data_4.RData"
OUTPUT <- "plot_4.RData"

load(INPUT)

p <- plot(summary_df)

save(p, file = OUTPUT)
