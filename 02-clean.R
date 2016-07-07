load("checkpoint/raw.RData")

df <- raw_df %>%
  filter() %>%
  mutate()

# check for rows with null values
# df[rowSums(is.na(df)) > 0,]

# fill null entries for one column
# df %<>%
#   mutate(colname = ifelse(is.na(colname), 0, colname))

# remove duplicate rows
df %<>%
  distinct(colname, .keep_all = TRUE)

save(df, file = "checkpoint/cleaned.RData")

#--------------
# Color scheme
#--------------
md100 <- md[2,]
md200 <- md[3,]
md300 <- md[4,]
md500 <- md[6,]
md700 <- md[8,]

save(md100, md200, md300, md500, md700, file = "checkpoint/colors.RData")
