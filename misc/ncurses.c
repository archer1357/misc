
#include <ncurses.h>
#include <stdio.h>
int main() {
  printf("aaa");

  initscr(); //start
  printw("Hello World !!!"); //print
  refresh(); //to screen
  getch(); //get input
  endwin(); //end

  return 0;
}
