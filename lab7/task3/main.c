//program calculates integrate of function (1-x*x)/x
//with standard FPU, and with SSE

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

extern unsigned long long myRDTSC();
extern unsigned int add1(unsigned int row, unsigned int col);

int** makeTable();
void deleteTable();
void fillTab(int val);
void printTab();
void incTabCols();
void incTabRows();

//const int N = 10;
int ROWS;
int COLS; 
int* tab;

double testForN(const int N);

int main(void) {

	int scale = 400;
	
	for(int i = 1; i < 10; i++) {
		printf("for N = %d, rows/cols=%f\n\n",
			i*scale, testForN(i*scale));
	}

	return 0;
}

double testForN(const int N) {
	ROWS = N;
	COLS = N;
	tab = malloc(ROWS*COLS*sizeof(int));
	fillTab(1);

	
	double rowsTime = 0;
	double colsTime = 0;
	int avg_n = 10;
	printf("rows:\n ");
	for(int i = 0; i < avg_n; i++) {
		unsigned long long tmp = myRDTSC();
		incTabRows();
		tmp = myRDTSC() - tmp;
		rowsTime += ((double)(tmp)/
					((double)(avg_n)));
		printf("%llu\n ", tmp);
	}
	
	printf("cols:\n ");
	for(int i = 0; i < avg_n; i++) {
		unsigned long long tmp = myRDTSC();
		incTabCols();
		tmp = myRDTSC() - tmp;
		colsTime += ((double)(tmp)/
					((double)(avg_n)));
		printf("%llu\n ", tmp);
	}

	double avgRow = rowsTime / (double)(ROWS*COLS);
	double avgCol = colsTime / (double)(ROWS*COLS);

	printf("avg per item rows: %f\n"
		"avg per item cols: %f\n",
		 avgRow, avgCol);
	free(tab);
	return avgRow/avgCol;
}

void incTabCols(){
	for(int i = 0; i < ROWS; i++)
		for(int j = 0; j < COLS; j++)
			tab[i*COLS + j]++;
}


void incTabRows(){
	for(int i = 0; i < ROWS; i++)
		for(int j = 0; j < COLS; j++)
			tab[j*COLS + i]++;
}

void fillTab(int val) {
	for(int i = 0; i < ROWS; i++)
		for(int j = 0; j < COLS; j++)
			tab[i*COLS + j] = val;
}

void printTab() {
	for(int i = 0; i < ROWS; i++) {
		for(int j = 0; j < COLS; j++)
			printf("%d ", tab[i*COLS+j]);
		puts("\n");
	}
}
