---
title: "classwork-Thurs-3-2"
author: "Jeremy Wadowski"
date: "March 9, 2017"
output: md_document
---
```{r}
library("ggplot2")
canids <- read.csv("/home/eeb177-student/Desktop/eeb-177/class-assignments/canids/canid-ranges-sorted.csv", header = F, as.is = T)
names(canids) <- c("genus", "species", "minage", "maxage")
head(canids)

canid_occ <- ggplot(canids, aes( species, ymin = maxage, ymax=minage, colour = genus))# plot data
canid_occ <- canid_occ + geom_linerange() # draw ranges
canid_occ <- canid_occ + theme(legend.position="none") # remove legend
canid_occ <- canid_occ + coord_flip() # flip labels
canid_occ <- canid_occ +  theme(axis.text.y = element_text(size=3)) # make species names smaller
canid_occ <- canid_occ + theme(axis.ticks.y=element_blank()) # remove tick marks
canid_occ <- canid_occ + scale_y_continuous(limits=c(0, 40), expand = c(0, 0), breaks=c(0, 10, 20, 30, 40)) # reduce empty space
canid_occ <- canid_occ + labs(title = "Canid Fossil Occurrences", x = "Species", y = "Ma ago") + theme(plot.title = element_text(hjust = 0.5, size=22, face = "bold"), axis.title =element_text(size=20)) #adding title and modifying axes
canid_occ

library(paleotree)
library(paleobioDB)
data(graptPBDB)
occSpecies <- taxonSortPBDBocc(graptOccPBDB, rank="species")
plotOccData(occSpecies,groupLabel = "Species")

graptTimeSpecies <- occData2timeList(occList = occSpecies)
taxicDivDisc(graptTimeSpecies)
head(graptTimeSpecies)

occGenera <-taxonSortPBDBocc(graptOccPBDB, rank="genus")
occFamily <-taxonSortPBDBocc(graptOccPBDB, rank=("family"))
head(occSpecies)


pdf(file= "ranges.pdf")
plotOccData(occSpecies,groupLabel = "Species")
plotOccData(occGenera, groupLabel = "Genera")
plotOccData(occGenera, groupLabel = "Families")
dev.off()

graptTimeSpecies<-occData2timeList(occList=occSpecies)
graptTimeGenus<-occData2timeList(occList=occGenera)
graptTimeFamily<-occData2timeList(occList=occFamily)

layout(1:3)
taxicDivDisc(graptTimeSpecies)
taxicDivDisc(graptTimeGenus)
taxicDivDisc(graptTimeFamily)
dev.off()

pdf(file="dtt.pdf")
taxicDivDisc(graptTimeSpecies)
taxicDivDisc(graptTimeGenus)
taxicDivDisc(graptTimeFamily)
dev.off()

library(paleobioDB)
canids <-pbdb_occurrences(limit="all", vocab= "pbdb", base_name="Canidae", show=c('phylo','ident'))
head(canids)
```

