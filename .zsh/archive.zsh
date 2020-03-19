archive() {
    if (( $# < 2 )); then
        >&2 echo "usage: $0 [archive_name.extension] [/path/to/include/into/archive ...]"
        return 1
    fi

    local archive_name="${1:t}"
    local path_to_archive="${@:2}"

    case "${archive_name}" in
        (*.tar.gz|*.tgz)         tar -cvf "${archive_name}" --use-compress-program=pigz "${=path_to_archive}" ;;
        (*.tar.bz2|*.tbz|*.tbz2) tar -cvf "${archive_name}" --use-compress-program=lbzip2 "${=path_to_archive}" ;;
        (*.tar.xz|*.txz)         tar -cvf "${archive_name}" --use-compress-program=pixz "${=path_to_archive}" ;;
        (*.tar.lzma|*.tlz)       tar -cvf "${archive_name}" --lzma "${=path_to_archive}" ;;
        (*.tar)                  tar -cvf "${archive_name}" "${=path_to_archive}" ;;
        (*.zip|*.jar)            zip -r "${archive_name}" "${=path_to_archive}" ;;
        (*.rar)                  rar a "${archive_name}" "${=path_to_archive}" ;;
        (*.7z)                   7za a "${archive_name}" "${=path_to_archive}" ;;
        (*.gz)                   print "\n.gz is only useful for single files, and does not capture permissions. Use .tar.gz" ;;
        (*.bz2)                  print "\n.bzip2 is only useful for single files, and does not capture permissions. Use .tar.bz2" ;;
        (*.xz)                   print "\n.xz is only useful for single files, and does not capture permissions. Use .tar.xz" ;;
        (*.lzma)                 print "\n.lzma is only useful for single files, and does not capture permissions. Use .tar.lzma" ;;
        (*)                      print "\nunknown archive type for archive: ${archive_name}" ;;
    esac
}

unarchive() {
    local success
    local file_name
    local file_path
    local extract_dir

    if (( $# == 0 )); then
        >&2 echo "usage: $0 [-option] [file ...]"
        exit 1
    fi

    while (( $# > 0 )); do
        if [[ ! -s "$1" ]]; then
            print "$0: file not valid: $1" >&2
            shift
            continue
        fi

        success=0
        file_name="${1:t}"
        file_path="${1:A}"
        extract_dir="${file_name:r}"
        case "$1:l" in
            (*.tar.gz|*.tgz)         tar -xvf "$1" --use-compress-program=pigz ;;
            (*.tar.bz2|*.tbz|*.tbz2) tar -xvf "$1" --use-compress-program=lbzip2 ;;
            (*.tar.xz|*.txz)         tar -xvf "$1" --use-compress-program=pixz ;;
            (*.tar.zma|*.tlz)        tar --lzma -xvf "$1" ;;
            (*.tar)                  tar -xvf "$1" ;;
            (*.gz)                   gunzip "$1" ;;
            (*.bz2)                  bunzip2 "$1" ;;
            (*.xz)                   unxz "$1" ;;
            (*.lzma)                 unlzma "$1" ;;
            (*.Z)                    uncompress "$1" ;;
            (*.zip|*.jar)            unzip "$1" -d $extract_dir ;;
            (*.rar)                  unrar x -ad "$1" ;;
            (*.7z)                   7za x "$1" ;;
            (*.deb)                  mkdir -p "$extract_dir/control"
                                     mkdir -p "$extract_dir/data"
                                     cd "$extract_dir"; ar vx "${file_path}" > /dev/null
                                     cd control; tar xvf ../control.tar.*
                                     cd ../data; tar xvf ../data.tar.*
                                     cd ..; rm control.tar.* data.tar.* debian-binary
                                     cd ..
            ;;
            (*)                      >&2 echo "$0: cannot extract: $1"
                                     success=1
            ;;
        esac

        (( success = $success > 0 ? $success : $? ))
        shift
    done
}

lsarchive() {
    if (( $# == 0 )); then
        >&2 echo "usage: $0 [-option] [file ...]"
        exit 1
    fi

    while (( $# > 0 )); do
        if [[ ! -s "$1" ]]; then
            >&2 echo "$0: file not valid: $1"
            shift
            continue
        fi

        case "$1:l" in
            (*.tar.gz|*.tgz)         tar tvzf "$1" ;;
            (*.tar.bz2|*.tbz|*.tbz2) tar tjf "$1" ;;
            (*.tar.xz|*.txz)         tar --xz -tf "$1" ;;
            (*.tar.zma|*.tlz)        tar --lzma -tf "$1" ;;
            (*.tar)                  tar tf "$1" ;;
            (*.zip|*.jar)            unzip -l "$1" ;;
            (*.rar)                  unrar -l "$1" ;;
            (*.7z)                   7za l "$1" ;;
            (*)                      >&2 echo "$0: cannot list: $1"
                                     success=1
            ;;
        esac

        shift
    done
}
