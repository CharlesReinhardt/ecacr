test_that("teamStats dimensions are expected", {
  expect_equal(
    dim(teamStats(gender="women"))[2], 21
    )
  expect_equal(
    dim(teamStats(gender="men"))[2], 21
    )
})

test_that("teamStats col names are expected", {
  expect_true(
    all(
      names(teamStats()) == c("Rk", "Name", "GamesPlayed", "Goals", "Assists", "GoalsPerGame", "Shots", "PenaltyMinutes",
                            "PowerPlayGoals", "PowerPlayOpportunities", "PowerPlayPercent", "PowerPlayGoalsAgainst",
                            "TimesShortHanded", "PenaltyKillPercent", "ShortHandedGoals", "ShortHandedGoalsAgainst",
                            "GoalsAgainst", "GoalsAgainstAverage", "Saves", "SavePercent", "EmptyNetGoalsAgainst")
    )
  )
})

test_that("teamStats is throwing an error on bad arguments", {
  expect_error(teamStats("male"), "gender argument")
  expect_error(teamStats(gender="foo"))
})
