#' zenbuTag
#' 
#' Add metadata to data sources identified by a filter search
#' 
#' @seealso zenbuUpload
#' 
#' @importFrom magrittr "%>%"
#' @export

zenbuTag <- function (filter, key, value, mode='add', ...) {
  if (mode == "add") {
    args <- c('-mdedit', filter, mode, key, value)
    zenbuUpload (args, ...)
  } else {
    stop ("At the moment, only the 'add' mode is supported, sorry.")
  }
}