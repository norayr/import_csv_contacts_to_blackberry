INC = /usr/include/barry18

all: clean libbarrywrapper libbarrywrapper_voc test link
all0: libbarrywrapper libbarrywrapper_voc test link

run: 
	LD_LIBRARY_PATH=".:" ./test

debug:
	LD_LIBRARY_PATH=".:" ddd ./test

addcontact:
	 g++ -g -O0 -I $(INC) -lbarry -o addcontact addcontact.cc

libbarrywrapper:
	#g++ -shared -Wl,-soname,libbarrywrapper.so -fPIC -g -O0 -I $(INC) -lbarry -o libbarrywrapper.so barrywrapper.c
	g++ -fPIC -g -O0 -I $(INC) -lbarry -c barrywrapper.c
	g++ -shared -Wl,-soname,libbarrywrapper.so -FPIC -g -lbarry -o libbarrywrapper.so barrywrapper.o

libbarrywrapper_voc:
	CFLAGS="-fPIC -lbarrywrapper -L. -I. -I $(INC)" voc -sc blackberry.Mod

test:
	CFLAGS="-I." voc -cm test.Mod

link:
	gcc -lbarrywrapper -L. -fPIC -g -I "/opt/voc/2/include" -L"/opt/voc/lib" -lvoc-O2  -o test test.o blackberry.o libbarrywrapper.so

clean:
		rm *.o
		rm blackberry.c
		rm blackberry.h
		rm blackberry.sym
		rm libbarrywrapper.so
		rm test.c
		rm test

