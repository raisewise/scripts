#!/bin/sh

DOWNLOAD_PATH=$PWD
INSTALL_PATH=$PWD/Python-$VERSION
VERSION=3.8.4
INSTALL_PATH=$PWD/Python-$VERSION

usage() {
  

wget https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz
tar xvzf $DOWNLOAD_PATH/Python-$VERSION.tgz
$PWD/configure --prefix=$PWD/python3 --enable-shared
make && make install
cat << EOF > $PWD/python37.sh
#!/bin/sh

PATH=i\$PATH:$PWD/python37/bin
LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:$PWD/lib
export PATH LD_LIBRARY_PATH
EOF
source $PWD/python37.sh
