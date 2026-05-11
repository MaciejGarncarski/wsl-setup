# Ubuntu Terminal Reproduction

## 1. Install base packages

```bash
sudo apt update
sudo apt install -y zsh git curl wget unzip unrar build-essential pkg-config gcc make python3 python3-pip python3-venv ripgrep fd-find fzf zoxide tree btop fastfetch lshw mtr-tiny gnupg bat eza zsh-syntax-highlighting zsh-autosuggestions fd-find fzf zoxide btop fastfetch
```

## 2. Make zsh the default shell

```bash
sudo chsh -s "$(command -v zsh)" "$USER"
```

Log out and back in after this.

## 3. Install mise

```bash
curl https://mise.run | sh
```
## 4. Install Powerlevel10k

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
```

If you want the same prompt feel as the repo, copy your existing `p10k.zsh` into `~/.p10k.zsh` and source it from `~/.zshrc`.

## 5. Copy zshrc file to ~/.zshrc

## 6. Install the remaining CLI tools

```bash
sudo apt install -y lazygit
```

For tools that are not in the Ubuntu archive, install them with the package manager you already use:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
curl -fsSL https://deno.land/install.sh | sh
curl -fsSL https://bun.sh/install | bash
```

## 7. Optional developer tools

These match the repo's extra CLI workflow well if you need them:

```bash
sudo apt install -y docker.io docker-compose-plugin
python3 -m pip install --user git+https://github.com/nektos/act.git
```

## 8. Quick verification

```bash
zsh --version
git --version
rg --version
fdfind --version
fzf --version
zoxide --version
btop
fastfetch
```

## 9. Configure git

```bash
git config --global user.email "twój_email@example.com"
git config --global user.name "NAME NAME"
ssh-keygen -t ed25519 -C "twój_email@example.com"
```
