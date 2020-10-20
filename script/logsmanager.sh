LogPATH="$PREFIX/etc/tiviw/logs"
if [ -f "$LogPATH/1.log" ]; then
	echo "尝试整理日志…"
	[[ -f "$LogPATH/5.log" ]] && rm -f $LogPATH/5.log
	[[ -f "$LogPATH/4.log" ]] && mv -f $LogPATH/5.log
	[[ -f "$LogPATH/3.log" ]] && mv -f $LogPATH/4.log
	[[ -f "$LogPATH/2.log" ]] && mv -f $LogPATH/3.log
	[[ -f "$LogPATH/1.log" ]] && mv -f $LogPATH/2.log
	echo "已完成日志整理！"
fi
