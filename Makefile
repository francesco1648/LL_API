BUILD_DIR = build
PROJECT_NAME = mio_progetto
UF2_FILE = $(PROJECT_NAME).uf2

# ATTENZIONE: in bash su Windows la lettera di unità 'D:' diventa '/d/' oppure '/mnt/d/'
# Controlla come monti il disco Pico in bash e modifica DESTINATION di conseguenza.
DESTINATION ?= /d

.PHONY: setup
setup:
	if [ ! -d "$(BUILD_DIR)" ]; then mkdir $(BUILD_DIR); fi
	cd $(BUILD_DIR) && cmake -G Ninja .. -DPICO_BOARD=pico_w
	cd $(BUILD_DIR) && ninja

.PHONY: compile
compile:
	cd $(BUILD_DIR) && ninja

.PHONY: upload_bootsel
upload_bootsel:
	if [ -f "$(BUILD_DIR)/$(UF2_FILE)" ]; then \
		echo "Uploading $(UF2_FILE) to Raspberry Pi Pico..."; \
		cp -f "$(BUILD_DIR)/$(UF2_FILE)" "$(DESTINATION)/"; \
	else \
		echo "Error: file '$(BUILD_DIR)/$(UF2_FILE)' not found. Run 'make compile' first."; \
	fi

.PHONY: clean
clean:
	if [ -d "$(BUILD_DIR)" ]; then rm -rf $(BUILD_DIR); fi
