# Nick Williams
# Department of Biostatistics
# Relational Databases Inclass Assignment 9

library(sqldf)
library(tidyverse)

# Importing data

nhanes_demo_code <- read_csv("./NHANES_Demographics Codebook.csv")
nhanes_demo <- read_csv("./NHANES_Demographics.csv")
nhanes_tri <- read_csv("./NHANES_Triglycerides.csv")

# Taking a quick peek

head(nhanes_demo_code)
head(nhanes_demo)
head(nhanes_tri)

# Query 1

table1 <- sqldf("SELECT race_hispanic_origin_w_nh_asian AS race, 
                    COUNT(race_hispanic_origin_w_nh_asian) AS freq, 
                    ROUND(AVG(age_in_years_at_screening), 1) AS mean_age
                FROM nhanes_demo
                GROUP BY race_hispanic_origin_w_nh_asian")

# Query 2

sqldf("SELECT race_hispanic_origin_w_nh_asian AS race, 
          gender, 
          COUNT(respondent_sequence_number) AS freq
      FROM nhanes_demo
      GROUP BY race, gender")

# Query 3

sqldf("SELECT COUNT(pregnancy_status_at_exam) AS preg_at_screen
      FROM nhanes_demo
      WHERE pregnancy_status_at_exam = 1")

# Query 4

sqldf("SELECT COUNT(respondent_sequence_number) AS num_refused
      FROM nhanes_demo
      WHERE gender = 1 AND annual_household_income = 77")

# Query 5

sqldf("SELECT d.gender, ROUND(AVG(t.LDL_cholesterol_mg_dL), 1) AS mean_ldl
       FROM nhanes_demo AS d 
       INNER JOIN nhanes_tri AS t 
          ON d.respondent_sequence_number = t.Respondent_sequence_number
       GROUP BY d.gender")

# Query 6

sqldf("SELECT d.race_hispanic_origin_w_nh_asian AS race, 
          MIN(t.Triglyceride_mmol_L) AS min_tri, 
          MAX(t.Triglyceride_mmol_L) AS max_tri
      FROM nhanes_demo AS d
      INNER JOIN nhanes_tri AS t
          ON d.respondent_sequence_number = t.Respondent_sequence_number
      GROUP BY race")

# Query 7

demo_tri <- sqldf("SELECT d.*, t.*
                  FROM nhanes_demo AS d
                  LEFT JOIN nhanes_tri AS t
                      ON d.respondent_sequence_number = t.Respondent_sequence_number")



