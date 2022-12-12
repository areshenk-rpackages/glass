#' 2D atlas plot
#'
#' Wrapper around ggseg which handles some necessary data manipulation.
#'
#' @param data A dataframe containing variables to be plotted. Must contain a
#' "label" columns matching the corresponding column in a ggseg atlas file.
#' @param atlas A ggseg atlas file.
#' @param fill String denoting the column name in data to be plotted.
#' @param groupby If facetting, variable to facet by.
#' @param ... Additional arguments to be passed to ggseg
#' @return A ggseg plot object
#' @export
#'
#' @import ggseg ggplot2
#' @importFrom dplyr group_by_at ungroup
#' @importFrom plyr here

AtlasPlot2d <- function(data, atlas, fill, groupby = NULL, ...) {

    if (!is.null(groupby)) {
        data <-  group_by_at(ungroup(data), groupby)
    }

    p <- ggseg(data, atlas, mapping = aes_string(fill = fill), ...)
    return(p)
}
