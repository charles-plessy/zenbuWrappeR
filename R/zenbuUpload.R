#' zenbuUpload
#' 
#' Wrapper to the zenbu_upload command-line tool of Zenbu
#' 
#' @param ... passed to the shell command directly
#' @param URL URL to the Zenbu browser.
#' @param verbose Print in R the shell command.
#' @param echo Echo in shell the arguments passed.
#' @param stdout Passed to the `system2` command.
#' 
#' @examples
#' \dontrun{
#' zenbuUpload("-collabs")
#' }
#' 
#' @export

zenbuUpload <- function ( ...
                        , URL="http://fantom.gsc.riken.jp/zenbu"
                        , verbose=FALSE
                        , echo=FALSE
                        , stdout=TRUE) {
  zenbu <- 'zenbu_upload'
  url <- c('-url', URL)
  args <- sapply(c(url, ...), shQuote)
  if (verbose == TRUE) print(paste(c(zenbu, args), collapse=' '))
  if (echo    == FALSE) {
    system2(zenbu, args, stdout=stdout)
  } else {
    system2('echo', c(zenbu, args), stdout=stdout)
  }
}
