group_frequency <- function (df, grouping_var) {
  summary_df <- df %>%
    group_by_(grouping_var) %>%
    summarize(N = n()) %>%
    mutate(freq = N / sum(N),
           label = paste(round(100 * N / sum(N), 0), "%", sep="")) %>%
    mutate(label_position = ifelse((freq - 0.03) > 0, freq - 0.03, freq)) %>%
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
    mutate(label_position = ifelse((freq - 0.03) > 0, freq - 0.03, freq)) %>%
    as.data.frame()
  return(summary_df)
}

plot_simple_bar_chart <- function (df, title) {
  plot <- ggplot(data = df, aes(x, y, label = label)) +
    geom_bar(stat = "identity", fill = md500$grey) +
    geom_text(aes(y=label_position), color = "white", size = 5) +
    theme_pander() +
    #scale_x_continuous(breaks = 1:max(summary_df[grouping_var]), limits = c(0,4)) +
    #scale_y_continuous(labels = scales::percent, limits = c(0, 1)) +
    coord_flip() +
    ggtitle(title) +
    labs(x = "", y = "") +
    theme(axis.ticks = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_text(color = md700$grey),
          plot.title = element_text(hjust = 0, size=12, color = "black"))
  return(plot)
}

plot_bar_chart <- function (df, title) {
  plot <- ggplot(data = df, aes(x, y, fill = group, label = label)) +
    geom_bar(stat = "identity", position = "dodge", fill = md500$grey) +
    geom_text(aes(y=label_position), position = position_dodge(0.9),
              color = "white", size = 5) +
    theme_pander() +
    # scale_x_continuous(breaks = 1:2, limits = c(0,4)) +
    # scale_y_continuous(labels = scales::percent, limits = c(0, 1)) +
    coord_flip() +
    ggtitle(title) +
    labs(x = "", y = "") +
    # scale_fill_manual(values=c("gray60", "gray60")) +
    theme(axis.ticks = element_blank(),
          axis.text = element_blank(),
          legend.position="none",
          plot.title = element_text(hjust = 0, size=12, color = md700$grey))
  return(plot)
}

plot_logistic_regression <- function (xy_list, xlabel = "", ylabel = "",
                                      title=" ") {
  xy <- xy_list[[1]]
  print(xy)
  plot <- ggplot() +
    geom_line(aes(x = xy$x, y = xy$y), color = "#659564", size = 1.5) +
    geom_ribbon(aes(x = xy$x, ymin = xy$lower, ymax = xy$upper),
                fill = "#659564", alpha = 0.2) +
    geom_point(aes(x = xy$x_to_label, y = xy$y_to_label), color = "#659564") +
    geom_text(aes(x = xy$x_to_label, y = xy$y_to_label, label = xy$label),
              nudge_y = label_nudge, color = "#659564", size = 4) +
    labs(x = xlabel, y = ylabel) +
    # scale_x_continuous(breaks = c(0, 7, 14, 21, 28)) +
    scale_y_continuous(labels = scales::percent) +
                       #breaks = c(0.0, 0.25, 0.5, 0.75, 1.0),
                       #limits = c(0, 1.1)) +
    theme_minimal() +
    ggtitle(title) +
    theme(axis.text = element_text(size = 10, color = "grey60"),
          axis.title = element_text(size = 12, color = "grey60"),
          plot.title = element_text(hjust = 0, size=12, color = "grey30"))

  return(plot)
}
