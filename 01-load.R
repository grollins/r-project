raw_df <- readr::read_csv(".csv", col_types = "illcclliiic")
save(raw, file = "checkpoint/raw.RData")
