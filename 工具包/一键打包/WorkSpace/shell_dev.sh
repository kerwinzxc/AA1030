#! /bin/bash
# created by Ficow Shen

#工程绝对路径
project_path=/Users/mac/Desktop/WorkSpace
#工程文件路径
proj_path=${project_path}/WorkSpace.xcodeproj
#打包模式 Debug/Release
development_mode=Release
#scheme名
scheme_name=WorkSpace

#build文件夹路径
build_path=${project_path}/WorkSpace/build

#plist文件所在路径
exportOptionsPlistPath=${project_path}/WorkSpace/exportTest_dev.plist

#导出.ipa文件所在路径
exportFilePath=${project_path}/WorkSpace/IPA_dev


echo '*** 正在 清理工程 ***'
/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild \
clean -project ${proj_path} -configuration ${development_mode} -alltargets
echo '*** 清理完成 ***'



echo '*** 正在 编译工程 For '${development_mode}
/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild \
archive -project ${proj_path} -scheme ${scheme_name} -configuration Release -archivePath ${build_path}/game.xcarchive
echo '*** 编译完成 ***'



echo '*** 正在 打包 ***'
/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild \
-exportArchive -archivePath ${build_path}/game.xcarchive -exportOptionsPlist ${exportOptionsPlistPath} -exportPath ${exportFilePath}

if [ -e $exportFilePath/$scheme_name.ipa ]; then
echo "*** dev.ipa文件已导出 ***"
open $exportFilePath
else
echo "*** 创建 dev.ipa文件失败 ***"
fi
echo '*** dev打包完成 ***'
