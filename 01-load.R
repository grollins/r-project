raw_df <- readr::read_csv(".csv", col_types = "illcclliiic")
md <- readr::read_csv("~/Data/MaterialDesign.csv")

save(raw_df, md, file = "checkpoint/raw.RData")
