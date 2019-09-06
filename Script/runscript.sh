#!/bin/sh

#声明数组
echo "**********************脚本运行开始**********************"
sh autoGeneratingCode.sh
echo "**********************脚本运行结束**********************"

# echo "**********************开始**********************"
# #获取info.plist信息 CFBundleVersion 可以更改为想获取的信息的名字
# buildNumber=$(/usr/libexec/PlistBuddy -c "Print :CFBundleVersion" "${PROJECT_DIR}/${INFOPLIST_FILE}")
# shortVersion=$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "${PROJECT_DIR}/${INFOPLIST_FILE}")
# buildNumber=$(date +%Y%m%d%H%M)
# /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "$INFOPLIST_FILE"
#
# echo "**********************结束**********************"
