# Create registers from the second set of lists from Ofqual

library(tidyverse)
library(readxl)
library(lubridate)
library(here)

list_types <- read_excel(here("lists", "ofqual",
                              "OfqualRegister_ReferenceData_20171113.xlsx"),
                              "Qualification Types")
list_subjects <- read_excel(here("lists", "ofqual",
                                 "OfqualRegister_ReferenceData_20171113.xlsx"),
                                 "Sector Subject Areas")
list_levels <- read_excel(here("lists", "ofqual",
                               "OfqualRegister_ReferenceData_20171113.xlsx"),
                               "Qualification Levels")

list_types %>%
  select(-ID) %>%
  rename(`qualification-type` = Code,
         name = Description,
         `start-date` = ValidStartDate,
         `end-date` = ValidEndDate) %>%
  mutate(`start-date` = if_else(`start-date` == ymd_hms("1900-01-01 00:00:00"),
                                as.POSIXct(NA),
                                `start-date`),
         `end-date` = if_else(`end-date` == ymd_hms("2099-12-31 00:00:00"),
                              as.POSIXct(NA),
                              `end-date`),
         `start-date` = format(`start-date`, "%Y-%m-%d"),
         `end-date` = format(`end-date`, "%Y-%m-%d")) %>%
  print(n = Inf) %>%
  write_tsv(here("data", "qualification-type.tsv"), na = "")

# Subjects were done manually because they're hierarchichal, which was a faff in
# code.

# Levels were done manually because they're a flattened hierarchy,
# which is a pain in code.
