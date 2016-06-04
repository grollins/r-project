INPUT <- "checkpoint/cleaned.RData"
OUTPUT <- "checkpoint/summary_data_5.RData"

load(INPUT)

summary_df <- group_frequency(df)

save(summary_df, file = OUTPUT)
