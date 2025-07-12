# PyPSA-Eur Tutorial

## Lehrstuhl EVT, Montanuniversität Leoben

Dies ist eine strukturierte Anleitung zur schnellen und stabilen Installation von PyPSA-Eur auf einem Windows-Rechner unter Verwendung von WSL2 (Windows Subsystem for Linux). Sie richtet sich an Mitarbeitende und Studierende am Lehrstuhl für Energieverbundtechnik (EVT).

**Fragen und Verbesserungsvorschläge an:**
Björn Ellensohn
[bjoern.ellensohn@stud.unileoben.ac.at](mailto:bjoern.ellensohn@stud.unileoben.ac.at)

---

## Inhaltsverzeichnis

* [1. Voraussetzungen](#1-voraussetzungen)
* [2. Vorbereitung](#2-vorbereitung)
* [3. Installation von PyPSA-Eur](#3-installation-von-pypsa-eur)
* [4. Europa-Simulation ausführen](#4-europa-simulation-ausführen)
* [5. Analyse und Auswertung](#5-analyse-und-auswertung)

  * [5.1. Jupyter Notebooks](#51-jupyter-notebooks)
  * [5.2. Beispiele](#52-beispiele)

---

## 1. Voraussetzungen

* Windows 10 oder 11
* Mindestens 32 GB RAM (für stabilen Betrieb mit 128 Knoten)
* 60 GB freier Festplattenspeicher
* Aktivierte Virtualisierung im BIOS (Intel VT-d / AMD-Vi / IOMMU)
* Admin-Rechte (nur zur WSL2-Installation)

---

## 2. Vorbereitung

**Stand: 19.01.2025** — PyPSA-Eur läuft unter Windows über **WSL2** (Ubuntu Linux).

### Schritte:

1. PowerShell als Administrator starten und ausführen:

   ```powershell
   wsl --install
   ```
2. Neustart durchführen.
3. Ubuntu aus dem Startmenü starten und Benutzerkonto anlegen.
4. \[Optional] Ubuntu aus dem Microsoft Store installieren, falls nicht vorhanden.
5. \[Optional] Visual Studio Code (VS Code) installieren.
6. VS Code: WSL-Erweiterung installieren (blaues Remote-Menü erscheint).
7. Verbindung mit WSL herstellen ("Connect to WSL").
8. Ubuntu-Dateisystem und Umgebung sind jetzt in VS Code verfügbar.
9. In Ubuntu-Terminal:

   ```bash
   mkdir ~/work && cd ~/work
   wget https://github.com/conda-forge/miniforge/releases/download/24.11.2-1/Miniforge3-24.11.2-1-Linux-x86_64.sh
   chmod +x Miniforge3-24.11.2-1-Linux-x86_64.sh
   ./Miniforge3-24.11.2-1-Linux-x86_64.sh
   ```
10. Terminal neu öffnen, wieder ins Arbeitsverzeichnis wechseln:

    ```bash
    cd ~/work
    ```
11. Git LFS installieren (für den Zugriff auf große Datensätze):

    ```bash
    sudo apt update && sudo apt install -y git-lfs unzip
    ```
12. Repository klonen:

    ```bash
    git clone https://git.unileoben.ac.at/evt1/pypsa-eur-evt -b lfs-dataset
    ```

    Alternativ, wenn weniger Daten benötigt werden:

    ```bash
    git clone https://git.unileoben.ac.at/evt1/pypsa-eur-evt.git --single-branch -b v2025.01.0
    ```
13. Projektordner in VS Code öffnen: `work/pypsa-eur-evt`

---

## 3. Installation von PyPSA-Eur

1. Terminal in VS Code öffnen (aktiviertes Conda sollte sichtbar sein: `(base)`)
2. Abhängigkeiten installieren:

   ```bash
   mamba env create -f envs/environment.yaml -y
   ```
3. Environment aktivieren:

   ```bash
   conda activate pypsa-eur
   ```
4. Testlauf zur Verifikation:

   ```bash
   snakemake solve_elec_networks --configfile config/test/config.electricity.yaml
   ```
5. Vor erneuter Simulation empfiehlt sich:

   ```bash
   snakemake purge
   ```

---

## 4. Europa-Simulation ausführen

### 4.1. Gurobi Lizenz

Die kostenfreie Gurobi-Testlizenz muss in WSL ins Home-Verzeichnis gelegt werden:

* `~/gurobi.lic`
* Zugriff über Explorer: `\\wsl$\Ubuntu\home\<dein-username>`

### 4.2. Simulation starten

```bash
snakemake solve_elec_networks --configfile config/my_configs/config.128_wAT_entsoe.yaml
```

> Simulationsdauer: ca. 3 Stunden (je nach System)

Details siehe [Projektarbeit PDF](projektarbeit-evt/projekt_energietechnik_pypsa.pdf)

---

## 5. Analyse und Auswertung

Die Resultate liegen unter: `results/<experimentname>/`

### 5.1. Jupyter Notebooks

* Interaktive Analyseumgebung mit Markdown und Python Code
* In VS Code durch **Jupyter-Erweiterung** unterstützt

### 5.2. Beispiele

* Beispiel-Notebooks liegen im Verzeichnis: `notebooks-evt/`
* Nutzen:

  * Netzvisualisierung
  * Lastflussanalyse
  * Erzeugung vs. Verbrauch

---

## Anhang: Hilfreiche Screenshots

* WSL Erweiterung:
<p align="center">
    <img src="wsl.png" alt="WSL Erweiterung" width="800"/>
</p>

* Remote-Menü:
<p align="center">
    <img src="remote.png" alt="Remote Button" width="400"/>
</p>

* Terminal öffnen:
<p align="center">
    <img src="terminal.png" alt="Terminal" width="1024"/>
</p>

* VS Code Start:
<p align="center">
    <img src="vscode.png" alt="VS Code Start" width="1024"/>
</p>

* Jupyter:
<p align="center">
    <img src="jupyter.png" alt="Jupyter Erweiterung" width="800"/>
</p>

---

## Letzte Hinweise

* Arbeiten immer innerhalb des Ubuntu-Terminals
* Speicherpfade beachten: Windows-Dateien sind in `/mnt/c/...` erreichbar
* Gitlab-Anmeldung mit MUonline-Zugangsdaten

---

**Viel Erfolg mit PyPSA-Eur am EVT!**
