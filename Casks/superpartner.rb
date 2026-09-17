# Cask de SuperPartner (el agente) para macOS. El .app viene firmado con
# Developer ID, notarizado y grapado, así que brew sólo lo copia.
#   brew tap superpartnerdev/sp && brew trust superpartnerdev/sp
#   brew install --cask superpartner
#   superpartner --instalar-servicio --hub https://mcp.superpartner.ca
cask "superpartner" do
  version "2.0.4"
  sha256 "3b6ef1a78da24e3902ac7eff2a7c1be5fa54847955ccea5b33dc3d693d7e6286"

  url "https://github.com/SuperPartnerDev/homebrew-sp/releases/download/v#{version}/SuperPartner-#{version}-darwin-arm64.zip"
  name "Super Partner"
  desc "El agente de SuperPartner: tus máquinas a distancia, igual que en local"
  homepage "https://mcp.superpartner.ca"

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Super Partner.app"
  binary "#{appdir}/Super Partner.app/Contents/MacOS/superpartner"

  # Sin `uninstall launchctl:` a propósito: brew la ejecuta con sudo cuando no
  # encuentra el servicio en la sesión, y pide contraseña de administrador. El
  # servicio lo instala y lo quita el propio agente, sin brew y sin sudo:
  #   superpartner --quitar-servicio
  zap trash: [
    "~/Library/LaunchAgents/ca.superpartner.agente.plist",
    "~/Library/Logs/SuperPartner",
    "~/.superpartner",
  ]

  caveats <<~EOS
    Para que arranque con tu sesión y aparezca como «Super Partner» en Ítems de inicio:
      superpartner --instalar-servicio --hub https://mcp.superpartner.ca
    Quitar:  superpartner --quitar-servicio
  EOS
end
