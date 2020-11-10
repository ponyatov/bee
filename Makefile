# \ <section:vars>
MODULE       = $(notdir $(CURDIR))
OS          ?= $(shell uname)
# / <section:vars>
# \ <section:dirs>
CWD          = $(CURDIR)
BIN          = $(CWD)/bin
LIB          = $(CWD)/lib
SRC          = $(CWD)/src
TMP          = $(CWD)/tmp
# / <section:dirs>
# \ <section:tools>
WGET         = wget -c
# / <section:tools>
# \ <section:install>
.PHONY: install
install:
	$(MAKE) $(OS)_install
.PHONY: update
update:
	$(MAKE) $(OS)_update
# \ <section:install/os>
.PHONY: Linux_install Linux_update
Linux_install Linux_update:
	sudo apt update
	sudo apt install -u `cat apt.txt`
# / <section:install/os>
# / <section:install>
# \ <section:merge>
MERGE  = README.md Makefile .gitignore apt.txt .vscode
# / <section:merge>

master:
	git checkout $@
	git pull -v
	git checkout shadow -- $(MERGE)

shadow:
	git checkout $@
	git pull -v

release:
	git tag $(NOW)-$(REL)
	git push -v && git push -v --tags
	$(MAKE) shadow

zip:
	git archive --format zip 	--output ~/tmp/$(MODULE)_src_$(NOW)_$(REL).zip 	HEAD

