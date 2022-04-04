test_that("women's scatter (no trend) dimensions are expected", {
  plot <- scatterPlot("Goals", "Assists", FALSE)
  n <- length(plot)
  lens <- c(21, 1, 2, 2, 0, 5, 2, 7, 3)
  for (i in 1:n) {
    expect_equal(length(plot[[i]]), lens[i])
  }
})

test_that("men's scatter (no trend) dimensions are expected", {
  plot <- scatterPlot("Goals", "Assists", FALSE, gender="men")
  n <- length(plot)
  lens <- c(21, 1, 2, 2, 0, 5, 2, 7, 3)
  for (i in 1:n) {
    expect_equal(length(plot[[i]]), lens[i])
  }
})

test_that("women's scatter (w/ trend) dimensions are expected", {
  plot <- scatterPlot("Goals", "Assists", TRUE, gender="women")
  n <- length(plot)
  lens <- c(21, 2, 2, 2, 0, 5, 2, 7, 3)
  for (i in 1:n) {
    expect_equal(length(plot[[i]]), lens[i])
  }
})

test_that("men's scatter (w/ trend) dimensions are expected", {
  plot <-scatterPlot("Goals", "Assists", TRUE, gender="men")
  n <- length(plot)
  lens <- c(21, 2, 2, 2, 0, 5, 2, 7, 3)
  for (i in 1:n) {
    expect_equal(length(plot[[i]]), lens[i])
  }
})
