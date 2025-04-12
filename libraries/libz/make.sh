PKGURL=https://github.com/madler/zlib/archive/v1.3.1.zip
PKGHASH=aafd4f6196c7024a81d3268bf0b777c9b814cf2c

package_download $PKGURL $PKGHASH

if [ ! "$SYS_PLATFORM" = "win32" ] || [ `uname | cut -c 1-6` = "CYGWIN" ]; then
  NOQUIET=yupgofigure package_configure --static
else
  PREFIX=`echo "$SYS_STRIP" | sed 's/strip$//;s/ $//'`
  cat win32/Makefile.gcc | sed "s|^PREFIX|PREFIX=$PREFIX#|" > Makefile
fi

package_make 
INCLUDE_PATH="$SYS_PREFIX/include" LIBRARY_PATH="$SYS_PREFIX/lib" BINARY_PATH="$SYS_PREFIX/bin" make install -s
package_cleanup

#eof
