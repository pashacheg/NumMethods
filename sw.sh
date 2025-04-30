#!/bin/sh

usage() {
    for msg in "$@"; do printf "%s\n" "${0##*/}: $msg" >&2; done
    echo "usage: ${0##*/} [-v] source name price author ..." >&2
    exit 1
}

# Обработка опционального флага -v
verbose=0
if [ "$1" = "-v" ]; then
    verbose=1
    shift
fi

# Проверка количества аргументов
[ $# -ge 4 ] || usage "not enough arguments"

bookdir=$1
bookname=$2
bookprice=$3
shift 3
authors="$@"

# Проверка существования библиотеки
test -e .library || (echo "error: .library not found" >&2 && exit 1)

# Создание временной копии в .tmp
mkdir -p .tmp
tmpfile=".tmp/$bookname"
cp "$bookdir" "$tmpfile" || (echo "error: failed to copy to .tmp" >&2 && exit 1)

# Размещение книги в books/ (учёт дубликатов)
mkdir -p books
num=1
finalname="$bookname"
if [ -e "books/$bookname" ]; then
    while [ -e "books/$bookname.$num" ]; do
        num=$((num+1))
    done
    finalname="$bookname.$num"
fi
mv "$tmpfile" "books/$finalname"
chmod 664 "books/$finalname"

[ $verbose -eq 1 ] && echo "book installed as books/$finalname"

# Обработка цены
mkdir -p prices
if [ "$bookprice" != "-" ]; then
    echo "$bookprice" > "prices/$finalname.price"
    chmod 644 "prices/$finalname.price"
    [ $verbose -eq 1 ] && echo "price set: $bookprice"
fi

# Работа с авторами
mkdir -p authors
authmode=$(stat -c %a authors)

for author in $authors; do
    mkdir -p "authors/$author"
    chmod "$authmode" "authors/$author"
    ln "books/$finalname" "authors/$author/$finalname" 2>/dev/null || {
        echo "error: failed to create hard link for $author" >&2
        exit 1
    }
    [ $verbose -eq 1 ] && echo "linked for author: $author"
done
