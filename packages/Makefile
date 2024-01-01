.PHONY: all
all: build install refresh publish clean

.PHONY: build
build: ## Build the meta-package
	mockbuild

.PHONY: install
install: ## Install the meta-package
	sudo dnf install *.noarch.rpm

.PHONY: refresh
refresh: ## Refresh the backup lists
	backup-packages
	xargs -r -a unknown.list sudo dnf -q mark remove
	backup-packages

.PHONY: publish
publish: ## Publish the meta-package to the repo
	copr build --nowait personal maximbaz.spec

.PHONY: clean
clean: ## Cleanup
	rm -rf *.rpm *.log

.PHONY: help
help: ## This help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
