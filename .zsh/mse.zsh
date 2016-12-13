# Useful functions
mse-get-properties() {
  ssh $1 "sudo sh -c 'cd /etc/sindbad/local; tar czf - *.properties'" | tar xzf -
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
  if curl --silent localhost:8080 > /dev/null; then
    echo "REST-CORE is running, halting build"
    return
  fi
  LOG_FILE="/tmp/mse_build_`date +%Y-%m-%d_%H%M%S`.log"
  LOG_FILE_ERR="/tmp/mse_build_`date +%Y-%m-%d_%H%M%S`_error.log"
  echo $LOG_FILE

  BUILD_COMMAND="mvn -T 3 -Dgwt.compiler.localWorkers=3 -Dsindbad.profile=dev -Djava.awt.headless=true -P dev $* clean install"
  echo $BUILD_COMMAND > $LOG_FILE
  echo $BUILD_COMMAND > $LOG_FILE_ERR

  echo "Build in progress..."
  eval $BUILD_COMMAND >> $LOG_FILE 2>$LOG_FILE_ERR

  if [ $? = 0 ]; then
    notify_title="Build SUCCESS"
    notify_urgency="normal"
    notify_message="MSE build has succeeded."
  else
    notify_title="Build FAILURE"
    notify_urgency="critical"
    notify_message="MSE build has failed.\\n\\n`tail $LOG_FILE | sed 's/&/\&amp;/g' | sed 's/</\&lt;/g' | sed 's/>/\&gt;/g'`"
  fi

  ~/bin/client_notify.pl $notify_urgency $notify_title $notify_message

  tail $LOG_FILE
}

