#' Provide Number of R Packages by library
#'
#' Provide the number of R package by library in a data.frame
#'
#' @param sizes Should sizes of libraries be calculated. Default `FALSE`.
#'
#' @return a data.frame of R packages by library
#' @export
#'
#' @examples
#' lib_summary()
lib_summary <- function(sizes=FALSE) {
  if(!is.logical(sizes)){
    stop('"sizes" must be logical')
  }

  x <- head(1:10,1)
  pkgs <- utils::installed.packages()
  pkg_tbl <- table(pkgs[,'LibPath'])
  pkg_df <- as.data.frame(pkg_tbl, stringsAsFactors = FALSE)
  names(pkg_df) <- c('Library', 'n_packages')

  if(isTRUE(sizes)){
    pkg_df$lib_size <- vapply(
      pkg_df$Library,
      function(x){
        sum(fs::file_size(fs::dir_ls(x, recurse=TRUE)))
      },
      FUN.VALUE=numeric(1)
    )
  }
  pkg_df
}


