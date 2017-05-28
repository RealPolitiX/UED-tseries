# UED-tseries
Matlab routines for crystallographic computation and analysis of time-resolved 2D diffraction time series (2014-2016). Their details are described in the following,


### 1. Constructor of transform matrix between fractional (fr.) and Cartesian (car.) coordinates

(1) TMfr2car -- transform matrix from fr. to car. coordinates

(2) TMcar2fr -- transform matrix from car. to fr. coordinates


### 2. Extraction of spatially-aggregated time-series data (2D -> 1D)
Note: The signals are averaged/accumulated over the specified ROIs

(1) ROITraceAnalyze -- Extraction of time-dependent changes in ROIs from 2D stack, incl. probe normalization

(2) ROIDecayAnalyze -- Extraction of signal decay in ROIs from 2D stack, incl. probe normalization


### 3. Visualization of 2D static and time-series data

(1) ROIAnnotate -- 2D diffraction image with rectangular annotation of selected ROIs (regions of interest)

(2) SeriesPlot -- 2D grid plot of diffraction images (only need to select the row and column numbers)

(3) ROITracePlot -- Plot of spatially-aggregated time-series incl. normalization

(4) ROIDecayPlot -- Plot of signal decay curves for integrated ROIs
