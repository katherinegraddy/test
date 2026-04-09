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




