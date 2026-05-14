# AC2 Polish Proton Fix

Nieoficjalny wrapper/skrypt dla Linuxa i Protona, który aktywuje polską wersję językową w **Assassin’s Creed II** na Steamie.

Skrypt ustawia odpowiednie wpisy rejestru w prefixie Proton/Wine **przed uruchomieniem gry**, dzięki czemu gra startuje z polską lokalizacją.

To nie jest klasyczne spolszczenie ani paczka plików. Skrypt nie dodaje tłumaczenia do gry — aktywuje istniejącą polską lokalizację przez wpisy rejestru.

## Co to robi?

Skrypt ustawia dwa wpisy rejestru:

```text
HKLM\Software\Wow6432Node\UBISOFT\Assassin's Creed II
language = Polish
```

oraz:

```text
HKLM\Software\Wow6432Node\UBISOFT\Assassin's Creed II\GameUpdate
language = pl
```

Działa to podobnie do znanych poradników dla Windowsa, ale zostało dostosowane pod Linuxa/Protona. Zamiast ręcznie zmieniać rejestr i blokować uprawnienia, skrypt automatycznie ustawia wymagane wpisy przed uruchomieniem gry.

## Wymagania

- Linux lub Steam Deck
- Steamowa wersja **Assassin’s Creed II**
- Proton
- `protontricks`

AppID gry na Steamie:

```text
33230
```

## Instalacja protontricks

Fedora / Nobara:

```bash
sudo dnf install protontricks
```

Ubuntu / Debian / Linux Mint / Pop!_OS:

```bash
sudo apt update
sudo apt install protontricks
```

Arch Linux / EndeavourOS / Manjaro:

```bash
sudo pacman -S protontricks
```

Jeśli `protontricks` nie jest dostępny w repozytorium twojej dystrybucji, możesz użyć wersji Flatpak:

```bash
flatpak install flathub com.github.Matoking.protontricks
```

Uwaga: ten skrypt był testowany z klasyczną wersją `protontricks` dostępną jako komenda w terminalu. Wersja Flatpak może wymagać dostosowania komend.

## Instalacja skryptu

Pobierz plik `ac2-polish.sh` i zapisz go np. w katalogu domowym:

```text
/home/twoja_nazwa_uzytkownika/ac2-polish.sh
```

Nadaj mu uprawnienia wykonywania:

```bash
chmod +x ~/ac2-polish.sh
```

## Konfiguracja w Steamie

W Steamie wejdź w:

```text
Assassin’s Creed II → Właściwości → Opcje uruchamiania
```

Wpisz:

```bash
/home/TWOJA_NAZWA_UZYTKOWNIKA/ac2-polish.sh %command%
```

Przykład:

```bash
/home/xargius/ac2-polish.sh %command%
```

Uwaga: nie wpisuj `/home/$USER/...`, tylko pełną ścieżkę z prawdziwą nazwą użytkownika.

## Zawartość Skryptu

```bash
#!/usr/bin/env bash

LOG="$HOME/ac2-wrapper.log"

echo "AC2 wrapper started at $(date)" >> "$LOG"

env -u LD_PRELOAD timeout 45s protontricks -c "wine reg add \"HKLM\\Software\\Wow6432Node\\UBISOFT\\Assassin's Creed II\" /v language /t REG_SZ /d Polish /f" 33230 >> "$LOG" 2>&1

env -u LD_PRELOAD timeout 45s protontricks -c "wine reg add \"HKLM\\Software\\Wow6432Node\\UBISOFT\\Assassin's Creed II\\GameUpdate\" /v language /t REG_SZ /d pl /f" 33230 >> "$LOG" 2>&1

echo "Launching command: $*" >> "$LOG"

exec "$@"
```

## Log

Skrypt zapisuje prosty log tutaj:

```text
~/ac2-wrapper.log
```

Możesz go sprawdzić komendą:

```bash
cat ~/ac2-wrapper.log
```

Jeśli wszystko działa, powinny pojawić się informacje o starcie wrappera i uruchomieniu gry.

## Ważne informacje

Ten skrypt był testowany na steamowej wersji **Assassin’s Creed II** z AppID `33230`.

Wersje Ubisoft Connect, Lutris, Heroic, Bottles lub czysty Wine mogą wymagać ręcznego dostosowania prefixu Wine/Protona. Ten skrypt może służyć jako baza, ale nie musi działać 1:1 poza Steamem.

Skrypt nie dodaje żadnych plików językowych. Nie zawiera tłumaczenia, plików gry ani assetów Ubisoftu.

## Odinstalowanie

Usuń wpis z opcji uruchamiania Steam:

```bash
/home/TWOJA_NAZWA_UZYTKOWNIKA/ac2-polish.sh %command%
```

Możesz też usunąć pliki:

```bash
rm ~/ac2-polish.sh ~/ac2-wrapper.log
```

## Disclaimer

This project does not include or distribute any Ubisoft files, game assets, translations, executables, cracks, or copyrighted game content.

It only provides a shell script that changes registry values inside the Proton/Wine prefix before launching the game.

Assassin’s Creed II and Ubisoft are trademarks/properties of Ubisoft. This project is unofficial and is not affiliated with, endorsed by, sponsored by, or approved by Ubisoft.

## License

This project is licensed under the MIT License.
