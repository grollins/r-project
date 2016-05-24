INPUT <- "cleaned.RData"
OUTPUT <- "summary_data_3.RData"

load(INPUT)

summary_df <- group_frequency(df)

save(summary_df, file = OUTPUT)
