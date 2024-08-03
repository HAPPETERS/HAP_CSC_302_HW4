library(dplyr)
library(ggplot2)
library(lubridate)  

load('C:/Users/user/Downloads/preprint_growth.rda')

head(preprint_growth)

preprint_growth %>% 
  filter(archive == "bioRxiv") %>%
  filter(count > 0) -> biorxiv_growth

preprints <- preprint_growth %>% 
  filter(archive %in% c("bioRxiv", "arXiv q-bio", "PeerJ Preprints")) %>%
  filter(count > 0) %>%
  mutate(archive = factor(archive, levels = c("bioRxiv", "arXiv q-bio", "PeerJ Preprints")))

preprints_final <- filter(preprints, date == ymd("2017-01-01"))

ggplot(preprints) +
  aes(date, count, color = archive, fill = archive) +
  geom_line(size = 1) +
  scale_y_continuous(
    limits = c(0, 600), expand = c(0, 0),
    name = "preprints / month",
    sec.axis = dup_axis(
      breaks = preprints_final$count,
      labels = c("arXiv q-bio", "PeerJ Preprints", "bioRxiv"),
      name = NULL
    )
  ) +
  scale_x_date(
    name = "year",
    limits = c(ymd("2015-01-01"), ymd("2017-01-01")) # Modified start date
  ) +
  scale_color_manual(
    values = c("#E69F00", "#56B4E9", "#F0E442"), # Modified colors
    name = NULL
  ) +
  theme(legend.position = "none")

#https://chatgpt.com/share/c1765bde-2dd4-45f6-a37a-ac412dc25448