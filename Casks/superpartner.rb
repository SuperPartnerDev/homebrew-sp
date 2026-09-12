# Cask de SuperPartner (el agente) para macOS. El .app viene firmado con
# Developer ID, notarizado y grapado, así que brew sólo lo copia.
#   brew tap superpartnerdev/sp && brew trust superpartnerdev/sp
#   brew install --cask superpartner
#   superpartner --instalar-servicio --hub https://mcp.superpartner.ca
cask "superpartner" do
  version "2.0.0"
  sha256 "4e6ebf3cde3095916aa236867a07eccca7d9fa46c7a25344138e5a8ef9538cf7"

  url "https://github.com/SuperPartnerDev/homebrew-sp/releases/download/v#{version}/SuperPartner-#{version}-darwin-arm64.zip"
  name "Super Partner"
  desc "El agente de SuperPartner: tus máquinas a distancia, igual que en local"
  homepage "https://mcp.superpartner.ca"

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Super Partner.app"
  binary "#{appdir}/Super Partner.app/Contents/MacOS/superpartner"

  uninstall launchctl: "ca.superpartner.agente"
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
