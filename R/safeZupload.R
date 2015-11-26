#' safeZupload
#' 
#' Safely upload a file to Zenbu.
#' 
#' Uploads a file to a Zenbu server using the zenbuUpload function.
#' If the file has already been uploaded with the same description,
#' skip it.  This is particularly useful when uploading from knitR
#' documents.
#' 
#' The parameters are passed as is to zenbuUpload.
#' 
#' WARNING: as long as the file is still in Zenbu's upload
#' cache, it will not prevent safeZupload to send it again.
#' Thus, safeZupload is not completely safe.
#' 
#' @params file The file to upload.
#' @params name Display name.
#' @params desc Description.
#' @params assembly Genome assembly name.
#' @params ... Other parameters passed to zenbuUpload.
#' 
#' @importFrom magrittr "%>%"
#' 
#' @seealso zenbuUpload
#' 
#' @export

safeZupload <- function (file, name, assembly, desc, ...) {
  
  notFound <- function(file, desc)
    zenbuUpload( "-list", "-filter", desc) %>%
    tail(1) %>%
    grepl ("0 uploads --- 0 featuresources --- 0 experiments --- \\[0 total sources\\]", .)

  if(notFound(file, desc))
    zenbuUpload( "-file",        file
               , "-name",        name
               , "-assembly",    assembly
               , "-desc",        desc
               , stdout="")
}