#!/bin/bash

# Endpunkte, die blockiert werden sollen
blockList=(
  "copilot-proxy.githubusercontent.com"
  # Weitere Endpunkte können hier ergänzt werden, sobald sie bekannt sind
)

# Pfad zur Hosts-Datei
hostsPath="/etc/hosts"

# Backup der Hosts-Datei erstellen
sudo cp $hostsPath "${hostsPath}.bak"

# Inhalte der Hosts-Datei lesen
hostsFile=$(cat $hostsPath)

for endpoint in "${blockList[@]}"; do
  entry="127.0.0.1 $endpoint"

  # Prüfen, ob die Domain bereits blockiert ist
  if ! grep -q "$entry" $hostsPath; then
    # Endpunkt blockieren
    echo "$entry" | sudo tee -a $hostsPath > /dev/null
  fi
done

echo "Die angegebenen Endpunkte wurden erfolgreich blockiert."
