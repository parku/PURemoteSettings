POD_NAME=PURemoteSettings

INFOPLIST_PATH="Example/$(POD_NAME)/$(POD_NAME)-Info.plist"

.DEFAULT: all
.PHONY: help open test version
	_help _open _test _version

#
# Public
#

all: \
	_help

help: \
	_help

open: \
	_open

test: \
	_test

version: \
	_version

#
# Private
#

_help:
	@echo "Please specify target."

_open:
	@open Example/PURemoteSettings.xcworkspace

_test:
	@echo "Testing $(version)"
	@xctool \
		-workspace Example/$(POD_NAME).xcworkspace \
		-scheme $(POD_NAME)-Example
	# @bundle exec scan \
	# 	--workspace "Example/$(POD_NAME).xcworkspace" \
	# 	--scheme "$(POD_NAME)-Example" \
	# 	--clean

_version:
	@echo "$(version)"


#
# Variables
#

version = $(version_id) ($(build_id))

build_id = \
	$(shell /usr/libexec/PlistBuddy \
		-c "Print :CFBundleVersion" \
		"${INFOPLIST_PATH}")

version_id = \
	$(shell /usr/libexec/PlistBuddy \
		-c "Print :CFBundleShortVersionString" \
		"${INFOPLIST_PATH}")
