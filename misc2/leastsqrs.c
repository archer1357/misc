
#include <stdio.h>
#include <stdlib.h>

void leastSquaresLine(const double *xs,const double *ys, int n,
                      double *gradient,double *intercept) {


  int i;
  double sumX,sumX2,sumY,sumXY,nn;
  double m,b;

  sumX=0.0;
  sumX2=0.0;
  sumY=0.0;
  sumXY=0.0;
  nn=(double)n;

  for(i=0;i<n;i++) {
    sumX+=xs[i];
    sumX2+=xs[i]*xs[i];
    sumY+=ys[i];
    sumXY+=xs[i]*ys[i];
  }

  // www.efunda.com/math/leastsquares/lstsqr1dcurve.cfm
  m=(nn*sumXY-sumX*sumY)/(nn*sumX2-sumX*sumX);
  // b=(sumY*sumX2-sumX*sumXY)/(nn*sumX2-sumX*sumX);

  // youtu.be/1pawL_5QYxE
  b=(sumY-m*sumX)/nn;

  //
  *gradient=m;
  *intercept=b;
}

void testLeastSquaresLine() {
  printf("test1:\n");

  double xs[10],ys[10];
  int i;
  for(i=0;i<10;i++) {
    double x=(double)i;
    double y=0.0;//(double)(rand()%7-2);

    xs[i]=x;
    ys[i]=y;

    printf("(%g,%g) ",x,y);
  }

  printf("\n");

  double gradient,intercept;
  leastSquaresLine(xs,ys,10,&gradient,&intercept);

  printf("m=%g,b=%g\n",gradient,intercept);

  printf("\n");
}

void testLeastSquaresLine2() {
  printf("test2:\n");

  double xs[7],ys[7];

  xs[0]=0.0;
  xs[1]=2.0;
  xs[2]=4.0;
  xs[3]=6.0;
  xs[4]=8.0;
  xs[5]=10.0;
  xs[6]=12.0;

  ys[0]=-0.8;
  ys[1]=-1.0;
  ys[2]=-0.2;
  ys[3]=0.2;
  ys[4]=-2.0;
  ys[5]=0.8;
  ys[6]=-0.6;

  int i;
  for(i=0;i<7;i++) {
    printf("(%g,%g) ",xs[i],ys[i]);
  }
  printf("\n");

  double gradient,intercept;
  leastSquaresLine(xs,ys,7,&gradient,&intercept);

  printf("m=%g,b=%g\n",gradient,intercept);

  printf("\n");
}

int main() {
  testLeastSquaresLine();
  testLeastSquaresLine2();
  return 0;
}