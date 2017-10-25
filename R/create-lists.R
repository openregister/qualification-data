# Create some discovery lists, having explored in explore.R and spoken to the
# custodian

library(tidyverse)
library(stringr)
library(here)

qualifications <- read_csv(here("lists", "ofqual", "Qualifications.csv"))

# qualification-level
qualifications %>%
  rename(name = `Qualification Level`) %>%
  distinct(name) %>%
  arrange(name) %>%
  mutate(`qualification-level` = row_number() + 10,
         `start-date` = NA,
         `end-date` = NA) %>%
  select(`qualification-level`, everything()) %>%
  write_tsv(here("data", "qualification-level.tsv"), na = "")

# This is trickier, will talk to the custodian first
# count(qualifications, `Qualification Sub Level`)

# This is the European Qualifications Framework, so probably not a register
# count(qualifications, `EQF Level`)

# qualification-type
qualifications %>%
  rename(name = `Qualification Type`) %>%
  distinct(name) %>%
  arrange(name) %>%
  mutate(`qualification-type` = row_number() + 10,
         `start-date` = NA,
         `end-date` = NA) %>%
  select(`qualification-type`, everything()) %>%
  write_tsv(here("data", "qualification-type.tsv"), na = "")

# qualification-sector-subject-area
qualifications %>%
  rename(name = `Qualification SSA`) %>%
  distinct(name) %>%
  arrange(name) %>%
  mutate(`qualification-sector-subject-area` = row_number() + 10,
         `start-date` = NA,
         `end-date` = NA) %>%
  select(`qualification-sector-subject-area`, everything()) %>%
  write_tsv(here("data", "qualification-sector-subject-area.tsv"), na = "")

# qualification-assessment-method
qualifications %>%
  rename(name = `Assessment Methods`) %>%
  distinct(name) %>%
  mutate(name = map(name, str_split, pattern =  ",[^[:alnum:]]+"),
         name = map(name, unlist)) %>%
  unnest() %>%
  distinct() %>%
  arrange() %>%
  mutate(`qualification-assessment-method` = row_number() + 10,
         `start-date` = NA,
         `end-date` = NA) %>%
  select(`qualification-assessment-method`, everything()) %>%
  write_tsv(here("data", "qualification-assessment-method.tsv"), na = "")

# Not sure whether this is a thing
# qualifications %>%
#   distinct(Specialisms) %>%
#   mutate(Specialisms = map(Specialisms, str_split, pattern = ", ")) %>%
#   mutate(Specialisms = map(Specialisms, unlist)) %>%
#   unnest() %>%
#   distinct()
