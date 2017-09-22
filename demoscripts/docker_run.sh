echo "should be running docker run with these args"
echo $@

LAYOUT_PATH=/home/santiago/Documents/p2017/in-toto-general/docker-demo/in-toto-metadata/root.layout
JUSTIN_PUB=/home/santiago/Documents/p2017/in-toto-general/docker-demo/in-toto-metadata/justin.pub
LAYOUT_PATH=/home/santiago/Documents/p2017/in-toto-general/docker-demo/output_links/


asksure() {
echo -n "In-toto verification failed! do you want to continue? (Y/N)? "
while read -r -n 1 -s answer; do
  if [[ $answer = [YyNn] ]]; then
    [[ $answer = [Yy] ]] && retval=0
    [[ $answer = [Nn] ]] && retval=1
    break
  fi
done

cp $LAYOUT_PATH .
cp $OUTPUT_LINKS .
cp $JUSTIN_PUB .
res=$(in-toto-verify --layout root.layout --layout-keys justin.pub)
if $res
then
	if asksure then
		echo "Continuing..."	
	else
		exit(1)
	fi
fi
/usr/bin/docker $@

# clean up...
rm root.layout
rm *.link
