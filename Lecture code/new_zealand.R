# create with this code
school_data <- read_csv("https://catalogue.data.govt.nz/datastore/dump/4b292323-9fcc-41f8-814b-3c7b19cf14b3?bom=True") %>%
    janitor::clean_names() %>%
    filter(longitude > 0)

school_data %>%
    drop_na(latitude) %>%
    ggplot() +
    scale_x_continuous(limits=c(160, 190)) +
    geom_point(aes(y = latitude,
                   x = longitude))
