## Test environments

* local OS X install, R 4.0.0
* ubuntu 16.04 (on travis-ci), R 4.0.0
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 notes

## Reverse dependencies

There are no reverse dependencies.

---

This version upgrades the bundled json library, which fixes warnings
from the previous json library version.

This is a re-submission of this version, fixing a link. 
In addition, on Windows incoming check there was an error 
building the vignette because stringi was not available, 
which is required by stringr, which is required by rmarkdown.

Thanks!
Scott Chamberlain
