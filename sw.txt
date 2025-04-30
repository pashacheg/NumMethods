bookdir=$1
bookname=$2
bookprice=$3


test -e .library || (echo "error" >&2 && exit)

num=1
if test -e "books/$bookname"; then
        while test -e "books/$bookname.$num"; do num=$((num+1)); done
        cp "$bookdir" "books/$bookname.$num"
        bookname="$bookname.$num"
else
        cp "$bookdir" "books/$bookname"
fi

chmod 664 "books/$bookname"

if ["$bookprice" != "-"]; then
        touch "prices/$bookname.price"
        chmod 644 "prices/$bookname.price"
        echo "$bookprice" > "prices/$bookname.price"
fi


