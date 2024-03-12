# Satellite data visualisation in R by imageRy

library(terra)
library(imageRy)

# list of data available in imageRy
im.list()

# Importing data
# assegnamo all'importazione il nome mato per semplicficare
mato <- im.import("matogrosso_ast_2006209_lrg.jpg")

