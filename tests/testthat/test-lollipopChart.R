test_that("women's goals lollipopChart dimensions are expected", {
  plot <- lollipopChart("Goals")
  lens <- c(21, 2, 2, 2, 0, 4, 2, 6, 5)
  n <- length(plot)

  for (i in 1:n) {
    expect_equal(length(plot[[i]]), lens[i])
  }
})

test_that("men's assists lollipopChart dimensions are expected", {
  plot <- lollipopChart("Assists", gender="men")
  lens <- c(21, 2, 2, 2, 0, 4, 2, 6, 5)
  n <- length(plot)

  for (i in 1:n) {
    expect_equal(length(plot[[i]]), lens[i])
  }
})
