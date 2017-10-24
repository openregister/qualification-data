# Explore Ofqual's lists

library(tidyverse)
library(stringr)
library(here)

list.files(here("lists", "ofqual"))

qualifications <- read_csv(here("lists", "ofqual", "Qualifications.csv"))
organisations <- read_csv(here("lists", "ofqual", "Organisations.csv"))
qualification_units <- read_csv(here("lists", "ofqual", "QualificationUnits.csv"))
units <- read_csv(here("lists", "ofqual", "Units.csv"))

# QUALIFICATIONS ---------------------------------------------------------------

glimpse(qualifications)

# They have a unique ID, as well as Regulation start date, Operational start and end,
# and certification start and end
# Date
# TODO: use the greater of Regulation Start Date and Operational Start Date? as
# the start-date?
distinct(qualifications, `Qualification Number`)

qual_dates <- select(qualifications, `Qualification Number`, contains("Date"))
filter(qual_dates, `Regulation Start Date` < `Operational Start Date`)
filter(qual_dates, `Regulation Start Date` == `Operational Start Date`)
filter(qual_dates, `Regulation Start Date` > `Operational Start Date`)
filter(qual_dates, `Operational Start Date` < `Operational End Date`)
filter(qual_dates, `Operational Start Date` == `Operational End Date`)
filter(qual_dates, `Operational Start Date` > `Operational End Date`)
filter(qual_dates, `Operational End Date` < `Certification End Date`)
filter(qual_dates, `Operational End Date` == `Certification End Date`)
filter(qual_dates, `Operational End Date` > `Certification End Date`)

count(qualifications, `Qualification Type`) %>% print(n = Inf)
count(qualifications, `Qualification Status`) %>% print(n = Inf)

# TODO: What is the `Owner Organisation Recognition Number`?

# TODO: Level and Sub Level?
count(qualifications, `Qualification Level`)
count(qualifications, `Qualification Sub Level`)

# TODO: `Offered in England`
# TODO: `Offered in Wales`
# TODO: `Offered in Northern Ireland`
# TODO: Scotland??

# TODO: Pathways are notes, not for a register
count(qualifications, `Pathways`)

# TODO: What gets an Organisation into the register?
count(qualifications, `Overall Grading Type`)

# TODO: subrejister of assessment methods
distinct(qualifications, `Assessment Methods`) %>%
  mutate(`Assessment Methods` = map(`Assessment Methods`,
                                    str_split,
                                    pattern =  ",[^[:alnum:]]+"),
         `Assessment Methods` = map(`Assessment Methods`, unlist)) %>%
  unnest() %>%
  distinct()

# TODO: Credits are derived from qualification time (see docs) but it clearly
# isn't consistent, e.g. 0 credits, NA credits, NA time.
count(qualifications, `Total Credits`, sort = TRUE)
qualifications %>%
  count(`Total Credits`, `Total Qualification Time`) %>%
  print(n = Inf)

# TODO: specialisms are not a thing
count(qualifications, `Specialisms`, sort = TRUE)

# TODO: a register of sectors?
count(qualifications, `Qualification SSA`, sort = TRUE) %>% print(n = Inf)

# ORGANISATIONS ----------------------------------------------------------------

glimpse(organisations)

# TODO: do they have a company number?
count(organisations, Status)

# UNITS ------------------------------------------------------------------------

glimpse(units)

# TODO: is a unit part of a qualification?

# QUALIFICATION UNITS ----------------------------------------------------------

glimpse(qualification_units)

# TODO: Can this map be represented in cardinality=n fields?
