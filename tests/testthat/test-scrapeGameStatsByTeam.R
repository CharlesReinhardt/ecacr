validTeams <- c("brown", "clarkson", "colgate", "cornell", "dartmouth", "harvard",
                "princeton", "quinnipiac", "rensselaer", "stlawrence", "union", "yale")

test_that("scrapeGameStatsByTeam dimensions are expected", {
  for (i in 1:length(validTeams)) {
    team <- validTeams[i]
    data <- scrapeGameStatsByTeam(team, gender="women")
    dataMen <- scrapeGameStatsByTeam(team, gender="men")
    expect_equal(length(data), 25)
    expect_equal(length(dataMen), 25)
  }
})

varNames <- c("Date", "Team", "Opponent", "Home", "Won", "Loss", "Tie",
              "Goals", "Assists", "Shots", "PenaltyMinutes", "PowerPlayGoals",
              "PowerPlayOpportunities", "PowerPlayPercent", "PowerPlayGoalsAgainst",
              "TimesShortHanded", "PenaltyKillPercent", "ShortHandedGoals", "ShortHandedGoalsAgainst",
              "GoalsAgainst", "GoalsAgainstAverage", "Saves", "SavePercent",
              "EmptyNetGoalsAgainst", "Attend")

test_that("scrapeGameStatsByTeam variable names are expected", {
  for (i in 1:length(validTeams)) {
    team <- validTeams[i]
    data <- scrapeGameStatsByTeam(team, gender="women")
    dataMen <- scrapeGameStatsByTeam(team, gender="men")
    names <- names(data)
    namesMen <- names(dataMen)
    expect_true(all(names == varNames))
    expect_true(all(namesMen == varNames))
  }
})

test_that("scrapeGameStatsByTeam home/away appears to give both true/false", {
  for (i in 1:length(validTeams)) {
    team <- validTeams[i]
    data <- scrapeGameStatsByTeam(team, gender="women")
    dataMen <- scrapeGameStatsByTeam(team, gender="men")
    expect_false(all(data$Home))
    expect_false(all(dataMen$Home))
  }
})
