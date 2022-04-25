## March 21

Found a table of ECAC data to scrape and came up with a name for my R package (ecacr). Read some portions of "creating an r package" book from Dr. Higham.

## March 23 Beginning of Class

Got a simple hello world function working and set up a lot of documentation and testing stuff. Started on scraping data and turning that into a package function. 

## March 23 End of Class

Got team_stats scraping function working, working on exporting that properly so I can start playing around with the stats in a separate rmarkdown. Looking to start get some good visualizations to know what I want users of the package to be able to make.

## March 28 Beginning of Class

I got swamped with other work and life stuff so I was not able to work on my project over the last 5 days. Plan for today is to start playing around with some visualizations and hopefully creating a lollipop plot function or something. 

## March 28 End of Class

Got team_stats() fully functional (minus error checking and testing). Got a mostly working lollipop chart going in a separate playground document, moving forward plan is to get it implemented into the package and add a bit more customization. 

## March 30 Beginning of class

Error checked and tested for teamStats(). base lollipopChart function is working in package. declared dependencies in DESCRIPTION. Casually chatted with Dr.RLock about learnr.

`learnr` is so cool! I've thought about making some `learnr` tutorials to use as an introduction in STAT/DATA 234....but have not had the time :)

## March 30 End of Class

Developed scatterplot function, some helper functions (check variable names, titleCase)

## April 4 Beginning of class

Implemented basic tests for lollipopChart and scatterplot functions (based solely on dimensions). I think I also attached dependencies correctly!! Not positive though. 

## April 4 End of class

Merged a comment that dr. higham made to my project. Was really scary. Played around with scraping individual and game data, next step is turning it into a function.

## April 6 before class

Made individual scraping function. Planning on adding "all" team functionality and then formally testing the function.

## April 6 End of Class

Made a function to scrape all teams individual player statistics. Working on error checking the arguments to that function, and how I want to deal with optional or missing function arguments. Found a few good online resources that I will consult over the weekend.



## April 11 Beginning of class

Decided how to deal with missing arguments. Formally tested indiv stats scraper. Created a histogram function for individual statistics. Played around with boxplots and alternatives for individual statistics

## April 13 beginning of class

REALLY hammered away on how to properly join and scrape attendance and game data. Made it into a function. Decided to do boxplot (instead of alternatives, at brendo's suggestion). 

## April 13 end of class

Tested my scraping game stats formally and fixed some broken old functions. 

## April 18 beginning of class

Fixed scraping game stats and worked on manipulating the date column into an actual date. Investigated some game stat graphs, and how to visualize wins/losses and game location (home/away). Made a function for win/losses.

## April 18 end of class

Documented win/loss function, cleaned up some old functions. Implemented conference and non-conference capabilities for team data, as well as for their associated visualizations. Wrote formal tests for winLossChart. 108 tests! Inflating test count well!!

## April 20 beginning of class

Made a boxplot function, but didn't like it. Modified it to take game stats (a function I just made, to scrape all game stats) and liked it. Likely going to finish off with graphs and start working on learnr or other documentation form.

## April 20 end of class

Adjusted some utils function uses. Worked on an overall leaders graph. Put it into R folder. Updated classmate_projects document that I've been forgetting to update for a few weeks, sorry! Totally unintentional, has been good to chat with classmates about their projects.

## April 25 beginning of class

Refactored function argument style to be uniform (and better) across the package. Wrote roxygen documentation (relatively uniform) for all package functions. Ensured package was still passing tests (by modifying function calls etc.)

## April 25 end of class

got a github pages pkgdown site up and running! It is currently super empty (obviously). Working on fixing a couple broken functions.

# TODO develop README.Rmd for gh_pages site
# TODO how to publish package? or how to download unpublished package?4

# TODO test histogram function
# TODO test boxplot function
# TODO test overallLeaders Function


