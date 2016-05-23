group_frequency <- function (df, grouping_var) {
  summary_df <- df %>%
    group_by_(grouping_var) %>%
    summarize(N = n()) %>%
    mutate(freq = N / sum(N),
           label = paste(round(100 * N / sum(N), 0), "%", sep="")) %>%
    mutate(label_position = ifelse((freq - 0.05) > 0, freq - 0.05, freq)) %>%
    as.data.frame()
  return(summary_df)
}

nested_group_frequency <- function (df, grouping_var1, grouping_var2) {
  summary_df <- df %>%
    group_by_(grouping_var2, grouping_var1) %>%
    summarize(N = n()) %>%
    group_by_(grouping_var2) %>%
    mutate(groupN = sum(N)) %>%
    group_by_(grouping_var1, add = TRUE) %>%
    mutate(freq = N / groupN,
           label = paste(round(100 * N / groupN, 0), "%", sep="")) %>%
    mutate(label_position = ifelse((freq - 0.05) > 0, freq - 0.05, freq)) %>%
    as.data.frame()
  return(summary_df)
}

plot_bar_chart <- function (df, x, y, grouping_var, label) {
  plot <- ggplot(data = df, aes_string(x = x, y = y, fill = grouping_var,
                                       label = label)) +
    geom_bar(stat = "identity", position = "dodge") +
    geom_text(aes(y=label_position), position = position_dodge(0.9),
              color = "white", size = 5) +
    theme_pander() +
    # scale_x_continuous(breaks = 1:2, limits = c(0,4)) +
    # scale_y_continuous(labels = scales::percent, limits = c(0, 1)) +
    coord_flip() +
    labs(x = "", y = "") +
    # scale_fill_manual(values=c("gray60", "gray60")) +
    theme(axis.ticks = element_blank(), axis.text = element_blank(),
          legend.position="none")

  return(plot)
}

plot_logistic_regression <- function (x, y1, y2, lower1, lower2, upper1, upper2,
                                      x_to_label, y_to_label1,
                                      y_to_label2, label1, label2) {
  plot <- ggplot() +
    geom_line(aes(x = x, y = y1), color = "#659564", size = 1.5) +
    geom_ribbon(aes(x = x, ymin = lower1, ymax = upper1), fill = "#659564", alpha = 0.2) +
    geom_line(aes(x = x, y = y2), color = "grey60", size = 1.5) +
    geom_ribbon(aes(x = x, ymin = lower2, ymax = upper2), fill = "grey60", alpha = 0.2) +
    geom_point(aes(x = x_to_label, y = y_to_label1), color = "#659564") +
    geom_text(aes(x = x_to_label, y = y_to_label1, label = label1),
              nudge_y = -0.05, color = "#659564", size = 4) +
    geom_point(aes(x = x_to_label, y = y_to_label2), color = "grey60") +
    geom_text(aes(x = x_to_label, y = y_to_label2, label = label2),
              nudge_y = -0.05, color = "grey60", size = 4) +
    # geom_jitter(aes(x = x, y = as.integer(y)),
    #            width = 1.0, height = 0.05, color = "#659564", alpha = 0.25) +
    labs(x = "X label", y = "Y label") +
    scale_x_continuous(breaks = c(0, 7, 14, 21, 28)) +
    scale_y_continuous(labels = scales::percent,
                       breaks = c(0.0, 0.25, 0.5, 0.75, 1.0),
                       limits = c(0, 1.1)) +
    theme_minimal() +
    ggtitle("Title") +
    theme(axis.text = element_text(size = 10, color = "grey60"),
          axis.title = element_text(size = 12, color = "grey60"),
          plot.title = element_text(hjust = 0, size=12, color = "grey30"))
  
  return(plot)
}
