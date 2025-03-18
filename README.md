# Практична робота 1 - звіт
### Варіант №3

## Умова завдання:
Припустимо, у вас є програма на C, що складається з кількох файлів:
 - main.c
 -input.c
 - output.c
 - process1 (бібліотека у /usr/lib)
- process (бібліотека у ~/mylibs)

Створив відповідні файли з простим вмістом:

```bash
$ cat main.c
```
```c
#include <stdio.h>
#include "input.h" 
#include "output.h"

int main() {
    int x = get_input();
    print_output(x); 
    return 0;
}
```

```bash
$ cat input.c
```
```c
#include <stdio.h>

int get_input() {
    int x:
    printf("Enter a number: ");
    scanf("%d", &x);
    return x
}
```

```bash
$ cat output.c
```
```c
#include <stdio.h>

void print_output(int x) {
    printf("You entered: %d\n", x);
}
```

## Завдання:

1. Написати команду компіляції з використанням gcc.
2. Змінити команду, щоб програма використовувала process1 із /usr/lib.
3. Змінити команду, щоб програма використовувала process із домашнього каталогу.
4. Додати прапорці для генерації налагоджувальної інформації (-g) і перевірки продуктивності (-O2).
5. Створити статичну (.a) і динамічну (.so) версії бібліотек process1 і process та перевірити різницю у виконанні. 
6. Використовуйте Makefile для автоматизації процесу компіляції.
7. Додайте до Makefile ціль clean, яка видаляє .o файли та виконуваний файл.
8. Напишіть CMakeLists.txt для збирання програми за допомогою CMake.


## Виконання завдань:
1. gcc -o my_program main.c input.c output.c

```
$ cc -o my_program main.c input.c output.c
$ cd project/ 
$ ls
> input.c input.h main.c my_program output.c output.h
$ cc -o my_program main.c input.c output.c
$ ./my_program
> Enter a number: 4
> You entered: 4
```

2. Створив за рута бібліотеку process1:

```
# cc -c process1.c -o process1.0
# ar rcs libprocess1.a process1.0
# mv libprocess1.a /usr/lib
# cc -shared -o libprocess1.so process1.0
# cc -fPIC -c process1.c -o 
# cc -shared -o libprocess1.so process1.0 
# mv libprocess1.so /usr/lib
# exit
```

Після цього використав бібліотеку у коді і рекомпілював програму за користувача:

```bash
$ cat main.c
```

```c
#include <stdio.h>
#include "input.h" #include "output.h"
extern void process1_function();
int main() {
    int x = get_input();
    print_output(x); 
    process1_function(); 
    return 0;
}
```

```
$ cc -o my_program main.c input.c output.c -L/usr/lib -lprocess1
$ ./my_program
> Enter a number: 4
> You entered: 4
> Hello from process1
```

3. Створив теку ~/mylibs.
У ній зробив бібліотеку process яка майже ідентична process1.
Скомпілював:

```
$ cc -o my_program main.c input.c output.c "/myl ibs/libprocess.a -L/usr.lib -lprocess1
$ ./my_program
> Enter a number: 5
> You entered: 5
> Hello from process1
> Hello from homedir process!
```
4. Добавив прапорці для генерації налагоджувальної інформації (-g) і перевірки продуктивності (-O2):

```
$ cc -g -O2 -o my_program main.c input.c output. c ~/mylibs/libprocess.a -L/usr.lib -lprocess1
$ ./my_program
> Enter a number: 5
> You entered: 5
> Hello from process1
> Hello from homedir process!
$ ls
> input.c main.c input.h my_program output.c output.h
```

5. Створив статичну (.a) і динамічну (.so) версії бібліотек process1 уже в попередніх завданнях, переходжу до наступного кроку.

6. Використав Makefile для автоматизації процесу компіляції.

```bash
cat Makefile
```
```makefile
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
```

7. Додав до Makefile ціль clean, яка видаляє .o файли та виконуваний файл.

```bash
cat Makefile
```
```makefile
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
```

8. Написав CMakeLists.txt для збирання програми через CMake.

```bash
cat CMakeLists.txt
```
```makefile
# minimum
cmake_minimum_required(VERSION 3.10)
# name
project (MyProgram)
# source
add_executable(my_program main.c input.c output.c)
# specify libs
target_link_libraries (my_program PRIVATE process)
# enable debug and optimization
set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O2")
```

Building:

```
$ mkdir build 
$ make
> `my_program' is up to date.
$ ls 
> CMakeLists.txt build Makefile input.c input.h main.c my_program output.h output.c
$ ./my_program
> Enter a number: 2
> You entered: 2
> Hello from process1
> Hello from homedir process!
```

