#' Load atlas file
#'
#' Load ROI information associated with an atlas.
#'
#' @param atlas Name of atlas (see details)
#' @return A data frame
#' @details Current supports the following atlases:
#' \itemize{
##'  \item{"schaefer17_400"}{Schaefer 400 region parcelation (Yeo networks).}
##'  \item{"SUIT28cb"}{28 regions cerebellar parcellation modelled after the
##'  SUIT atlas described by Diedrichsen (2006).}
##'  \item{"Subcort14bg"}{Rudimentary parcellation of the basal ganglia.}
##' }
#' @export

LoadAtlasInformation <- function(atlas) {
    if (!atlas %in% c('schaefer17_400', 'SUIT28cb', 'Subcort14bg'))
        stop(paste('Unrecognized atlas:', atlas))

    path <- system.file(paste0('data/atlases/', atlas, '.rds'), package = 'glass')
    readRDS(path)
}
