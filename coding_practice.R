# 0) Working on Absolute Basics ----------------------------------------------

vector <- c(1,2,3)
list <- c(1, 'two', TRUE)

cat(vector)
cat(list)

combined <- paste (vector, list)

cat(combined)

camp <- c('orojo','gambella','tigray')
survey_round <- c('R8', 'R10', 'R10')
hh_count <- c(110, 1500, 200)
camp_open <- c(T, F, T)

df <- data.frame(survey_round, camp, hh_count, camp_open)
df


survey_round <- sub('R', '', survey_round)

survey_round <- as.numeric(survey_round)

class(survey_round)



# 1) Data Cleaning Steps --------------------------------------------------


# Raw Data Issues:
#   Missing or unclear column names
#   Incorrect data types
#   Duplicate rows
#   Missing (NA) values
#   Inconsistent formats or extra spaces


# Technically Correct Data
#   Meaningful column names are assigned
#   Data types are corrected
#   Duplicates are removed
#   Missing values are identified


# Consistent and Validated Data
#   Missing values are handled
#   Categories and formats are standardised
#   Outliers are checked
#   Value ranges are validated




# 1b) Practice with Dataset ---------------------------------------------------

library(tidyverse)
library(skimr)
library(janitor)
library(corrplot)
library(DescTools)


# Preview Data

air_df <- airquality
head(air_df)
summary(air_df)
skim(air_df) # Note to self: I really like this to see info about the data!
             # Gives histograms, percentiles, completeness rate, data types, etc. 


# Remove Duplicate Rows

air_df <- distinct(air_df)

# Clean Column Names

air_df <- clean_names(air_df)

view(air_df)


# Handle Missing Values  (I want to look into best practices for this)

air_df <- air_df |>
  mutate(
    ozone = ifelse(is.na(ozone), median(ozone, na.rm = TRUE), ozone), # so if_then, and median calculated ignoring NA
    solar_r = ifelse(is.na(solar_r), median(solar_r, na.rm = TRUE), solar_r)
  )

  

skim(air_df) # now missing rate is 0. 


# Correct Data Types and Create Date Column

air_df$month <- as.factor(air_df$month)
air_df$date <- as.Date(paste(1973, air_df$month, air_df$day, sep = "-"))



# Feature Engineering

  # Creating a new categorical variable based on temp.
  # here, based on low, medium, or high


air_df <- air_df |>
  mutate(temp_category = case_when(
    temp < 70 ~ 'Low',
    temp >= 70 & temp < 85 ~ 'Medium',
    TRUE ~ 'High' # Note, this is because case_when is like if_else, 
  ))

table(air_df$temp_category)



# Dealing with Outliers

  # This isn't the way they did it, but I want to do this.

air_df$ozone <- Winsorize(air_df$ozone)

air_df$ozone

summary(air_df$ozone)

# Visualise Cleaned Data

boxplot(air_df[, c('ozone', 'solar_r', 'wind', 'temp')],
        main = 'Boxplot After Cleaning')


# Missing Data ------------------------------------------------------------

 # What are the best approaches, I know it will depend.

# Data Types --------------------------------------------------------------

 # There are a few I mix up... 

# Outliers  --------------------------------------------------------------

 # What else to do other than wincerise?
 # What does it mean to standardize (possibly robustly) first?
