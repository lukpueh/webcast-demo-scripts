echo "should be running docker build with these args"
echo $@
# to simulate build, we will build with -q (twice) and then save the resulting
# container to a .tar.gz file
KEY=/home/santiago/Documents/p2017/in-toto-general/docker-demo/in-toto-metadata/santiago

in-toto-run --step-name dockerize --key $KEY --materials . -- sudo /usr/bin/docker $@ 
