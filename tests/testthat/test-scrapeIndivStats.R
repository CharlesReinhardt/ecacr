data <- scrapeIndivStats(conf=FALSE, skaters=FALSE, gender="women", verbose=FALSE)
data2 <- scrapeIndivStats(conf=TRUE, skaters=FALSE, gender="women", verbose=FALSE)
data3 <- scrapeIndivStats(conf=FALSE, skaters=TRUE, gender="women", verbose=FALSE)
data4 <- scrapeIndivStats(conf=TRUE, skaters=TRUE, gender="women", verbose=FALSE)
data5 <- scrapeIndivStats(conf=FALSE, skaters=FALSE, gender="men", verbose=FALSE)
data6 <- scrapeIndivStats(conf=TRUE, skaters=FALSE, gender="men", verbose=FALSE)
data7 <- scrapeIndivStats(conf=FALSE, skaters=TRUE, gender="men", verbose=FALSE)
data8 <- scrapeIndivStats(conf=TRUE, skaters=TRUE, gender="men", verbose=FALSE)

test_that("scrapeIndivStats dimensions are as expected", {

  expect_equal(length(data), 16)
  expect_equal(length(data2), 16)
  expect_equal(length(data3), 18)
  expect_equal(length(data4), 18)
  expect_equal(length(data5), 16)
  expect_equal(length(data6), 16)
  expect_equal(length(data7), 18)
  expect_equal(length(data8), 18)

})

test_that("scrapeIndivStats names are expected", {
  skaterNames <- c("No.", "Name", "Year", "Position", "GamesPlayed", "Goals",
             "Assists", "Points", "PenaltyMinutes", "PlusMinus", "PowerPlayGoals",
             "ShortHandedGoals", "EmptyNetGoals", "GameWinningGoals",
             "GameTyingGoals", "HatTricks", "Shots", "Team")
  expect_true(
    all(names(data3) == skaterNames)
  )

  goalieNames <- c("No.", "Name", "Year", "Position", "GamesPlayed", "GamesStarted",
                   "Minutes", "GoalsAgainst", "GoalsAgainstAverage", "Saves", "SavePercentage",
                   "Wins", "Losses", "Ties", "WinPercentage", "Team")
  expect_true(
    all(names(data) == goalieNames)
  )

})
