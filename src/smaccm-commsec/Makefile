
IVORY_REPO ?= ../../../ivory
TOWER_REPO ?= ../../../tower

default:
	cabal build

test: smaccm-commsec-ivory-test

.PHONY: smaccm-commsec-ivory-test
smaccm-commsec-ivory-test:
	cabal run smaccm-commsec-ivory-test-gen -- --src-dir=smaccm-commsec-ivory-test
	make -C smaccm-commsec-ivory-test

.PHONY: smaccm-commsec-ivory-test-clean
smaccm-commsec-ivory-test-clean:
	-rm -rf smaccm-commsec-ivory-test

create-sandbox:
	cabal sandbox init
	cabal sandbox add-source $(IVORY_REPO)/ivory
	cabal sandbox add-source $(IVORY_REPO)/ivory-artifact
	cabal sandbox add-source $(IVORY_REPO)/ivory-hw
	cabal sandbox add-source $(IVORY_REPO)/ivory-opts
	cabal sandbox add-source $(IVORY_REPO)/ivory-stdlib
	cabal sandbox add-source $(IVORY_REPO)/ivory-backend-c
	cabal sandbox add-source $(IVORY_REPO)/ivory-serialize
	cabal sandbox add-source $(TOWER_REPO)/tower-config
	cabal sandbox add-source $(TOWER_REPO)/tower
	cabal sandbox add-source ../smaccm-shared-comm
	cabal install --dependencies-only

clean: smaccm-commsec-ivory-test-clean
	-rm -rf dist

clean-sandbox: clean
	-rm -rf .cabal-sandbox
	-rm cabal.sandbox.config