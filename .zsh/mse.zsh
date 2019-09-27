enable-cli() {
    . /home/maximbaz/.cache/pypoetry/virtualenvs/enable-cli-py3.7/bin/activate
    command enable-cli $*
}

# Useful functions
mse-get-properties() {
  /usr/bin/ssh $1 "sudo sh -c 'cd /etc/sindbad/local; tar czf - *.properties *.jks'" | tar xzf -
}

mse-build() {
  mse-build-full -DskipDebianPackaging=true -DskipJavadoc=true $*
}

mse-rebuild() {
  mse-build -am $*
}

mse-build+debian() {
  mse-build-full -DskipJavadoc=true $*
}

mse-rebuild+debian() {
  mse-build+debian -am $*
}

mse-build-only() {
  mse-build-full -DskipDebianPackaging=true -DskipJavadoc=true -DskipTests=true $*
}

mse-rebuild-only() {
  mse-build-only -am $*
}

mse-build-only+debian() {
  mse-build-full -DskipJavadoc=true -DskipTests=true $*
}

mse-rebuild-only+debian() {
  mse-build-only+debian -am $*
}

mse-build-full() {
  mvn -T 3 -Dgwt.compiler.localWorkers=3 -Dsindbad.profile=dev -Djava.awt.headless=true -P dev $* clean package
}
