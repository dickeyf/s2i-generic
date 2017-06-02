#!/bin/bash
aclocal
autoconf
automake --add-missing
mkdir -p staging
./configure --prefix=`pwd`/staging
make
make install

cat << EOF > staging/start.sh
#!/bin/bash -e

bin/test_app
EOF
chmod +x staging/start.sh