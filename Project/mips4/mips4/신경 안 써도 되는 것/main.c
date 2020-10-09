#include "xparameters.h"
#include <xil_io.h>
#include "xil_printf.h"

int main(void)
{
	xil_printf("Hello World\n\r");
	u32 temp, sw_reg;
	int i = 0;

	unsigned int x1, x2;
	while(1){
		if (i==100)
		{
			break;
		}
		//i++;
		sw_reg = Xil_In32(XPAR_MYIP_V1_0_0_BASEADDR+12); // sw
		x1 = sw_reg & 0x000F0;
		x2 = sw_reg % 16;


		temp = Xil_In32(XPAR_MYIP_V1_0_0_BASEADDR+8);
		//xil_printf("Hello World\n\r");
		xil_printf("%d * %d = %d\n\r",x1 >> 4, x2, temp);
		Xil_Out32(XPAR_MYIP_V1_0_0_BASEADDR,temp);
		for(i=0;i<9999999;i++);
	}
	return 0;
}
