rm -r installer
mkdir installer
cp C:/Users/daniil/Documents/GitHub/build-RudironInstaller-Desktop_Qt_5_12_10_MinGW_64_bit-Release/release/RudironInstaller.exe C:/Users/daniil/Documents/GitHub/RudironInstaller/installer/
cd C:/Qt/Qt5.12.10/5.12.10/mingw73_64/bin
./windeployqt.exe  --release --qmldir C:/Users/daniil/Documents/GitHub/RudironInstaller C:/Users/daniil/Documents/GitHub/RudironInstaller/installer/RudironInstaller.exe
$SHELL
