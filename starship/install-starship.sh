#!/bin/bash

echo "🚀 Iniciando a instalação do Starship no Pop!_OS..."

# 🔥 Remove Oh My Posh, se estiver instalado
if [ -f "$HOME/.local/bin/oh-my-posh" ]; then
    echo "🗑️ Removendo Oh My Posh..."
    rm -f "$HOME/.local/bin/oh-my-posh"
    rm -rf "$HOME/.poshthemes"
    sed -i '/oh-my-posh/d' ~/.bashrc
fi

# 🧰 Instala dependências
echo "📦 Instalando dependências..."
sudo apt update
sudo apt install -y curl

# 🚀 Instala Starship
echo "⭐ Instalando Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

# 🔗 Adiciona ao .bashrc se não estiver
if ! grep -q "starship init bash" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# ➕ Configuração do Starship" >> ~/.bashrc
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
fi

# 🗂️ Cria a pasta de configuração se não existir
mkdir -p ~/.config

# 🎨 Cria o starship.toml com tema personalizado
cat << 'EOF' > ~/.config/starship.toml
# 🌟 Tema personalizado do Starship para Bash

add_newline = true

format = """
[╭─](bold green)$directory$git_branch$git_status$nodejs$python
[╰─➤](bold green) """

[directory]
style = "bold blue"
read_only = " 🔒"

[git_branch]
symbol = "🌱 "
style = "bold purple"

[git_status]
style = "red"

[nodejs]
symbol = "⬢ "
style = "bold green"

[python]
symbol = "🐍 "
style = "yellow"
format = '[$symbol $version]($style) '

[time]
disabled = false
format = '[ $time]($style) '
style = "bold cyan"
time_format = "%T"
EOF

# 🔄 Recarrega o bashrc
echo "♻️ Aplicando alterações..."
source ~/.bashrc

echo "✅ Starship instalado e configurado com sucesso!"
