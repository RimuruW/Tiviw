find $PREFIX/etc/tiviw -name "*.sh" -exec chmod +x {} \;
[[ -f $PREFIX/etc/tiviw/main/tiviw ]] && chmod +x $PREFIX/etc/tiviw/main/tiviw
[[ -f $PREFIX/bin/tiviw ]] && chmod +x $PREFIX/bin/tiviw