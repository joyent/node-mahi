#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

#
# Copyright (c) 2014, Joyent, Inc.
#

#
# Makefile: basic Makefile for template API service
#
# This Makefile is a template for new repos. It contains only repo-specific
# logic and uses included makefiles to supply common targets (javascriptlint,
# jsstyle, restdown, etc.), which are used by other repos as well. You may well
# need to rewrite most of this file, but you shouldn't need to touch the
# included makefiles.
#
# If you find yourself adding support for new targets that could be useful for
# other projects too, you should add these to the original versions of the
# included Makefiles (in eng.git) so that other teams can use them too.
#

#
# Tools
#
TAP		:= ./node_modules/.bin/tap
NPM		:= npm
NPM_EXEC	:= npm

#
# Files
#
JS_FILES	:= $(shell ls *.js) $(shell find lib test -name '*.js')
JSON_FILES	 = package.json
JSL_CONF_NODE	 = tools/jsl.node.conf
JSL_FILES_NODE	 = $(JS_FILES)
JSSTYLE_FILES	 = $(JS_FILES)
JSSTYLE_FLAGS	 = -f tools/jsstyle.conf

include ./tools/mk/Makefile.defs
include ./tools/mk/Makefile.node_deps.defs

#
# Repo-specific targets
#
.PHONY: all
all: $(REPO_DEPS) $(TAP)
	$(NPM) install

$(TAP):
	$(NPM) install

CLEAN_FILES += ./node_modules npm-debug.log mahi-*.tgz

.PHONY: test
test: $(TAP)
	TAP=1 $(TAP) test/*.test.js

include ./tools/mk/Makefile.deps
include ./tools/mk/Makefile.node_deps.targ
include ./tools/mk/Makefile.targ
