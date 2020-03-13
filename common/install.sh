FONTDIR=$MODPATH/custom
SYSFONT=$MODPATH/system/fonts
PRDFONT=$MODPATH/system/product/fonts
SYSETC=$MODPATH/system/etc
SYSXML=$SYSETC/fonts.xml
MODPROP=$MODPATH/module.prop

patch() {
	# umount /system/etc/fonts.xml
	# cp /system/etc/fonts.xml $SYSXML
	cp /sbin/.magisk/mirror/system/etc/fonts.xml $SYSXML
	if [ $PART -eq 1 ]; then
		sed -i '/\"sans-serif\">/i \
	<family name="sans-serif">\
		<font weight="100" style="normal">Thin.ttf</font>\
		<font weight="100" style="italic">ThinItalic.ttf</font>\
		<font weight="300" style="normal">Light.ttf</font>\
		<font weight="300" style="italic">LightItalic.ttf</font>\
		<font weight="400" style="normal">Regular.ttf</font>\
		<font weight="400" style="italic">Italic.ttf</font>\
		<font weight="500" style="normal">Medium.ttf</font>\
		<font weight="500" style="italic">MediumItalic.ttf</font>\
		<font weight="900" style="normal">Black.ttf</font>\
		<font weight="900" style="italic">BlackItalic.ttf</font>\
		<font weight="700" style="normal">Bold.ttf</font>\
		<font weight="700" style="italic">BoldItalic.ttf</font>\
	</family>' $SYSXML
		sed -i 's/RobotoCondensed/Condensed/' $SYSXML
	else
		sed -i '/\"sans-serif\">/i \
	<family name="sans-serif">\
		<font weight="100" style="normal">Roboto-Thin.ttf</font>\
		<font weight="100" style="italic">Roboto-ThinItalic.ttf</font>\
		<font weight="300" style="normal">Roboto-Light.ttf</font>\
		<font weight="300" style="italic">Roboto-LightItalic.ttf</font>\
		<font weight="400" style="normal">Roboto-Regular.ttf</font>\
		<font weight="400" style="italic">Roboto-Italic.ttf</font>\
		<font weight="500" style="normal">Medium.ttf</font>\
		<font weight="500" style="italic">MediumItalic.ttf</font>\
		<font weight="900" style="normal">Black.ttf</font>\
		<font weight="900" style="italic">BlackItalic.ttf</font>\
		<font weight="700" style="normal">Bold.ttf</font>\
		<font weight="700" style="italic">BoldItalic.ttf</font>\
	</family>' $SYSXML
	fi
	sed -i ':a;N;$!ba; s/ name=\"sans-serif\"//2' $SYSXML
}

headline() { cp $FONTDIR/hf/*ttf $SYSFONT; }

body() { cp $FONTDIR/bf/*ttf $SYSFONT; }

condensed() { cp $FONTDIR/cf/*ttf $SYSFONT; }

full() { headline; body; condensed; }

cleanup() {
	rm -rf $FONTDIR
	rmdir -p $SYSETC $PRDFONT
}

pixel() {
	if [ -f /product/fonts/GoogleSans-Regular.ttf ]; then
		DEST=$PRDFONT
	elif [ -f /system/fonts/GoogleSans-Regular.ttf ]; then
		DEST=$SYSFONT
	fi
	if [ ! -z $DEST ]; then
		cp $FONTDIR/px/*ttf $DEST
		sed -ie 3's/$/-pxl&/' $MODPROP
	fi
}

oxygen() {
	if [ -f /system/fonts/SlateForOnePlus-Regular.ttf ]; then
		cp $SYSFONT/Black.ttf $SYSFONT/SlateForOnePlus-Black.ttf
		cp $SYSFONT/Bold.ttf $SYSFONT/SlateForOnePlus-Bold.ttf
		cp $SYSFONT/Medium.ttf $SYSFONT/SlateForOnePlus-Medium.ttf
		cp $SYSFONT/Regular.ttf $SYSFONT/SlateForOnePlus-Regular.ttf
		cp $SYSFONT/Regular.ttf $SYSFONT/SlateForOnePlus-Book.ttf
		cp $SYSFONT/Light.ttf $SYSFONT/SlateForOnePlus-Light.ttf
		cp $SYSFONT/Thin.ttf $SYSFONT/SlateForOnePlus-Thin.ttf
		sed -ie 3's/$/-oos&/' $MODPROP
	fi
}

miui() {
	if i=$(grep miui $SYSXML); then
		sed -i '/\"miui\"/,/family>/{/400/,/>/s/MiLanProVF/Regular/;/700/,/>/s/MiLanProVF/Bold/;/stylevalue/d}' $SYSXML
		sed -i '/\"miui-thin\"/,/family>/{/400/,/>/s/MiLanProVF/Thin/;/700/,/>/s/MiLanProVF/Light/;/stylevalue/d}' $SYSXML
		sed -i '/\"miui-light\"/,/family>/{/400/,/>/s/MiLanProVF/Light/;/700/,/>/s/MiLanProVF/Regular/;/stylevalue/d}' $SYSXML
		sed -i '/\"miui-regular\"/,/family>/{/400/,/>/s/MiLanProVF/Regular/;/700/,/>/s/MiLanProVF/Medium/;/stylevalue/d}' $SYSXML
		sed -i '/\"miui-bold\"/,/family>/{/400/,/>/s/MiLanProVF/Medium/;/700/,/>/s/MiLanProVF/Bold/;/stylevalue/d}' $SYSXML
		sed -i '/\"mipro\"/,/family>/{/400/,/>/s/MiLanProVF/Regular/;/700/,/>/s/MiLanProVF/Bold/;/stylevalue/d}' $SYSXML
		sed -i '/\"mipro-thin\"/,/family>/{/400/,/>/s/MiLanProVF/Thin/;/700/,/>/s/MiLanProVF/Light/;/stylevalue/d}' $SYSXML
		sed -i '/\"mipro-extralight\"/,/family>/{/400/,/>/s/MiLanProVF/Thin/;/700/,/>/s/MiLanProVF/Light/;/stylevalue/d}' $SYSXML
		sed -i '/\"mipro-light\"/,/family>/{/400/,/>/s/MiLanProVF/Light/;/700/,/>/s/MiLanProVF/Regular/;/stylevalue/d}' $SYSXML
		sed -i '/\"mipro-normal\"/,/family>/{/400/,/>/s/MiLanProVF/Light/;/700/,/>/s/MiLanProVF/Regular/;/stylevalue/d}' $SYSXML
		sed -i '/\"mipro-regular\"/,/family>/{/400/,/>/s/MiLanProVF/Regular/;/700/,/>/s/MiLanProVF/Medium/;/stylevalue/d}' $SYSXML
		sed -i '/\"mipro-medium\"/,/family>/{/400/,/>/s/MiLanProVF/Medium/;/700/,/>/s/MiLanProVF/Bold/;/stylevalue/d}' $SYSXML
		sed -i '/\"mipro-demibold\"/,/family>/{/400/,/>/s/MiLanProVF/Medium/;/700/,/>/s/MiLanProVF/Bold/;/stylevalue/d}' $SYSXML
		sed -i '/\"mipro-semibold\"/,/family>/{/400/,/>/s/MiLanProVF/Medium/;/700/,/>/s/MiLanProVF/Bold/;/stylevalue/d}' $SYSXML
		sed -i '/\"mipro-bold\"/,/family>/{/400/,/>/s/MiLanProVF/Bold/;/700/,/>/s/MiLanProVF/Black/;/stylevalue/d}' $SYSXML
		sed -i '/\"mipro-heavy\"/,/family>/{/400/,/>/s/MiLanProVF/Black/;/stylevalue/d}' $SYSXML
		sed -ie 3's/$/-miui&/' $MODPROP
	fi
}

rom() { pixel; oxygen; miui; }

### SELECTIONS ###

PART=1
ui_print "   "
ui_print "- WHERE to install?"
ui_print "  Vol+ = Select; Vol- = Ok"
ui_print "   "
ui_print "  1. Full"
ui_print "  2. Headline"
ui_print "   "
ui_print "  Select:"
while true; do
	ui_print "  $PART"
	if $VKSEL; then
		PART=$((PART + 1))
	else 
		break
	fi
	if [ $PART -gt 2 ]; then
		PART=1
	fi
done
ui_print "   "
ui_print "  Selected: $PART"

### INSTALLATION ###
ui_print "   "
ui_print "- Installing"

mkdir -p $SYSFONT $SYSETC $PRDFONT
patch

case $PART in
	1 ) full;;
	2 ) headline; sed -ie 3's/$/-hf&/' $MODPROP;;
esac

rom

### CLEAN UP ###
ui_print "- Cleaning up"
cleanup

ui_print "   "
