Format: 3.0 (native)
Source: linux-latest
Binary: linux-source, linux-doc, linux-perf, linux-image-alpha-generic, linux-headers-alpha-generic, linux-image-alpha-smp, linux-headers-alpha-smp, linux-image-amd64, linux-headers-amd64, linux-image-amd64-dbg, xen-linux-system-amd64, linux-image-arm64, linux-headers-arm64, linux-image-arm64-dbg, linux-image-marvell, linux-headers-marvell, linux-image-versatile, linux-headers-versatile, linux-image-armmp, linux-headers-armmp, linux-image-armmp-lpae, linux-headers-armmp-lpae, linux-image-parisc, linux-headers-parisc, linux-image-parisc64-smp, linux-headers-parisc64-smp, linux-image-686, linux-headers-686, linux-image-686-pae, linux-headers-686-pae, linux-image-686-pae-dbg, linux-image-m68k, linux-headers-m68k, linux-image-4kc-malta, linux-headers-4kc-malta, linux-image-5kc-malta, linux-headers-5kc-malta, linux-image-octeon, linux-headers-octeon, linux-image-loongson-2e, linux-headers-loongson-2e, linux-image-loongson-2f, linux-headers-loongson-2f, linux-image-loongson-3,
 linux-headers-loongson-3, linux-image-powerpc, linux-headers-powerpc, linux-image-powerpc-smp, linux-headers-powerpc-smp, linux-image-powerpc64, linux-headers-powerpc64, linux-image-powerpcspe, linux-headers-powerpcspe, linux-image-powerpc64le, linux-headers-powerpc64le, linux-image-s390x, linux-headers-s390x, linux-image-s390x-dbg, linux-image-sh7751r, linux-headers-sh7751r, linux-image-sh7785lcr, linux-headers-sh7785lcr, linux-image-sparc64, linux-headers-sparc64, linux-image-sparc64-smp, linux-headers-sparc64-smp, linux-tools, linux-image-586, linux-headers-586, linux-image-kirkwood, linux-headers-kirkwood, linux-image-orion5x,
 linux-headers-orion5x
Architecture: all alpha amd64 arm64 armel armhf hppa i386 m68k mips mipsel mips64 mips64el powerpc ppc64 powerpcspe ppc64el s390x sh4 sparc64
Version: 73+parrot1
Maintainer: Kali Developers <devel@kali.org>
Uploaders: Raphaël Hertzog <hertzog@debian.org>, Sophie Brun <sophie@freexian.com>
Standards-Version: 3.9.5
Vcs-Browser: https://anonscm.debian.org/cgit/kernel/linux-latest.git
Vcs-Git: https://anonscm.debian.org/git/kernel/linux-latest.git
Build-Depends: debhelper (>> 7), linux-support-4.5.0-parrot, linux-headers-4.5.0-parrot-all
Package-List:
 linux-doc deb doc optional arch=all
 linux-headers-4kc-malta deb kernel optional arch=mips,mipsel
 linux-headers-586 deb oldlibs optional arch=i386
 linux-headers-5kc-malta deb kernel optional arch=mips,mips64,mips64el,mipsel
 linux-headers-686 deb kernel optional arch=i386
 linux-headers-686-pae deb kernel optional arch=i386
 linux-headers-alpha-generic deb kernel optional arch=alpha
 linux-headers-alpha-smp deb kernel optional arch=alpha
 linux-headers-amd64 deb kernel optional arch=amd64
 linux-headers-arm64 deb kernel optional arch=arm64
 linux-headers-armmp deb kernel optional arch=armhf
 linux-headers-armmp-lpae deb kernel optional arch=armhf
 linux-headers-kirkwood deb oldlibs optional arch=armel
 linux-headers-loongson-2e deb kernel optional arch=mipsel
 linux-headers-loongson-2f deb kernel optional arch=mipsel
 linux-headers-loongson-3 deb kernel optional arch=mips64el,mipsel
 linux-headers-m68k deb kernel optional arch=m68k
 linux-headers-marvell deb kernel optional arch=armel
 linux-headers-octeon deb kernel optional arch=mips,mips64,mips64el
 linux-headers-orion5x deb oldlibs optional arch=armel
 linux-headers-parisc deb kernel optional arch=hppa
 linux-headers-parisc64-smp deb kernel optional arch=hppa
 linux-headers-powerpc deb kernel optional arch=powerpc
 linux-headers-powerpc-smp deb kernel optional arch=powerpc
 linux-headers-powerpc64 deb kernel optional arch=powerpc,ppc64
 linux-headers-powerpc64le deb kernel optional arch=ppc64el
 linux-headers-powerpcspe deb kernel optional arch=powerpcspe
 linux-headers-s390x deb kernel optional arch=s390x
 linux-headers-sh7751r deb kernel optional arch=sh4
 linux-headers-sh7785lcr deb kernel optional arch=sh4
 linux-headers-sparc64 deb kernel optional arch=sparc64
 linux-headers-sparc64-smp deb kernel optional arch=sparc64
 linux-headers-versatile deb kernel optional arch=armel
 linux-image-4kc-malta deb kernel optional arch=mips,mipsel
 linux-image-586 deb oldlibs optional arch=i386
 linux-image-5kc-malta deb kernel optional arch=mips,mips64,mips64el,mipsel
 linux-image-686 deb kernel optional arch=i386
 linux-image-686-pae deb kernel optional arch=i386
 linux-image-686-pae-dbg deb kernel optional arch=i386
 linux-image-alpha-generic deb kernel optional arch=alpha
 linux-image-alpha-smp deb kernel optional arch=alpha
 linux-image-amd64 deb kernel optional arch=amd64
 linux-image-amd64-dbg deb kernel optional arch=amd64
 linux-image-arm64 deb kernel optional arch=arm64
 linux-image-arm64-dbg deb kernel optional arch=arm64
 linux-image-armmp deb kernel optional arch=armhf
 linux-image-armmp-lpae deb kernel optional arch=armhf
 linux-image-kirkwood deb oldlibs optional arch=armel
 linux-image-loongson-2e deb kernel optional arch=mipsel
 linux-image-loongson-2f deb kernel optional arch=mipsel
 linux-image-loongson-3 deb kernel optional arch=mips64el,mipsel
 linux-image-m68k deb kernel optional arch=m68k
 linux-image-marvell deb kernel optional arch=armel
 linux-image-octeon deb kernel optional arch=mips,mips64,mips64el
 linux-image-orion5x deb oldlibs optional arch=armel
 linux-image-parisc deb kernel optional arch=hppa
 linux-image-parisc64-smp deb kernel optional arch=hppa
 linux-image-powerpc deb kernel optional arch=powerpc
 linux-image-powerpc-smp deb kernel optional arch=powerpc
 linux-image-powerpc64 deb kernel optional arch=powerpc,ppc64
 linux-image-powerpc64le deb kernel optional arch=ppc64el
 linux-image-powerpcspe deb kernel optional arch=powerpcspe
 linux-image-s390x deb kernel optional arch=s390x
 linux-image-s390x-dbg deb kernel optional arch=s390x
 linux-image-sh7751r deb kernel optional arch=sh4
 linux-image-sh7785lcr deb kernel optional arch=sh4
 linux-image-sparc64 deb kernel optional arch=sparc64
 linux-image-sparc64-smp deb kernel optional arch=sparc64
 linux-image-versatile deb kernel optional arch=armel
 linux-perf deb kernel optional arch=all
 linux-source deb kernel optional arch=all
 linux-tools deb oldlibs optional arch=all
 xen-linux-system-amd64 deb kernel optional arch=amd64
Checksums-Sha1:
 3c99b5f5c3f7b52708aeb41f4e6e85df47bbca6a 21748 linux-latest_73+parrot1.tar.xz
Checksums-Sha256:
 fd83b4f0b8602814052d75c36a0b3e9481bf1246c83c740a9d5765496f3ba001 21748 linux-latest_73+parrot1.tar.xz
Files:
 d7ec582969dc8d78855baf0cf5fffdb0 21748 linux-latest_73+parrot1.tar.xz
