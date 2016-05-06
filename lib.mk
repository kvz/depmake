SHELL := /bin/bash

define dm_packets
PACKETS := $(basename $(notdir $(wildcard $(DM_PACKETS_DIR)/*.sh)))
ALL:
	@$(MAKE) $$(PACKETS)
	cat $(wildcard $(DM_BUILD_DIR)/*/build.fingerprint) |openssl sha1 | cut -d ' ' -f 2 > $(DM_STACK_DIR)/build.combined.fingerprint

$$(PACKETS):
	@source $(DM_DIR)/lib.sh && dm_build $$@ $$^

.PHONY: ALL $$(PACKETS)
endef
