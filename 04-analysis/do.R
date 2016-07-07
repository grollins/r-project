INPUT <- "checkpoint/cleaned.RData"
OUTPUT <- "checkpoint/summary_data_04.RData"

load(INPUT)

summary_df <- group_frequency(df)

save(summary_df, file = OUTPUT)

# fill missing values with column mean
for(i in 1:ncol(df)){
  print(names(df)[[i]])
  df[is.na(df[,i]), i] <- mean(as.numeric(unlist(df[,i])), na.rm = TRUE)
}

# df %>%
#   summarise_each(funs(sum(is.na(.))))

data_to_fit <- df %>%
  mutate(var1 = (),
         var2 = (() | ()),
         var3 = (() & ())) %>%
  select(-var0) %>%
  mutate(y = as.integer(var1),
         var2 = as.integer(var2),
         var3 = as.integer(var3))

t7 <- student_t(df = 7)
model <- stan_glm(y ~ ., data = data_to_fit,
                  family = binomial(link="logit"),
                  prior = t7, prior_intercept = t7,
                  chains = 3, cores = 3, iter = 2000, warmup = 500)

pars <- c()

plot(model)
plot(model, pars = pars)
posterior_interval(model)
