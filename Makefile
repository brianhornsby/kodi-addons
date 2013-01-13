prefix=.
bindir=$(prefix)/bin
SHELL=/bin/bash

addons=plugin.audio.tuneinradio \
	plugin.video.abciview \
	plugin.video.amazoninstantvideo \
	plugin.video.networkten \
	plugin.video.plus7 \
	script.openvpn \
	script.similartracks

exclude="*.pyo *.pyc *.DS_Store* *.git/* *.gitignore *.svn/* *.lwp"

version=$(shell grep -w id $@/addon.xml | cut -d\" -f6)

.PHONY: all clean help $(addons)

help:
	@echo "$(addons)"

$(addons): $(bindir)
	@echo "Building addon archive for $@"
	@zip -r $(bindir)/$@-$(version).zip $@ -x "$(exclude)"
	@echo "Archive $@-$(version).zip created"

$(bindir):
	@mkdir -p $@

clean:
	-rm $(bindir)/script.*-*.zip
	-rm $(bindir)/plugin.*-*.zip

all: $(addons)
