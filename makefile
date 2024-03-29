.PHONY : all libdma.a app
all: libdma.a app dma.c dma.h app.c

libdma.a: dma.c dma.h
	gcc -Wall -g -c dma.c
	ar rcs libdma.a dma.o
app: app.c
	gcc -Wall -g -o app app.c -L. -ldma
clean:
	rm -fr *~ libdma.a dma.o app.o app
tar:
	tar czf ../21901779.tar.gz dma.c app.c makefile readme.txt dma.h report.pdf --ignore-failed-read

run: all
	./app
	make clean 

val: all
	valgrind -s --leak-check=full --show-leak-kinds=all --leak-resolution=high --track-origins=yes --vgdb=yes ./app
hel: all
	valgrind --tool=helgrind ./app
