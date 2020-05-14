.PHONY: all check_install_bundler install_carthage install_needle

all: check_install_bundler install_carthage install_needle

isBundlerInstalled := $(shell gem list -i bundler)

check_install_bundler:
	$(info Checking if bundler is installed)
    ifeq ($(isBundlerInstalled), false)
		sudo gem install bundler
    endif

install_carthage:
	brew ls --versions carthage || brew install carthage
    
install_needle: 
	brew ls --versions needle || brew install needle
