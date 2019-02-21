/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xgpio.h"


uint32_t const LED_MASK = 0x0000000F;
unsigned int const LED_CHANNEL = 1;

int main()
{
    init_platform();

    print("Hello World\n\r");

    XGpio_Config * psGpioCfg_test = XGpio_LookupConfig(XPAR_AXI_GPIO_0_DEVICE_ID);
    XGpio_Config * psGpioCfg_out = XGpio_LookupConfig(XPAR_AXI_GPIO_1_DEVICE_ID);
    XGpio_Config * psGpioCfg_in = XGpio_LookupConfig(XPAR_AXI_GPIO_2_DEVICE_ID);
    XGpio sGpio_test;
    XGpio sGpio_out;
    XGpio sGpio_in;

    if (!psGpioCfg_test)
    {
    	print("GPIO test Config not found.\r\n");
    	return 1;
    }
    if (!psGpioCfg_out)
    {
    	print("GPIO out Config not found.\r\n");
    	return 1;
    }
    if (!psGpioCfg_in)
    {
    	print("GPIO in Config not found.\r\n");
    	return 1;
    }
    if (XST_SUCCESS != XGpio_CfgInitialize(&sGpio_test, psGpioCfg_test, psGpioCfg_test->BaseAddress))
    {
    	print("GPIO Driver failed to initialize.\r\n");
    	return 1;
    }
    if (XST_SUCCESS != XGpio_CfgInitialize(&sGpio_out, psGpioCfg_out, psGpioCfg_out->BaseAddress))
    {
    	print("GPIO Driver failed to initialize.\r\n");
    	return 1;
    }
    if (XST_SUCCESS != XGpio_CfgInitialize(&sGpio_in, psGpioCfg_in, psGpioCfg_in->BaseAddress))
    {
    	print("GPIO Driver failed to initialize.\r\n");
    	return 1;
    }

	u32 InputData = 0;

	//InputData = XGpio_DiscreteRead(&sGpio_in, LED_CHANNEL);
	s32 test = XGpioPs_SelfTest(&sGpio_test);
	s32 in = XGpioPs_SelfTest(&sGpio_in);
	s32 out = XGpioPs_SelfTest(&sGpio_out);
	//InputData = XGpioPs_ReadPin(&sGpio_in, 0x00000001);

	printf("Data read from GPIO Input is  0x%x \n\r", (int)InputData);


    //XGpio_SetDataDirection(&sGpio, LED_CHANNEL, 0x00000000); //All input
    //XGpio_SetDataDirection(&sGpio, LED_CHANNEL, ~LED_MASK); //LEDS output
    //XGpio_DiscreteWrite(&sGpio, LED_CHANNEL, 0x0000000A);

    cleanup_platform();
    return 0;
}
