all:
	gcc -Wall main.c utf8.c -o test_utf8
clean:
	rm test_utf8

