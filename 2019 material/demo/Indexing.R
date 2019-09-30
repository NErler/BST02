#################
# Load packages #
#################

#install.packages("JM")
library(JM)

############
# Indexing #
############

## Select the 3rd element for vector age.
pbc2.id$age[3]
pbc2$age[3]

## Select the 3rd column.
pbc2.id[, 3]
pbc2[, 3]

pbc2.id[[3]]
pbc2[[3]]

## Print the vector sex.
pbc2.id$sex
pbc2$sex

pbc2.id[["sex"]]
pbc2[["sex"]]

## Select the serum bilirubin levels for all females.
pbc2.id$serBilir[pbc2.id$sex == "female"]
pbc2$serBilir[pbc2$sex == "female"]

## Select the age for male patients or patients that have serum bilirubin more than 3.
pbc2.id$age[pbc2.id$sex == "male" | pbc2.id$serBilir > 3]
pbc2$age[pbc2$sex == "male" & pbc2$serBilir > 3]

## Keep the first measurement per patient.
pbc2.idNEW <- pbc2[tapply(row.names(pbc2), pbc2$id, tail, 1), ]

