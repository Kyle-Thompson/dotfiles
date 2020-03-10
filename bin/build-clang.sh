#/bin/sh -e

# arguments
BRANCH=${2:-master}

# cmake flags
PROJECTS="-DLLVM_ENABLE_PROJECTS='clang;clang-tools-extra;lld;lldb;compiler-rt'"
BUILD_TYPE="-DCMAKE_BUILD_TYPE=Release"
BINDINGS="-DLLVM_ENABLE_BINDINGS=Off"

if test ! -d $HOME/src/llvm-project; then
  [ ! -d $HOME/src ] && mkdir $HOME/src
  git clone https://github.com/llvm/llvm-project.git $HOME/src/llvm-project
fi

cd $HOME/src/llvm-project

git checkout $BRANCH
git pull

mkdir -p build
cd build
cmake $PROJECTS $BUILD_TYPE $BINDINGS ../llvm
cmake --build . -j$(nproc)
sudo cmake --build . -j$(nproc) --target install
