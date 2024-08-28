read_dom () {
    local IFS=\>
    read -d \< ENTITY CONTENT
    local ret=$?
    TAG_NAME=${ENTITY%% *}
    ATTRIBUTES=${ENTITY#* }
    ENTITY=$ENTITY
    CONTENT=$CONTENT
    return $ret
}

parse_dom () {
    if [[ $TAG_NAME = "mxfile" ]] ; then
        eval local $ATTRIBUTES
	echo "<$ENTITY>"
    elif [[ $TAG_NAME = "diagram" ]] ; then
        eval local $ATTRIBUTES
        text="<$ENTITY>$CONTENT</$TAG_NAME>"
        echo "$name"
	echo $text > "$name.xml"
    fi

}

while read_dom; do
    parse_dom
done
