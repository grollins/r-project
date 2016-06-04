load("checkpoint/raw.RData")

df <- raw %>%
  filter() %>%
  mutate()

# check for rows with null values
# df[rowSums(is.na(df)) > 0,]

# fill null entries for one column
# df %<>%
#   mutate(colname = ifelse(is.na(colname), 0, colname))

# remove duplicate rows
df %<>%
  subset(!duplicated(colname))

save(df, file = "checkpoint/cleaned.RData")
