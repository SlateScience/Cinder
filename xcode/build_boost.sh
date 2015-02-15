#!/bin/sh

# download from: http://sourceforge.net/projects/boost/files/boost/1.53.0/

if [[ ! $BOOST_SRC_PATH ]]; then
    echo "You have to define BOOST_SRC_PATH"
    exit 1
fi

if [[ ! $CINDER_PATH ]]; then
    echo "You have to define CINDER_PATH"
    exit 1
fi


cd $BOOST_SRC_PATH

./bootstrap.sh –with-libraries=filesystem,system,date_time
./b2 -a -j4 toolset=clang-osx link=static stage 
cp stage/lib/*.a $CINDER_PATH/lib/macosx

rm -rf stage
./b2 -a -j4 toolset=clang-ios link=static stage
cp stage/lib/*.a $CINDER_PATH/lib/ios

rm -rf stage 
./b2 -a -j4 toolset=clang-ios_sim link=static stage
cp stage/lib/*.a ../lib/ios-sim
