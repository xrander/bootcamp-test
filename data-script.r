
# Species name ------------------------------------------------------------
species_name <- c("alder", "aspen", "beech", "birch", "fir", "hornbeam", "oak",
                  "pine", "poplar", "spruce")

# Read ODS Sheet ----------------------------------------------------------

# Read all the sheets in the ODS file at once
species_list <- map(species_name, \(x) read_ods(
  "data/inventory_data.ods", 
  sheet = x, skip = 3 # sheets have a common skip number for metadata
  ) |>        
    mutate(
      species = x,
      across(1:5, as.numeric)
    ) |> 
    janitor::clean_names()
)

species_tbl <- list_rbind(species_list)

species_tbl <- species_tbl |> filter(!is.na(age_min))

skimr::skim(species_tbl)

write_csv(species_tbl, "data/inventory_data.csv")

