clear

qtversion="5.12.10"
echo "qtversion = $qtversion"
qt_version="$(echo "$qtversion" | tr '.' '_')"
echo "qt_version = $qt_version"

compiler_bin="C:/Qt/Qt${qtversion}/${qtversion}/msvc2017_64/bin"
echo "compiler_bin = $compiler_bin"

target="Rudiron_Installer"
echo "target = $target"

target_user="$(echo "$target" | tr '_' ' ')"
echo "target_user = $target_user"

root_dir="C:/Users/daniil/Documents/GitHub/Rudiron_Installer"
echo "root_dir = $root_dir"
cd $root_dir

rm -r release
mkdir release
# cp -a 'C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.16.27023/bin/HostX64/x64' release/
cp -a 'C:/Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/VC/Redist/MSVC/14.16.27012/x64/Microsoft.VC141.CRT/.' release/
cd $root_dir
cd "../"
cp -r "build-$target-Desktop_Qt_${qt_version}_MSVC2017_64bit-Release/release/$target.exe" $root_dir/release/
cd $root_dir
mv "release/$target.exe" "release/$target_user.exe"

cd $compiler_bin
./windeployqt.exe "$root_dir/release/$target_user.exe" --qmldir=$root_dir/Components --release

$SHELL