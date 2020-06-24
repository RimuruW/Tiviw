
function youget1(){
echo -e "\n\n"
echo "you-get 支持的链接种类请打开这个链接查看: https://github.com/soimort/you-get/wiki/%E4%B8%AD%E6%96%87%E8%AF%B4%E6%98%8E#%E6%94%AF%E6%8C%81%E7%BD%91%E7%AB%99"
echo "you-get 也可以下载网页上的视频和图片"
echo -e "请输入您的下载链接(必填)"
echo -en "\t\tEnter: "
read yougetlink
echo -e "请输入您的下载路径(选填,路径默认指向内置存储.比如,如果你输入 Download,则文件会下载至内置存储的 Download 文件夹中)"
green "看不懂就直接回车"
echo -en "\t\tEnter: "
read tmpdiryouget
echo -e "如果您输入的链接属于某一播放列表里面的一个,您是否想下载该列表里面的所有视频?(y/n)”
echo -en "\t\tEnter: "
read tmpyougetlist
if  [ "$tmpyougetlist = y" ]; then
yougetlist=-list
fi
yougetdownloaddir=/sdcard/$tmpdiryouget
blue "下载即将开始..."
you-get -o $yougetdownloaddir $yougetlist $yougetlink
green "下载已停止!"
green "这可能是因为所需下载内容已下载完毕,或者下载中断"
return 0
}