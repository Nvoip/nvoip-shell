# Publicacao do pacote Shell/Linux

O reposititorio `nvoip-shell` e distribuivel hoje por GitHub Releases. Para publicar em um gerenciador real de pacotes, o caminho recomendado e criar um tap Homebrew oficial:

- Repositorio: `Nvoip/homebrew-tap`
- Formula: `Formula/nvoip-shell.rb`
- Comando esperado para clientes: `brew install Nvoip/tap/nvoip-shell`

Esse modelo evita acoplar o pacote Shell aos SDKs de linguagem e permite versionar formulas para Linux/macOS sem duplicar os exemplos.
