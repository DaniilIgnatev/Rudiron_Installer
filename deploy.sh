rm -r installer
mkdir installer
cp -a 'C:/Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/VC/Redist/MSVC/14.16.27012/x64/Microsoft.VC141.CRT/.' installer/
cp C:/Users/daniil/Documents/GitHub/build-RudironInstaller-Qt_5_12_10_msvc2017_64-Release/release/RudironInstaller.exe installer/
cd C:/Qt/5.15.2/msvc2015_64/bin
./windeployqt.exe --qmldir C:/Users/daniil/Documents/GitHub/RudironInstaller C:/Users/daniil/Documents/GitHub/RudironInstaller/installer/RudironInstaller.exe

