# Guida all'uso del Raspberry Pi Pico SDK su Windows con Visual Studio Code

Questo tutorial spiega come configurare e utilizzare il **Pico SDK** su Windows per sviluppare in C/C++ con **Visual Studio Code**, usando **CMake**, **Ninja** e un **Makefile semplificato**.

---

## ✅ Installazione del Pico SDK su Windows

Per usare le API del Raspberry Pi Pico (come `gpio_put`, `sleep_ms`, `stdio_init_all`, ecc.), è necessario installare il **Pico SDK** e l’ambiente di sviluppo.

1. Vai alla pagina ufficiale dei **release del setup per Windows**:  
   👉 [https://github.com/raspberrypi/pico-setup-windows/releases](https://github.com/raspberrypi/pico-setup-windows/releases)

2. Scarica l'ultima versione del file `.exe`.

3. Esegui l’installer. Al termine, si aprirà un file `.txt` con le istruzioni finali: **segui quanto indicato** per completare correttamente la configurazione.

> Il setup installerà tutto il necessario: toolchain GCC, CMake, Ninja, SDK, esempi, e variabili di ambiente.

---

## ⚙️ Compilazione del progetto

> **Non è necessario usare il supporto CMake integrato in VS Code.**  
> Ti consigliamo di usare un **Makefile semplificato**, con comandi da terminale.
### 1. **Prima compilazione (setup)**

Al primo avvio, esegui:

```bash
make setup
```

Questo comando:
- Crea la cartella `build/`
- Configura il progetto con CMake
- Compila e genera i file binari (`.uf2`, `.bin`, `.elf`, ecc.)

---

### 2. **Compilazioni successive**

Se modifichi **solo** i file `.c` o `.h` (es: `main.c`), puoi semplicemente eseguire:

```bash
make compile
```

Non serve rilanciare `make setup`.

---

### 3. **Modifiche a CMakeLists.txt**

Se modifichi `CMakeLists.txt` (es: cambi scheda Pico, aggiungi un file sorgente, ecc.), **è necessario pulire e riconfigurare**:

```bash
rmdir /s /q build   # oppure cancella manualmente la cartella build/
make setup
```

---

## 🚀 Caricamento del file .uf2 sul Pico

Dopo la build, il file `.uf2` generato si trova nella cartella `build/` e ha lo stesso nome della cartella del progetto.

Per caricare il firmware sul Pico:

1. Tieni premuto il tasto **BOOTSEL** sul Pico.
2. Collega il Pico via USB.
3. Rilascia BOOTSEL: il Pico verrà rilevato come disco USB.
4. Esegui:

```bash
make upload_bootsel
```

> Questo comando copierà automaticamente il file `.uf2` sul Pico.

---

## 📁 Struttura tipica del progetto
Per poter creare un nuovo progetto bisogna copiare i file CMakeLists.txt, Makefile,pico_sdk_import.cmake nella cartella del progetto
```
mio_progetto/
├── CMakeLists.txt
├── main.c
├── pico_sdk_import.cmake
├── Makefile
└── build/          <-- generata da make setup
```

---

## 📌 Note finali

- Assicurati che `pico_sdk_import.cmake` sia copiato da `pico-sdk/external/` nella root del progetto.
- È richiesto che `PICO_SDK_PATH` sia impostato correttamente (di solito lo fa il setup `.exe`).

---

## 🧰 Requisiti

- [x] Pico SDK
- [x] GCC ARM (arm-none-eabi-gcc)
- [x] CMake
- [x] Ninja
- [x] Visual Studio Code (opzionale, ma consigliato)

---



---
### ✉️ Contatti

Per dubbi o suggerimenti, apri una issue o contattami direttamente.
