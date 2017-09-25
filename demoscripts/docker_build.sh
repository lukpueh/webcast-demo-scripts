echo "should be running docker build with these args"
echo $@
# to simulate build, we will build with -q (twice) and then save the resulting
# container to a .tar.gz file

in-toto-run --step-name dockerize --key $KEY --materials react-webapp Dockerfile -- ${DOCKER} $@
