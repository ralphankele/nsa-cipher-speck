CXX = gcc
CXXFLAGS = -c -Wall -g
LDFLAGS =
SOURCES = $(wildcard *.c)
OBJECTS = ${SOURCES:.c=.o}
TITLE = speck
ARCHIVE = $(TITLE).tar.gz

.PHONY : all clean valgrind archive

all: $(TITLE)

$(TITLE) : $(OBJECTS)
	$(CXX) $(LDFLAGS) -o $@ $(OBJECTS)

%.o : %.c 
	$(CXX) $(CXXFLAGS) -o $@ $< -MMD -MF ./$@.d

clean :
	rm -f *.o *.gch $(TITLE) *.d
  
valgrind : $(TITLE)
	valgrind --tool=memcheck --leak-check=yes ./$< $(P0) $(P1)

archive :
	tar cfz $(ARCHIVE) *.cpp *.h *.pdf $(TITLE)

-include $(wildcard ./*.d)
