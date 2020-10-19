find $PREFIX/etc/tiviw -name "*.sh" -exec chmod +x {} \;
[[ -f $PREFIX/etc/tiviw/main/tiviw ]] && chmod +x $PREFIX/etc/tiviw/main/tiviw
[[ -f $PREFIX/etc/tiviw/tiviw ]] && chmod +x $PREFIX/bin/tiviw