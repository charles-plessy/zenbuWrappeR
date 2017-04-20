zenbuWrappeR
============

R functions wrapping [Zenbu][] command-line tools.

[Zenbu]: http://fantom.gsc.riken.jp/zenbu


Installation on Linux computers
-------------------------------

### From GitHub in `R` (recommended)

```
devtools::install_github('charles-plessy/zenbuWrappeR', upgrade_dependencies = FALSE)
```

### From a Git clone.

```
git clone https://github.com/charles-plessy/zenbuWrappeR.git
R CMD INSTALL smallCAGEqc
```

In case of error `no permission to install to directory
‘/usr/local/lib/R/site-library’`, create a local R directory with the following
command.

```
/usr/bin/Rscript -e 'dir.create(Sys.getenv("R_LIBS_USER"), recursive=TRUE)'
```
