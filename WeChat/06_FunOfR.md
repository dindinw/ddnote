玩玩R
====

Install
-------
Download [R](http://cran.r-project.org/) and [RStudio](http://www.rstudio.com/ide/)

Learn a little R 
----------------------
* [Getting Started With R ](https://support.rstudio.com/hc/en-us/articles/201141096-Getting-Started-with-R)
* [Try R by O'reilly] (http://tryr.codeschool.com/)
More Advanced Guide 
* [Beginner's guide to R: Introduction](http://www.computerworld.com/article/2497143/business-intelligence/business-intelligence-beginner-s-guide-to-r-introduction.html)
* [R Cookbook](http://www.cookbook-r.com/)
* [Advanced R by Hadley Wickham's Style Guide](http://adv-r.had.co.nz/Style.html)
* [R's colorblind-friendly palette](http://www.cookbook-r.com/Graphs/Colors_\(ggplot2\)/) and [here](http://jfly.iam.u-tokyo.ac.jp/color/)

Map in R
--------
* Maps in R: Introduction - Drawing the map of Europe (http://www.milanor.net/blog/?p=534)
* Maps in R: Plotting data points on a map (http://www.milanor.net/blog/?p=594)
* Maps in R: choropleth maps (http://www.milanor.net/blog/?p=634)
* Worldmap polygon fill color based on category data
(http://stackoverflow.com/questions/22995626/worldmap-polygon-fill-color-based-on-category-data)
* use different hue ranges for fill and line color
(http://stackoverflow.com/questions/9558040/ggplot-map-with-l)
* Create animated choropleth map by `ggplot2` and `animation`
(https://anhqle.wordpress.com/2013/06/25/create-animated-choropleth-map-ggplot2-animation/)

Data Set
--------
* World Borders Dataset http://thematicmapping.org/downloads/world_borders.php
* 世界历史地图集“及时间表 从公元前3000年开始 http://geacron.com/ 
* OpenStreetMap https://www.openstreetmap.org/about
* The map as history : The largest on-line collection of animated historical maps (http://www.the-map-as-history.com/index.php)
* Atlas of World History (http://www.atlasofworldhistory.com/)
* Google's Fusion Tables Example Gallery (https://sites.google.com/site/fusiontablestalks/stories)
* About Fusion Tables (https://support.google.com/fusiontables/answer/2571232)
* A example of Fusion Table Advanced usage for GoogleMap (https://developers.google.com/maps/documentation/javascript/examples/layer-fusiontables-styling)

A Step by Step Example
----------------------
> The original example coming from https://journal.r-project.org/archive/2010-1/RJournal_2010-1_Weidmann+Skrede~Gleditsch.pdf

```r
> install.packages("cshapes",dependencies = TRUE)
> library(cshapes)
> cmap.2014 <- cshp(date=as.Date("2014-1-1"))
> install.packages("foreign",dependencies = TRUE)
> library(foreign)
> polity.file <- paste(tempdir(),"p4v2014.sav", sep="/")
> download.file("http://www.systemicpeace.org/inscr/p4v2014.sav", polity.file)
> polity <- read.spss(polity.file, to.data.frame=T)
> polity.2014 <- polity[polity$year==2014,]
> polity.2014 <- subset(polity.2014,!is.na(polity2), select=c(ccode, polity2))
> o <- match(cmap.2014$COWCODE, polity.2014$ccode)
> polity.2014 <- polity.2014[o,]
> row.names(polity.2014) <- cmap.2014$FEATUREID
> cmap.2014.m <- spCbind(cmap.2014, polity.2014)
> pal <- grey.colors(3, 0.25, 0.95)
> install.packages("classInt",dependencies = TRUE)
> library(classInt)
> breaks <- classIntervals(cmap.2014.m$polity2,n=3, style="fixed", fixedBreaks=c(-10, -6, 7, 10))
> colors <- findColours(breaks, pal)
> plot(cmap.2014.m, bty="n", col=colors)
> legend(x="bottomleft", legend=c("Autocracy", "Anocracy", "Democracy"),fill = attr(colors, "palette"),bty = "n", title="Regime type")
```



![Map](https://mmbiz.qlogo.cn/mmbiz/ykYribFYPpbbfcxzrE8Z5wFjNRdUicBzrEtfoB1UliaVL54Q21QA6vZmI3FpSeELgvBicJB0D79YAYymiaxJPYNmZUQ/0?wx_fmt=png)

