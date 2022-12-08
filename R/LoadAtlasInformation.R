#' Load atlas file
#'
#' Load ROI information associated with an atlas. Currently supports only the
#' Schaefer 400 parcel 17 Yeo-network parcellation.
#'
#' @param atlas Name of atlas (currently only supports schaefer17_400)
#' @return A data frame
#' @export

LoadAtlasInformation <- function(atlas) {
    if (!atlas %in% c('schaefer17_400'))
        stop(paste('Unrecognized atlas:', atlas))

    path <- system.file(paste0('data/atlases/', atlas, '.rds'), package = 'glass')
    readRDS(path)
}
