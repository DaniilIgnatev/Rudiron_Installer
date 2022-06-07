rm -r installer
mkdir installer
cp -a 'C:/Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/VC/Redist/MSVC/14.16.27012/x64/Microsoft.VC141.CRT/.' installer/
cp C:/Users/daniil/Documents/GitHub/build-RudironInstaller-Desktop_Qt_5_12_10_MSVC2017_64bit-Release/release/RudironInstaller.exe installer/
cd C:/Qt/Qt5.12.10/5.12.10/msvc2017_64/bin
./windeployqt.exe --release --qmldir C:/Users/daniil/Documents/GitHub/RudironInstaller C:/Users/daniil/Documents/GitHub/RudironInstaller/installer/RudironInstaller.exe
$SHELL
