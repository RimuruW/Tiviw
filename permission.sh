find $PREFIX/etc/tconfig -name "*.sh" -exec chmod +x {} \;
[[ -f $PREFIX/etc/tconfig/main/tconfig ]] && chmod +x $PREFIX/etc/tconfig/main/tconfig
[[ -f $PREFIX/etc/tconfig/tconfig ]] && chmod +x $PREFIX/bin/tconfig