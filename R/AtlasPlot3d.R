#' 3D surface plot
#'
#' Wrapper around ggseg3d which handles some necessary data manipulation, and
#' includes more convenient handling of colormaps.
#'
#' @param data A dataframe containing variables to be plotted. Must contain a
#' "label" columns matching the corresponding column in a ggseg atlas file.
#' @param atlas A ggseg 3D atlas file. Currently only supports schaefer17_400_3d
#' from ggsegSchaefer.
#' @param surf Plotting surface. Defaults top "inflated".
#' @param hemi Cortical hemisphere.
#' @param fill String denoting the column name in data to be plotted.
#' @param palette Name of RColorBrewer palette. Prepend with "r_" to reverse
#' color scale. Default is set to r_RdBu.
#' @param limits Colorscale limits. If only one (positive) value c is supplied,
#' colorscale is assumed to be symmetric with limits (-c,c). If NULL, scale is set
#' to (-c,c) where c = max(abs(fill)).
#' @param camera Camera angle. Defaults to "right lateral".
#' @param ... Additional arguments to be passed to ggseg3d
#' @return A ggseg3d plot object
#' @export
#'
#' @import ggseg3d ggseg
#' @importFrom plotly layout
#' @importFrom RColorBrewer brewer.pal
#' @importFrom magrittr %>%
#' @importFrom plyr mapvalues

AtlasPlot3d <- function(data, atlas, surf = 'inflated', hemi = 'right', fill,
                        palette = 'r_RdBu', ncolor = 9, limits = NULL,
                        camera = 'right lateral', ...) {

    # Merge data with atlas
    at <- atlas$ggseg_3d[[which(atlas$surf == surf & atlas$hemi == hemi)]]
    data$region <- mapvalues(data$label, from = at$label,
                             to = at$region, warn_missing = F)
    data <- subset(data, region %in% at$region)

    # Set up color scale
    pal <- brewer.pal(ncolor, gsub("r_", "", palette, fixed = T))
    if (grepl("r_", palette, fixed = T))
        pal <- rev(pal)

    if (is.null(limits))
        limits <- c(-max(abs(data[,fill])), max(abs(data[,fill])))
    else if (length(limits) == 1)
        limits <- c(-abs(limits), abs(limits))

    pal <- setNames(seq(limits[1], limits[2], length.out = ncolor), pal)

    p <- ggseg3d(.data = data, atlas = atlas, surface = "inflated",
                 hemisphere = hemi, colour = fill, palette = pal, ...) %>%
        pan_camera(camera)

    axt <- list(title = '', showgrid = F,
                zerolinecolor = "rgb(255,255,255)",
                ticktext = '', tickvals = '')
    p <- plotly::layout(p, scene = list(xaxis = axt, yaxis = axt, zaxis = axt))

    return(p)
}
