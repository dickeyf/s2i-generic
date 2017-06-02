# Source To Image builder Docker Image for building generic applications

This S2I builder was created to build C/C++ applications with autotools, but can compile other kind of applications as
long as the proper script is provided.

This builder image depends on the project providing a build.sh script which takes care of compiling the project and
staging its build output inside a `staging` directory.  See the test application at [Test Application](test/testApp) for
an example.

This at the cost of requiring the application's repository to expose a script which build, and stage the application but
will allow almost any kind of application to be built from this S2I.

# Creating the S2I Image from this Dockerfile

```
docker build -t s2i-makefile .
```

# Compiling a project with this S2I

```
git clone <project>
s2i build project s2i-makefile project-image
```

# Creating the build.sh script

The script shall do whatever steps necessary to compile the application, and install its output in the `staging`
directory.  It shall also produce a `start.sh` script located here : `staging/start.sh` that defines how to start the
application.  This will be the entry point of the output Docker image.

IE. :
```
#!/bin/bash
# Example build.sh script

# Create the staging directory
mkdir -p staging

# 
./configure --prefix=`pwd`/staging
make
make install

cp start.sh staging/
```