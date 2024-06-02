cd ${DTC_HOME}/third_party/glog  && mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${DTC_HOME}/third_party/glog/build ..
make -j
make install 

GlogPath="${DTC_HOME}/third_party/glog"
#setting up GLOG environment
if [ -z "$GlogPath" ]
then
  echo "Glog path is not defined."
  echo "Glog will not be used."
else
  echo "Setting up Glog environment..."
  export GLOG_PATH=$GlogPath
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$GLOG_PATH/build/lib
  export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$GLOG_PATH/build/include
  export LIBRARY_PATH=$LD_LIBRARY_PATH:$GLOG_PATH/build/lib
fi


cd ${DTC_HOME}/third_party/sputnik  && mkdir build && cd build
cmake .. -DGLOG_INCLUDE_DIR=$GLOG_PATH/build/include -DGLOG_LIBRARY=$GLOG_PATH/build/lib/libglog.so -DCMAKE_BUILD_TYPE=Release -DBUILD_TEST=OFF -DBUILD_BENCHMARK=OFF -DCUDA_ARCHS="89;86"
make -j12 


SputnikPath="${DTC_HOME}/third_party/sputnik"

#setting up Sputnik environment
if [ -z "$SputnikPath" ]
then
  echo "Sputnik path is not defined."
  echo "Sputnik will not be used."
else
  echo "Setting up Sputnik environment..."
  export SPUTNIK_PATH=$SputnikPath
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SPUTNIK_PATH/build/sputnik
fi
