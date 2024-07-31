testthat::test_that("calc entropy works", {
  testthat::expect_equal(calc_entropy(1:16), log10(16))
})