find $PREFIX/etc/tiviw -name "*.sh" -exec chmod +x {} \;
[[ -f $PREFIX/etc/tiviw/core/tiviw ]] && chmod +x $PREFIX/etc/tiviw/core/tiviw
[[ -f $PREFIX/bin/tiviw ]] && chmod +x $PREFIX/bin/tiviw