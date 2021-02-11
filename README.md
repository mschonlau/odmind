[![codecov](https://codecov.io/gh/mschonlau/odmind/branch/master/graph/badge.svg?token=XEXF4GC575)](https://codecov.io/gh/mschonlau/odmind)
------------
# Calculate Origin-Destination Matrix Accessibility Indicators

------------
Installing
------------

The package is not yet deployed to CRAN, but you can install the
development version directly from GitHub.

    # install.packages("remotes")
    remotes::install_github("mschonlau/odmind")

Requirements
------------
By default the free public services at <api.openrouteservice.org> would be used.  A local or a hosted instance might be preferable in order to perform larger unlimited requests. The default plan for the public service is 500 requests per day @40 requests per minute. See [openrouteservice.org](https://openrouteservice.org/) for more detailed information.

Get started
------------
See the [vignette](https://mschonlau.github.io/odmind/)
