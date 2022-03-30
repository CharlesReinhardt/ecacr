test_that("scrapeTeamStats dimensions are expected", {
  expect_equal(
    dim(scrapeTeamStats(gender="women"))[2], 21
    )
  expect_equal(
    dim(scrapeTeamStats(gender="men"))[2], 21
    )
})

test_that("scrapeTeamStats col names are expected", {
  expect_true(
    all(
      names(scrapeTeamStats()) == c("Rk", "Name", "GamesPlayed", "Goals", "Assists", "GoalsPerGame", "Shots", "PenaltyMinutes",
                            "PowerPlayGoals", "PowerPlayOpportunities", "PowerPlayPercent", "PowerPlayGoalsAgainst",
                            "TimesShortHanded", "PenaltyKillPercent", "ShortHandedGoals", "ShortHandedGoalsAgainst",
                            "GoalsAgainst", "GoalsAgainstAverage", "Saves", "SavePercent", "EmptyNetGoalsAgainst")
    )
  )
})

test_that("scrapeTeamStats is throwing an error on bad arguments", {
  expect_error(scrapeTeamStats("male"), "gender argument")
  expect_error(scrapeTeamStats(gender="foo"))
})
