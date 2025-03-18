#vars
CC = cc
CFLAGS= -g -O2
LIBS-L./ -lprocess
OBJ = main.o input.o output.o

# target 
my_program: #(OBJ)
    $(CC) $(OBJ) -o my_program $(LIBS)
# rule
%.0 %.c
    $(CC) -c $(CFLAGS) $< -o $C
# clean 
clean:
    rm -f .o my_program 