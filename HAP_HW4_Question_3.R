library(MASS)
library(ggplot2)
library(mgcv)

cars93 <- MASS::Cars93

main_plot <- ggplot(cars93, aes(x = Price, y = Fuel.tank.capacity)) +
  geom_point(color = "grey60") +
  geom_smooth(se = FALSE, method = "loess", formula = y ~ x, color = "#0072B2") +
  scale_x_continuous(
    name = "Price (USD)",
    breaks = c(20, 40, 60),
    labels = c("$20,000", "$40,000", "$60,000")
  ) +
  scale_y_continuous(name = "Fuel Tank Capacity (US Gallons)") +
  ggtitle("Relationship Between Car Price and Fuel Tank Capacity") +
  theme(
    plot.title = element_text(size = 14, color = "#0072B2")
  )

print(main_plot)

create_plot <- function(data, method, color, title_text) {
  ggplot(data, aes(x = Price, y = Fuel.tank.capacity)) +
    geom_point() +
    geom_smooth(method = method, se = TRUE, color = color) +
    labs(
      title = title_text,
      x = "Price (USD)",
      y = "Fuel Tank Capacity (US Gallons)"
    ) +
    theme(
      plot.title = element_text(size = 14, color = color),
      axis.title.x = element_text(size = 12),
      axis.title.y = element_text(size = 12)
    )
}

plot_lm <- create_plot(cars93, "lm", "#8fe388", "LM: Fuel Tank Capacity vs. Car Price")
plot_glm <- create_plot(cars93, "glm", "#fe8d6d", "GLM: Fuel Tank Capacity vs. Car Price")
plot_gam <- create_plot(cars93, "gam", "#7c6bea", "GAM: Fuel Tank Capacity vs. Car Price")

print(plot_lm)
print(plot_glm)
print(plot_gam)
