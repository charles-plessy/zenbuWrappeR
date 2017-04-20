#' mkSampleDescription
#'
#' @return a function that gives a description to a ....

sampleDescription <- Vectorize(
  function(sample)
    paste(sample, Moirai_DIR(sample), "Timecourse", "knitrUpload")
)

#' tagMetaTable
#'
#' Function to create a metadata control file for \code{zenbu_upload}.
#' 
#' Note that for the initial tagging, it is recommented to pass the metadata
#' with the file upload in pseuto-GFF format.
#' 
#' @param Key A colum name, to be used as source for metadata.
#' @param Samples A data frame describing the samples, in which the column
#'        \dquote{Rownames} exists.

tagMetaTable <- function(Key, Samples)
  data.frame(
    filter  = sampleDescription(Samples$Rownames)
    , command = "add"
    , key     = Key
    , value   = Samples[[Key]] %>% as.character
    , stringsAsFactors = FALSE
  )

#' mkMetaTable
#' 

mkMetaTable <- function(Keys) {
  if (! all( Keys %in% colnames(samples)))
    stop("Some keys are not in the samples table")
  Reduce(
    function(DF, Key) rbind(DF, tagMetaTable(Key))
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
#' @examples 
#' colnames(airquality)
#' tableToMeta(head(airquality))
#' 
#' @export tableToMeta

tableToMeta <- function(df)
  apply(df, 1, function(X) paste(colnames(df), X, sep="=", collapse = ";"))
