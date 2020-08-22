.PHONY: all
all: release

.PHONY: test
test: ## Run tests
	flutter analyze
	flutter test test

.PHONY: dirty-check
dirty-check:
	$(if $(shell git status --porcelain),$(error 'You have uncommitted changes. Aborting.'))

.PHONY: build
build:
	flutter build appbundle
	flutter build ios

.PHONY: archive
archive:
	cd ios && xcodebuild -configuration Release -workspace Runner.xcworkspace -scheme Runner archive -sdk iphoneos

.PHONY: release
release: ## Prepare Android bundle and iOS archive for release
release: dirty-check test build archive

.PHONY: help
help: ## Show this help text
	$(info usage: make [target])
	$(info )
	$(info Available targets:)
	@awk -F ':.*?## *' '/^[^\t].+?:.*?##/ \
         {printf "  %-24s %s\n", $$1, $$2}' $(MAKEFILE_LIST)
