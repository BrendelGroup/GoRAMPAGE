++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## GoRAMPAGE - system wide installation of required software

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

##### README
Sources and installation notes (current as of September 13, 2016)

Our recommendation is to install the required programs system-wide.
Typical would be to run the installation steps as superuser after
_"cd /usr/local/src"_.  Even better might be to create a directory
_/usr/local/src/GoRAMPAGE_ and install the programs there; this might
avoid clashes with other programs you are running that possibly
depend on earlier versions of the same packages.

Sources of the programs are listed.  Please see the cited URLs for
details on the software and installation.

Unless otherwise indicated, it is assumed that you download the software from
the given URL into your ~/Downloads directory.

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#fastq-multx
```bash
	git clone https://github.com/brwnj/fastq-multx.git
	cd fastq-multx/
	make
	cp fastq-multx /usr/local/bin/
	cd ..
```

#fastx_toolkit
```bash
	dnf install libgtextutils libgtextutils-devel
	git clone https://github.com/agordon/fastx_toolkit.git
	cd fastx_toolkit/
	./reconf
	./configure
	make
	make install
	cd  ..
```

#TagDust
from https://sourceforge.net/projects/tagdust/
```bash
	mkdir TagDust
	cd TagDust 
	cp ~/Downloads/tagdust-2.33.tar.gz  ./
	tar -xzf tagdust-2.33.tar.gz 
	cd tagdust-2.33/
	./configure
	make
	make check
	make install
	cd ../..
```

#STAR
```bash
	git clone https://github.com/alexdobin/STAR.git
	cd STAR
	cd source
	make STAR
	cp STAR /usr/local/bin
	cd ../..
```

#SAMTOOLS
```bash
	mkdir SAMTOOLS
	cd SAMTOOLS
	git clone git://github.com/samtools/htslib.git htslib
	cd htslib
	make
	cd ..
	git clone git://github.com/samtools/samtools.git samtools
	cd samtools
	make
	cp samtools /usr/local/bin
	cd ../..
```


GoRAMPAGE
```
	git clone https://github.com/brendelgroup/GoRAMPAGE.git
```

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
