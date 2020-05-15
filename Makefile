PACKAGE := $(shell grep '^Package:' DESCRIPTION | sed -E 's/^Package:[[:space:]]+//')
RSCRIPT = Rscript --no-init-file

all:
	${RSCRIPT} -e 'library(methods); devtools::compile_dll()'

test:
	${RSCRIPT} -e 'library(methods); devtools::test()'

test_all:
	REMAKE_TEST_INSTALL_PACKAGES=true make test

doc:
	@mkdir -p man
	${RSCRIPT} -e "library(methods); devtools::document()"

eg:
	${RSCRIPT} -e "devtools::run_examples()"

install: doc build
	R CMD INSTALL . && rm *.tar.gz

build:
	R CMD build . --no-build-vignettes

check: build
	_R_CHECK_CRAN_INCOMING_=FALSE R CMD check --as-cran --no-manual --no-build-vignettes `ls -1tr ${PACKAGE}*gz | tail -n1`
	@rm -f `ls -1tr ${PACKAGE}*gz | tail -n1`
	@rm -rf ${PACKAGE}.Rcheck

check_windows:
	${RSCRIPT} -e "devtools::check_win_devel(); devtools::check_win_release()"

clean:
	rm -f src/*.o src/*.so

attributes:
	${RSCRIPT} -e 'library(methods); Rcpp::compileAttributes()'

readme:
	${RSCRIPT} -e "knitr::knit('README.Rmd')"

# No real targets!
.PHONY: all test document install
