#!/bin/bash

###
### sshm.sh Main Script
### by Remi
### 
### This is a stupid script to simplify the life dealing with common SSH commands.

show_file() {
    local file="$1"
    if [[ -f "$file" ]]; then
        cat "$file"
    else
        echo "Error: File '$file' not found."
    fi
}

edit_file() {
    local file="$1"
    local editor=${EDITOR:-nano} # Can be overridden with EDITOR env
    if [[ -f "$file" || "$file" == "$HOME/.ssh/config" ]]; then
        $editor "$file"
    else
        echo "Error: File '$file' not found."
    fi
}

reset_known_hosts() {
    local file="$HOME/.ssh/known_hosts"
    if [[ -f "$file" ]]; then
        rm "$file"
        echo "Deleted known hosts."
    else
        echo "No known_hosts file to delete."
    fi
}

# Main function
main() {
    local action="$1"
    local filename="${2:-}" # Optional filename argument, defaults to empty
    
    local ssh_dir="$HOME/.ssh" # Change if you use another SSH directory(but jesus, why to?)
    
    case "$action" in
        "show")
            if [ -z "$filename" ]; then
                filename="$ssh_dir/id_ed25519.pub"
            else
                filename="$ssh_dir/$filename"
            fi
            show_file "$filename"
            ;;
        "edit")
            if [ -z "$filename" ]; then
                filename="$ssh_dir/config"
            else
                filename="$ssh_dir/$filename"
            fi
            edit_file "$filename"
            ;;
        "kh")
            if [ "$filename" == "reset" ]; then
                reset_known_hosts
            else
                filename="$ssh_dir/known_hosts"
                edit_file "$filename"
            fi
            ;;
        *)
            echo "Usage: $0 {show|edit|kh} [filename]"
            exit 1
            ;;
    esac
}

# Check if .ssh directory exists
if [[ ! -d "$HOME/.ssh" ]]; then
    echo "Error: SSH directory '$HOME/.ssh' not found."
    exit 1
fi

# Call main function with arguments passed to the script
main "$@"
