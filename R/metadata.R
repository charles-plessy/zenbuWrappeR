#' mdKeyToControl
#'
#' Function to create a metadata control file for \code{zenbu_upload}.
#' 
#' Note that for the initial tagging, it is recommented to pass the metadata
#' with the file upload in pseuto-GFF format.
#' 
#' @param Samples A data frame describing the samples, in which the column
#'        \dQuote{Description} exists.
#' @param Key A column name in the \dQuote{Samples} data frame, to be used
#'        as source for metadata.
#' @param command Either \dQuote{add} (default), \dQuote{delete}, or
#'        \dQuote{"change"}.
#'        
#' @seealso mdTableToControl
#' 
#' @export mdKeyToControl
#' 
#' @examples 
#' mdKeyToControl( data.frame(numbers=1:3, booleans=c(T, T, F), Description=c("a", "b", "c"))
#'               , "numbers"
#'               , "delete")

mdKeyToControl <- function(Samples, Key, command=c("add", "delete", "change")) {
  if (! Key %in% colnames(Samples))
    stop(paste0("Samples data frame misses '", Key, "' column."))
  if (! "Description" %in% colnames(Samples))
    stop("Samples data frame misses 'Description' column.")
  if(missing(command)) {
    warning ("Using 'add' as default command.  Set 'command' to suppress this message.")
    command <- "add"
  }
  data.frame(
      filter  = Samples[["Description"]]
    , command = command
    , key     = Key
    , value   = Samples[[Key]] %>% as.character
    , stringsAsFactors = FALSE
  )
}

#' mdTableToControl
#' 
#' Function to create a metadata control file for \code{zenbu_upload}.
#' 
#' @param Samples A data frame describing the samples, in which the column
#'        \dQuote{Description} exists.
#' 
#' @param Keys Colum names in the \dQuote{Samples} data frame.
#' 
#' @param command Either \dQuote{add} (default), \dQuote{delete}, or
#'        \dQuote{"change"}.
#'        
#' @seealso mdKeyToControl
#'        
#' @examples 
#' mdTableToControl( data.frame(numbers=1:3, booleans=c(T, T, F), Description=c("a", "b", "c"))
#'                 , c("numbers", "booleans"))
#' 
#' @export mdTableToControl

mdTableToControl <- function(Samples, Keys, command=c("add", "delete", "change")) {
  if(missing(command)) {
    warning ("Using 'add' as default command.  Set 'command' to suppress this message.")
    command <- "add"
  }
  Reduce(
    function(DF, Key) rbind(DF, mdKeyToControl(Samples, Key, command))
    , Keys
    , data.frame() )
}

#' tableToMeta
#' 
#' Outputs a metadata field in pseudo-GFF format for the
#' \code{zenbu_upload} command-line utility.
#' 
#' @param df A data frame where each column is one source of metadata
#'           and each row corresponds to one file to be uploaded (sorted
#'           in the appropriate order).
#' 
#' @return 
#' Returns a character vector of key-value pairs in \dQuote{pseudo-GFF} format (
#' like \dQuote{key1=value1;key2=value2}), with one element per line in the input
#' data frame, that will be coerced to characters before being used to build the
#' pseudo-GFF string.
#' 
#' @examples 
#' tableToMeta(data.frame(numbers=1:3, booleans=c(T, T, F), characters=c("a", "b", "c")))
#' 
#' @export tableToMeta

tableToMeta <- function(df) {
  # http://stackoverflow.com/questions/2851015/convert-data-frame-columns-from-factors-to-characters
  df[] <- lapply(df, as.character) # Othersise, TRUE can become " TRUE" with unwanted space, etc.
  apply(df, 1, function(X) paste( colnames(df)
                                  , as.character(X)
                                  , sep="="
                                  , collapse = ";"))
}
