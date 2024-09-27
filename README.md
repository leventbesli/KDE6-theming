# Lightly-Klassy-Kvantum Setup Script
This bash script automates the installation of the Lightly, Klassy, and Kvantum theme systems on Freshly installed Fedora KDE 6 systems. It also sets up Konsave, a tool for managing desktop configurations, and imports a pre-configured theme profile. This way, you can start with the same theme and settings for each new OS installation.

""This repo doesn't includes otto-lightly-klassy_konsave.knsv file because it's above upload limits of Github. You can modify the script according to your .knsv backup files.""

# Features
- Installs the Lightly theme system:

Downloads and compiles the Lightly theme from the official repository.
Handles the case where an existing Lightly folder already exists, asking for user input to either delete it or cancel the installation.
Installs the Klassy and Kvantum theme systems:

- Adds the official repository for Klassy and Kvantum for Fedora and installs them.

- Sets up Konsave:

- Installs Konsave, a tool used to back up and restore desktop configurations.
- Ensures that Konsave is added to the user's local environment for easy use.
- Imports a pre-configured Konsave theme profile:

- Applies the otto-lightly-klassy_konsave.knsv theme configuration using Konsave.
