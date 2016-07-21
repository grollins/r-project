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

plot_logistic_regression <-
    function (xy_data, color_scheme, xlabel = "", ylabel = "", title=" ",
              label_nudge) {
  p <- ggplot(xy_data, aes(x, y, fill = name, label = label)) +
    geom_line(aes(color = name), size = 1.5) +
    geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.2) +
    geom_point(aes(color = name), data = subset(xy_data, point_size > 0.0),
               size = 2) +
    geom_text(aes(color = name), size = 4, nudge_y = label_nudge,
              show.legend = F) +
    labs(x = xlabel, y = ylabel) +
    # scale_x_continuous(breaks = c(0, 7, 14, 21, 28)) +
    scale_y_continuous(labels = scales::percent) +
                       #breaks = c(0.0, 0.25, 0.5, 0.75, 1.0),
                       #limits = c(0, 1.1)) +
    scale_color_manual(values = color_scheme) +
    scale_fill_manual(values = color_scheme) +
    theme_few() +
    ggtitle(title) +
    theme(axis.text = element_text(size = 10, color = "grey60"),
          axis.title = element_text(size = 12, color = "grey60"),
          #legend.position="none",
          plot.title = element_text(hjust = 0, size=12, color = "grey30"))
  return(p)
}

plot_logistic_regression_facet <-
    function (xy_data, color_scheme, xlabel = "", ylabel = "", title=" ",
              label_nudge) {
  p <- ggplot(xy_data, aes(x, y, fill = name, label = label)) +
    geom_line(aes(color = name), size = 1.5) +
    geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.2) +
    geom_point(aes(color = name), data = subset(xy_data, point_size > 0.0),
               size = 2) +
    geom_text(aes(color = name), size = 4, nudge_y = label_nudge,
              show.legend = F) +
    labs(x = xlabel, y = ylabel) +
    # scale_x_continuous(breaks = c(0, 7, 14, 21, 28)) +
    scale_y_continuous(labels = scales::percent) +
                       #breaks = c(0.0, 0.25, 0.5, 0.75, 1.0),
                       #limits = c(0, 1.1)) +
    scale_color_manual(values = color_scheme) +
    scale_fill_manual(values = color_scheme) +
    theme_few() +
    ggtitle(title) +
    facet_wrap(~name, nrow = 1) +
    theme(axis.text = element_text(size = 10, color = "grey60"),
          axis.title = element_text(size = 12, color = "grey60"),
          legend.position="none",
          plot.title = element_text(hjust = 0, size=12, color = "grey30"))
  return(p)
}

plot_logistic_regression_facet_with_repeat <-
    function (xy_data, color_scheme, xlabel = "", ylabel = "", title=" ",
              label_nudge) {
  xy_data_no_name <- xy_data %>% mutate(name2 = name) %>% select(-name)
  p <- ggplot(xy_data, aes(x, y, label = label)) +
    geom_line(data = xy_data_no_name, mapping = aes(group = name2),
              color = "grey85") +
    geom_line(size = 1.5) +
    geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.2) +
    geom_point(data = subset(xy_data, point_size > 0.0),
               size = 2) +
    geom_text(size = 4, nudge_y = label_nudge,
              show.legend = F) +
    labs(x = xlabel, y = ylabel) +
    # scale_x_continuous(breaks = c(0, 7, 14, 21, 28)) +
    scale_y_continuous(labels = scales::percent) +
                       #breaks = c(0.0, 0.25, 0.5, 0.75, 1.0),
                       #limits = c(0, 1.1)) +
    scale_color_manual(values = color_scheme) +
    scale_fill_manual(values = color_scheme) +
    theme_few() +
    ggtitle(title) +
    facet_wrap(~name, nrow = 1) +
    theme(axis.text = element_text(size = 10, color = "grey60"),
          axis.title = element_text(size = 12, color = "grey60"),
          legend.position="none",
          plot.title = element_text(hjust = 0, size=12, color = "grey30"))
  return(p)
}
