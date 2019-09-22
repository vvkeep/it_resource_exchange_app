echo '///-----------'
echo '/// 正在清理工程'
echo '///-----------'
echo ''
flutter clean
flutter build apk
curl -F "file=@build/app/outputs/apk/release/app-release.apk" -F "uKey=768e354333dfbf4255a942c32ab3a3c7" -F "_api_key=4c7feb6db8e721f440bbdafa8917d5b5" https://qiniu-storage.pgyer.com/apiv1/app/upload 
echo '///-----------'
echo '/// Android 上传成功'
echo '///-----------'
echo ''

flutter clean
flutter build ios
cd ios/

if [ ! -d ./IPADir ];
then
mkdir -p IPADir;
fi

if [ ! -d ./build ];
then
mkdir -p build;
fi

#工程绝对路径
project_path=$(cd `dirname $0`; pwd)

#App名称
app_name=$(basename ./*.xcodeproj)

#工程名 
project_name=$(echo $app_name | awk -F. '{print $1}')

#scheme名 替换成自己的sheme名
scheme_name=$project_name

#打包模式 TestMode_TestEnv_Release/ProMode_ProEnv_Release
development_mode=Release

#plist文件所在路径
exportOptionsPlistPath=${project_path}/ExportOptions.plist

#导出.ipa文件所在路径
exportIpaPath=${project_path}/IPADir/${development_mode}

build_path=${project_path}/build/${development_mode}

echo '///-----------'
echo '/// 正在清理工程'
echo '///-----------'
echo ''
# rm -rf build
xcodebuild \
clean -workspace ${project_name}.xcworkspace -scheme ${scheme_name} -quiet || exit

echo '///--------'
echo '/// 清理完成'
echo '///--------'
echo ''

echo '///-----------'
echo '/// 正在编译工程:'${development_mode}
echo '///-----------'
xcodebuild \
archive -workspace ${project_path}/${project_name}.xcworkspace \
-scheme ${scheme_name} \
-configuration ${development_mode} \
-archivePath ${build_path}/${project_name}.xcarchive -quiet || exit

echo '///--------'
echo '/// 编译完成'
echo '///--------'
echo ''

echo '///----------'
echo '/// 开始ipa打包'
echo '///----------'
xcodebuild -exportArchive -archivePath ${build_path}/${project_name}.xcarchive \
-configuration ${development_mode} \
-exportPath ${exportIpaPath} \
-exportOptionsPlist ${exportOptionsPlistPath} \
-quiet || exit

if [ -e $exportIpaPath/$scheme_name.ipa ]; then
echo '///----------'
echo '/// ipa包已导出'
echo '///----------'
open $exportIpaPath
else
echo '///-------------'
echo '/// ipa包导出失败 '
echo '///-------------'
fi
echo '///------------'
echo '/// 打包ipa完成  '
echo '///------------'
echo ''

echo '///-------------'
echo '/// 开始发布ipa包 '
echo '///-------------'
echo ''

# 目前不需要区分上传的环境 TestFlight 或者Appstore正式版 都是上传到AppStore的
altoolPath="/Applications/Xcode.app/Contents/Applications/Application Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/altool"
echo '///-------------'
echo '/// 开始验证ipa包'
echo '///-------------'
echo ''
"$altoolPath" --validate-app -f ${exportIpaPath}/${scheme_name}.ipa -u 15919688564@163.com -p rgdc-jwuc-duds-quzy -t ios --output-format normal
echo '///----------------------'
echo '/// 校验成功,开始上传ipa包'
echo '///----------------------'
echo ''
"$altoolPath" --upload-app -f ${exportIpaPath}/${scheme_name}.ipa -u 15919688564@163.com -p rgdc-jwuc-duds-quzy -t ios --output-format normal
echo '///----------------------'
echo '/// 打包上传成功'
echo '///----------------------'

cd ..