load("raw.RData")

df <- raw %>%
  filter() %>%
  mutate()

save(df, file = "cleaned.RData")
