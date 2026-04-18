fcd() {
    local search_path="${FCD_PATH:-$HOME/Documents}" # Change to the directory you want to search
    local query="$1"
    local flag="$2"

    if [[ -z "$query" ]]; then
        echo "Usage: fcd <query> [-e]"
        return 1
    fi

    # First, try exact match (case-insensitive)
    local exact_matches=()
    while IFS= read -r path; do
        [[ -n "$path" ]] && exact_matches+=("$path")
    done < <(find "$search_path" -type d -iname "$query" 2>/dev/null)

    # Fall back to partial match if no exact match found
    local matches=()
    if [[ ${#exact_matches[@]} -gt 0 ]]; then
        matches=("${exact_matches[@]}")
    else
        while IFS= read -r path; do
            [[ -n "$path" ]] && matches+=("$path")
        done < <(find "$search_path" -type d -iname "*${query}*" 2>/dev/null)
    fi

    if [[ ${#matches[@]} -eq 0 ]]; then
        echo "fcd: no such directory: $query"
        return 1

    elif [[ ${#matches[@]} -eq 1 ]]; then
        if [[ "$flag" == "-e" ]]; then
            echo "${matches[0]}"
        else
            cd "${matches[0]}" || return 1
        fi

    else
        echo "Multiple matches found:"
        for i in "${!matches[@]}"; do
            echo "  $i: ${matches[$i]}"
        done
    fi
}
