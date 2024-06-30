#!/bin/bash

# Ustawienie zmiennych
TARGET_DIR="$HOME/mistrz_swiata"
HTML_FILE_PATH="/mnt/data/gra quizowa.html"
PORT=8000

# Funkcja do uruchomienia serwera
start_server() {
    # Tworzenie katalogu docelowego, jeśli jeszcze nie istnieje
    mkdir -p "$homekaliSerwer"

    # Kopiowanie pliku HTML do katalogu docelowego
    cp "$HTML_FILE_PATH" "$homekaliSerwer/index.html"

    # Przechodzenie do katalogu docelowego
    cd "$homekaliSerwer"

    # Uruchomienie prostego serwera HTTP w Pythonie na porcie 8000
    echo "Uruchamianie serwera HTTP na porcie $PORT..."
    python3 -m http.server $PORT
}

# Funkcja do wyświetlenia menu
show_menu() {
    echo "Witaj w interaktywnej powłoce serwera 'Mistrz Wiedzy'"
    echo "1. Uruchom serwer"
    echo "2. Zatrzymaj serwer"
    echo "3. Wyświetl status serwera"
    echo "4. Wyjście"
}

# Funkcja do sprawdzenia statusu serwera
check_status() {
    if pgrep -f "python3 -m http.server $PORT" > /dev/null; then
        echo "Serwer działa."
    else
        echo "Serwer jest wyłączony."
    fi
}

# Funkcja do zatrzymania serwera
stop_server() {
    if pgrep -f "python3 -m http.server $PORT" > /dev/null; then
        pkill -f "python3 -m http.server $PORT"
        echo "Serwer zatrzymany."
    else
        echo "Serwer już jest wyłączony."
    fi
}

# Główna pętla programu
while true; do
    show_menu
    read -p "Wybierz opcję: " choice
    case $choice in
        1)
            start_server &
            ;;
        2)
            stop_server
            ;;
        3)
            check_status
            ;;
        4)
            echo "Do widzenia!"
            exit 0
            ;;
        *)
            echo "Nieznana opcja. Spróbuj ponownie."
            ;;
    esac
done
