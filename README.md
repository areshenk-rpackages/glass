# glass <img src='man/figures/logo.png' align="right" height="138.5" />

The **glass** package is a set of wrappers around functions in the **ggseg** and **ggseg3d** packages designed to make certain kinds of surface plots simpler by handling some of the necessary data manipulation automatically. The package is in early progress, and is at the moment geared towards the use of the Schaefer parcellation provided by **ggsegSchaefer**.

Functions in **glass** accept a dataframe as input, containing ROI labels and other optional variables for grouping or plotting. For convenience, the package includes dataframes with the necessary structure (currently only schaefer17_400), which can be fed to a plotting function after appending a variable to be plotted. 

For example, an interactive 3D surface plot can be generated as follows:

```r
data <- LoadAtlasInformation('schaefer17_400')
data$p <- rnorm(nrow(data))

AtlasPlot3d(data, atlas = schaefer17_400_3d, surf = 'inflated', hemi = 'right', 
            fill = 'p', palette = 'r_RdBu', ncolor = 9, limits = NULL, 
            camera = 'right lateral', show.legend = FALSE)
```

<p align="center">
<img src='man/figures/surfplot3d.png' height="300" />
</p>

Alternately, we can create a 2d surface plot of the same variable, facetted by network:

```r
subnet.data <- subset(data, Network %in% c('VisCent', 'SomMotA', 'DefaultC'))
AtlasPlot2d(subnet.data, atlas = schaefer17_400, fill = 'p', groupby = 'Network', 
             color = 'black', size = .2) +
    facet_wrap(~ Network, ncol = 1) +
    scale_fill_gradient2(low = 'blue', mid = 'yellow', high = 'red', 
                         midpoint = 0, na.value = grey(.95)) 
```

<p align="center">
<img src='man/figures/surfplot2d.png' height="500" />
</p>

Also included is a 2D cerebellar flatmap modelled after the SUIT atlas.

```r
plot(SUIT28cb) + 
    guides(fill=guide_legend(ncol=3)) + 
    theme(legend.position = 'bottom')
```

<p align="center">
<img src='man/figures/atlasCB.png' height="600" />
</p>
 
Implementing this in a way that works with ggseg required a slightly inelegant 
bit of hacking, which should eventually be improved. Nevertheless, it works well 
enough for most use cases:

```r
data <- LoadAtlasInformation('SUIT28cb')
data$p <- rnorm(nrow(data))

AtlasPlot2d(data, atlas = SUIT28cb, fill = 'p', color = 'black', size = .2) +
    scale_fill_gradient2(low = 'blue', mid = 'white', high = 'red', 
                         midpoint = 0, na.value = grey(.95)) 
```

<p align="center">
<img src='man/figures/surfplotCB.png' height="300" />
</p>
