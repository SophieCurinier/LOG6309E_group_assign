# Import libraries
library(ScottKnottESD)
library(readr)
library(ggplot2)

# load data
model_performance_df <- read_csv("model_performance.csv")

# apply ScottKnottESD and prepare a ScottKnottESD dataframe
sk_results <- sk_esd(model_performance_df)
sk_ranks <- data.frame(model = names(sk_results$groups),
             rank = paste0('Rank-', sk_results$groups))

# prepare a dataframe for generating a visualisation
plot_data <- melt(model_performance_df)
plot_data <- merge(plot_data, sk_ranks, by.x = 'variable', by.y = 'model')

# generate a visualisation
g <- ggplot(data = plot_data, aes(x = variable, y = value, fill = rank)) +
     geom_boxplot() +
     ylim(c(0.7, 1)) +
     facet_grid(~rank, scales = 'free_x') +
     scale_fill_brewer(direction = -1) +
     ylab('F1') + xlab('Model') + ggtitle('') + theme_bw() +
     theme(text = element_text(size = 16),
           legend.position = 'none')
g
ggsave(filename = "result/BGL/BGL_scottKnottTest.png", plot = g, device = "png")       