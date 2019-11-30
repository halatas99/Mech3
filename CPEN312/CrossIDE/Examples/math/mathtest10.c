/*  mathtest.c: Test floating point functions

    Copyright (C) 2001-2012  Jesus Calvino-Fraga, jesusc@ece.ubc.ca 

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA */

/* Version 1.0 - Initial release */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <DE2_8052.h>

// ~C51~  --model-small

//The DE2-8052 softcore clock is 33.33MHz
#define CLK 33333333L
#define BAUD 115200L
#define TIMER_2_RELOAD (0x10000L-(CLK/(32L*BAUD)))
#define LOW(X)  (X%0x100)
#define HIGH(X) (X/0x100)

void main (void)
{
	float x, y, z, ysin, ycos;
	int i=2;
	int j;
	int expo;
	float mant;
	union float_long xx;
	data char ci;
	
	code char * code fstr[]=
	{"", "0.0", "1.0", "-1.0", "3.1416", "-31416e-4",
     "   -0.031416e2", "\t0.031416E+2", "1e4", "000001.0000", 
     "-0.27e-7", "x"  };

	RCAP2H=HIGH(TIMER_2_RELOAD);
	RCAP2L=LOW(TIMER_2_RELOAD);
	T2CON=0x34; // #00110100B
	SCON=0x52; // Serial port in mode 1, ren, txrdy, rxempty
	LEDRA=0;
	LEDRB=0;
	LEDRC=0;
	LEDG=0;

    printf("Built %s, %s\n", __DATE__, __TIME__);
    
	puts("\n*** Testing atof ***");
	for(j=0; fstr[j][0]!='x'; j++)
	{
		x=atof(fstr[j]);
		printf("%s=%14.10f\n", fstr[j], x);
	}

	xx.f=1001.0;
	printf("\n0x%08x=", xx.l);
	printf("%11.8f\n", xx.f);
	
	puts("\n*** Testing frexp ***");
	x=1000.0;
	mant=frexpf(x, &expo);
	printf("%11.8f=%11.8f*(2^%d)\n", x, mant, expo);

	puts("\n*** Testing ldexp ***");
	y=ldexpf(mant, expo);
	printf("%11.8f*(2^%d)=%11.8f\n", mant, expo, y);

	puts("\n*** Testing sqrt(x) ****");

	for(ci=0; ci<100; ci++)
	{
		sqrtf(0.1*ci);
	}

	for(i=0; i<10; i++)
	{
		x=i;
		y=sqrtf(x);
		printf("%5.2f %11.8f\n", x, y);
	}

	puts("\n*** Testing log(x) and log10(x) ***");
	for(i=1; i<20; i++)
	{
		x=i*4.0;
		printf("%6.2f %11.8f %11.8f\n", x, logf(x), log10f(x));
	}
	printf("%6.4f %11.8f %11.8f\n", 45.67, logf(45.67), log10f(45.67));

	
	puts("\n*** Testing exp(x) ***");
	for(i=1; i<15; i++)
	{
		x=i*4.0;
		printf("%6.2f %11.8f\n", x, expf(x));
	}

	puts("\n*** Testing pow(x) ***");
	for(i=0; i<20; i++)
	{
		x=i*2.976545;
		y=powf(x, 2.0);
		printf("(%5.2f)^2= %11.8f\n", x, y);
	}

	puts("\n*** Testing sin(x) and cos(x) ***");
	puts("    Please wait...");

	for(i=0; i<35; i++)
	{
		//A few checkpoint values...
		     if(i==31) x=1.57079633;
		else if(i==32) x=0.78539816;
		else if(i==33) x=3.14159265;
		else if(i==34) x=6.28318531;
		else x=i*0.2;

		ysin=sinf(x);
		ycos=cosf(x);

		printf("%5.2f %11.8f %11.8f\n", x, ysin, ycos);
	}

	puts("\n*** Testing tan(x) and cot(x) ***");
	for(i=0; i<35; i++)
	{
		x=i*0.2;
		printf("%5.2f %12.8f %12.8f\n", x, tanf(x), cotf(x));
	}

	puts("\n*** Testing asin(x) and acos(x) ***");
	for(i=-10; i<11; i++)
	{
		x=i*0.1;
		printf("%5.2f %12.8f %12.8f\n", x, asinf(x), acosf(x));
	}

	puts("\n*** Testing atan(x) ***");
	for(i=-10; i<11; i++)
	{
		x=i*0.5;
		printf("%5.2f %12.8f\n", x, atanf(x));
	}

	puts("\n*** Testing atan2(x) ***");
	printf("atan( 1.0,  1.0)=%12.8f\n", atan2f( 1.0,  1.0));
	printf("atan(-1.0,  1.0)=%12.8f\n", atan2f(-1.0,  1.0));
	printf("atan(-1.0, -1.0)=%12.8f\n", atan2f(-1.0, -1.0));
	printf("atan( 1.0, -1.0)=%12.8f\n", atan2f( 1.0, -1.0));

	puts("\n*** Testing sinh(x) and cosh(x) ***");
	for(i=0; i<16; i++)
	{
		x=i*0.5;
		printf("%5.2f %12.8f %12.8f\n", x, sinhf(x), coshf(x));
	}
			
	puts("\n*** Testing tanh(x) ***");
	for(i=0; i<22; i++)
	{
		x=i*0.5;
		printf("%5.2f %12.8f\n", x, tanhf(x));
	}
	
	puts("\n*** Testing exp(x) ***");
	for(i=0; i<20; i++)
	{
		x=i*(-1.0/10.0);
		printf("%5.2f %12.8f\n", x, expf(x));
	}

	puts("\n*** Testing floor(x), ceil(x), and modf(x) ***");
	puts("x     int   frc   floor  ceil");
	for(i=-10; i<11; i++)
	{
		x=i*0.33;
		z=modff(x, &y);
		printf("%5.2f %5.2f %5.2f %5.2f %5.2f\n",
		        x, y, z, floorf(x), ceilf(x));
	}
	puts("\nTest completed.");

}
