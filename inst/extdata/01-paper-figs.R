# LIBS ---
library(monitoR)
library(ggplot2)

# DATA ----
data(skink)

# PREPROCESSING ----
grid_44 <- create_grid(range(skink$X), range(skink$Y), dim = c(4,4))
grid_22 <- create_grid(range(skink$X), range(skink$Y), dim = c(2,2))
grid_1010 <- create_grid(range(skink$X), range(skink$Y), dim = c(10, 10))
grid_66 <- create_grid(range(skink$X), range(skink$Y), dim = c(6,6))
grid_2z <- create_grid(range(skink$X), range(skink$Y), dim = c(4,4))
grid_3z <- create_grid(range(skink$X), range(skink$Y), dim = c(4,4))
grid_66$zone[c(3, 7, 8, 9, 10)] <- 2
grid_66$zone[c(16,17,22)] <- 3
grid_66$zone[c(20, 26)] <- 4
grid_66$zone[36] <- 5
grid_2z$zone[1:6] <- 2
grid_3z$zone[1:6] <- 2
grid_3z$zone[7:10] <- 3
skink_grid_44 <- skink |> add_grid(grid_44)
skink_grid_22 <- skink |> add_grid(grid_22)
skink_grid_1010 <- skink |> add_grid(grid_1010)
skink_grid_66 <- skink |> add_grid(grid_66)
skink_grid_2z <- skink |> add_grid(grid_2z)
skink_grid_3z <- skink |> add_grid(grid_3z)


# FIGS ----
plot_grid(grid_44, skink_grid_44)
ggsave("inst/papers/figs/fig1.jpeg",width = 10, height = 10)
plot_grid(grid_22, skink_grid_22)
ggsave("inst/papers/figs/fig2a.jpeg",width = 10, height = 10)
plot_grid(grid_1010, skink_grid_1010)
ggsave("inst/papers/figs/fig2b.jpeg",width = 10, height = 10)
plot_grid(grid_66, skink_grid_66, zone_fill = TRUE)
ggsave("inst/papers/figs/fig3.jpeg",width = 10, height = 10)
plot_entropy(skink_grid_66)
ggsave("inst/papers/figs/fig4a.jpeg",width = 10, height = 10)
plot_spi(grid_66, skink_grid_66)
ggsave("inst/papers/figs/fig4b.jpeg",width = 10, height = 10)
ggsave("inst/papers/figs/fig6.jpeg",width = 10, height = 10)
plot_ei(grid_2z, skink_grid_2z)
ggsave("inst/papers/figs/fig5.jpeg",width = 10, height = 10)
plot_ei(grid_3z, skink_grid_3z)
ggsave("inst/papers/figs/fig5.jpeg",width = 10, height = 10)
