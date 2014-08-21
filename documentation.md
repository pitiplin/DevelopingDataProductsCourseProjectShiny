### Housing prices in US cities 86-94 Exploratory Data

#### Introduction

This application is based on the Housing prices in US cities 86-94 database available through the "hprice" data within "faraway" package.

Source code is available on the [GitHub](https://github.com/pitiplin/DevelopingDataProductsCourseProjectShiny).

The format of the data is a data frame with 324 observations on the following 8 variables:

- narsp.  Log average sale price

- ypc.  Average per capita income

- perypc.  Percentage growth in per capita income

- regtest.  Regulatory environment index (high values = more regulations)

- rcdum.  Rent control - a factor with levels 0=no 1=yes

- ajwtr.  Adjacent to a coastline - a factor with levels 0=no 1=yes

- msa.  Indicator for the MSA

- time.  Year 1=1986 to 9=1994

You can access to the application by clicking "Application" button, that is on top of the window.

#### Layout

The application has three different panels:  sidebar panel, information panel and main panel.

##### Sidebar Panel

On the top-left of the window.  You can adjust date range by using the slider called "Year".  Also, you can choose the way you want to visualize the data: as a table, where data is presented by a normal dataframe, or plot a graph with the desire variables.

If "Show Plot" is selected, you can choose both axis (horizontal-X, vertical-Y) in order to make a plot with that values.  Notice that even if it's mandatory to select a variable of the dataset for the X axis, you can select "NONE" for the Y axis.  In this case, a histogram will be displayed.

##### Information Panel

On the top-right of the window.  "Min Year", "Max Year" and "Selected Visualization" are always visible to the user and correspond to the selections made on the sidebar panel.  If "Show Plot" is selected and "NONE" for the Y axis, the mean and the standard deviation of the variable selected for the X axis is shown.  In the case of Y axis is different from "NONE", this information is hidden.

##### Main Panel

Located at the bottom of the window.  If "Show Table" is selected a table with the values of the variables of the dataset adjusted by the year filter is displayed.  Several options can by used, as records per page, order by a specific variable, search, etc.  In the case of "Show Plot"" is selected, a graph is displayed.  If "NONE" is chosen for the Y axis, a histogram of the variable of the X axis is shown.  In the case of a variable is selected for the Y axis a plot involving both parameters is displayed with a red line indicating a simple linear model regression.
