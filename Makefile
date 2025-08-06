BUILD_DIR = build
PROJECT_NAME = $(CURDIR)
UF2_FILE = $(PROJECT_NAME).uf2

# ATTENZIONE: in bash su Windows la lettera di unità 'D:' diventa '/d/' oppure '/mnt/d/'
# Controlla come monti il disco Pico in bash e modifica DESTINATION di conseguenza.
DESTINATION ?=  'D:\'

.PHONY: setup
setup:

	@if exist "$(BUILD_DIR)" ( \
		echo "Build directory already exists. Skipping setup." \
	) else ( \
		echo "Creating build directory..." && \
		mkdir $(BUILD_DIR) \
	)
	cd $(BUILD_DIR) && cmake -G Ninja .. -DPICO_BOARD=pico_w
	cd $(BUILD_DIR) && ninja

.PHONY: compile
compile:
	cd $(BUILD_DIR) && ninja

.PHONY: upload_bootsel
upload_bootsel:
	
	@if exist "$(BUILD_DIR)/$(UF2_FILE)" ( \
		echo "Uploading .uf2 file to Raspberry Pi Pico..." && \
		powershell -Command "Copy-Item '$(BUILD_DIR)/$(UF2_FILE)' -Destination  $(DESTINATION)  -Force" || ( \
		    echo "Error while uploading, please make sure the pico is in BOOTSEL mode and is recognized as $(DESTINATION) storage drive. If it is recognized as another drive, please change the 'Destination' field of the upload_bootsel command"; \
		) \
	) else ( \
		echo ".uf2 file not found. Run 'make compile' before uploading the code." \
	)

.PHONY: clean_all
clean_all:
	@echo BUILD_DIR is: "$(BUILD_DIR)"
	@if exist "$(BUILD_DIR)\output" ( \
		echo The build folder exists. & \
		rd /s /q "$(BUILD_DIR)" & \
		echo Build folder content removed. \
	) else ( \
		echo The output folder does not exist. \
	)