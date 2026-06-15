# Install dev tools via Homebrew
[group('Dev Tools')]
install-dev-tools:
    brew install --cask claude-code
    brew install starship git-graph

# Install utilities via Homebrew
[group('Utilities')]
install-utilities:
    brew install chezmoi yt-dlp htop cmatrix
    flatpak install -y flathub it.mijorus.gearlever com.bitwarden.desktop
