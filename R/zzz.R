#' zenbuWrappR
#' 
#' Before a R function provided by this package is run, it will
#' test if the program `zenbu_upload` is in the system PATH.

.onAttach <- function(libname, packagename)
  if (system("which zenbu_upload", ignore.stdout = TRUE) != 0)
    stop("zenbuWrappR: zenbu_upload command not found in the system PATH.")