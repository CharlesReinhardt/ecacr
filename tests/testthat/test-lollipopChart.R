test_that("women's goals lollipopChart dimensions are expected", {
  plot <- lollipopChart(var="Goals")
  lens <- c(21, 2, 2, 2, 0, 4, 2, 7, 5)
  n <- length(plot)

  for (i in 1:n) {
    expect_equal(length(plot[[i]]), lens[i])
  }
})

test_that("men's assists lollipopChart dimensions are expected", {
  plot <- lollipopChart(var="Assists", gender="men")
  lens <- c(21, 2, 2, 2, 0, 4, 2, 7, 5)
  n <- length(plot)

  for (i in 1:n) {
    expect_equal(length(plot[[i]]), lens[i])
  }
})
