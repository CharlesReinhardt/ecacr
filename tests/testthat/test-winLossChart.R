lensFacet <- c(27, 1, 2, 1, 0, 5, 3, 8, 5)
lensNoFacet <- c(27, 1, 2, 1, 0, 5, 2, 8, 5)
teamNames <- c("brown", "clarkson", "colgate", "cornell", "dartmouth",
               "harvard", "princeton", "quinnipiac", "rensselaer",
               "stlawrence", "union", "yale")
test_that("winLossChart dimensions (men/women, location/nolocation) are expected", {

  for (i in 1:length(teamNames)) {
    team <- teamNames[i]

    chart1 <- winLossChart(team=team, byLocation=TRUE, gender="women")
    chart2 <- winLossChart(team=team, byLocation=TRUE, gender="men")

    chart3 <- winLossChart(team=team, byLocation=FALSE, gender="women")
    chart4 <- winLossChart(team=team, byLocation=FALSE, gender="men")

    for (i in 1:length(chart1)) {
      eq1 <- length(chart1[[i]]) == lensFacet[i]
      eq2 <- length(chart2[[i]]) == lensFacet[i]

      eq3 <- length(chart3[[i]]) == lensNoFacet[i]
      eq4 <- length(chart4[[i]]) == lensNoFacet[i]

      expect_true((all(eq1, eq2, eq3, eq4)))
    }
  }

})

