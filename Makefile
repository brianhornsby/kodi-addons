prefix=.
bindir=$(prefix)/bin
SHELL=/bin/bash

addons=plugin.audio.tuneinradio \
	plugin.video.abciview\
	script.openvpn \
	script.similartracks

exclude="*.pyo *.pyc *.DS_Store* *.git/* *.gitignore"

version=1.0.0

.PHONY: all clean help $(addons)

help:
	@echo "$(addons)"

$(addons): $(bindir)
	@echo "Creating addon archive for $@"
	@zip -qr $(bindir)/$@-$(version).zip $@ -x "$(exclude)"

$(bindir):
	@mkdir -p $@

clean:
	-rm $(bindir)/script.openvpn-*.zip	
	-rm $(bindir)/plugin.audio.tuneinradio-*.zip	

all: $(addons)