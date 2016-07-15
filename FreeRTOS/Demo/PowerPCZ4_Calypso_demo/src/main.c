/*==================================================================================================
*
*   (c) Copyright 2015 Freescale Semiconductor Inc.
*   
*   This program is free software; you can redistribute it and/or modify it under
*   the terms of the GNU General Public License (version 2) as published by the
*   Free Software Foundation >>>> AND MODIFIED BY <<<< the FreeRTOS exception.
*
*   ***************************************************************************
*   >>!   NOTE: The modification to the GPL is included to allow you to     !<<
*   >>!   distribute a combined work that includes FreeRTOS without being   !<<
*   >>!   obliged to provide the source code for proprietary components     !<<
*   >>!   outside of the FreeRTOS kernel.                                   !<<
*   ***************************************************************************
*
*   This program is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details.
*   
*   You should have received a copy of the GNU General Public License
*   along with this program; if not, write to the Free Software
*   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*
==================================================================================================*/

#include <sys/stat.h>

#include <stdarg.h>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "FreeRTOS.h"
#include "task.h"

#include "hw_platform.h"

#define mainLED_DELAY                        ( ( TickType_t ) 500 / portTICK_PERIOD_MS )
#define mainLED_TASK_PRIORITY                ( tskIDLE_PRIORITY + 2 )


void SystemInit(void);
void vLEDTask( void *pvParameters );

volatile int       test_init_data [1024] = {0x3333};  /**< should go to .data section  - testing only data to check compiler/linker/startupcode */
volatile const int test_init_small_data = 0x12345678; /**< should go to .sdata section - testing only small data to check compiler/linker/startupcode */


#if configUSE_TICK_HOOK > 0

void vApplicationTickHook(void);

volatile uint32_t ui32_ms_cnt = 0;

void vApplicationTickHook(void)
{
  // increments every 1ms if configCPU_CLOCK_HZ is set correctly
  ui32_ms_cnt++;   
}

#endif


volatile unsigned int TaskTick[16];

void vLEDTask( void *pvParameters )
{
    unsigned int ID = (unsigned int)pvParameters;
   
    for( ;; )
    {
        TaskTick[ID]++;
        
        /* Not very exiting - just delay... */
        vTaskDelay( mainLED_DELAY/(ID+1) );

        /* set the GIO pin to 1 */
        SetGPIO(ID);

        /* delay */
        vTaskDelay( mainLED_DELAY/((3-ID)+1) );

        /* clear the GIO pin */
        ClrGPIO(ID);
    }
}


int main( void )
{

    HWPeriphEnableAll();
    HWWatchdogDisable();

    InitGPIO(LED0);
    InitGPIO(LED1);
    InitGPIO(LED2);
    InitGPIO(LED3);
    
    OS_PlatformInit();
    
    xTaskCreate( vLEDTask, ( const char * const ) "LedTask", configMINIMAL_STACK_SIZE, (void*)0x0, mainLED_TASK_PRIORITY, NULL );
    xTaskCreate( vLEDTask, ( const char * const ) "LedTask", configMINIMAL_STACK_SIZE, (void*)0x1, mainLED_TASK_PRIORITY+1, NULL );
    xTaskCreate( vLEDTask, ( const char * const ) "LedTask", configMINIMAL_STACK_SIZE, (void*)0x2, mainLED_TASK_PRIORITY+2, NULL );
    xTaskCreate( vLEDTask, ( const char * const ) "LedTask", configMINIMAL_STACK_SIZE, (void*)0x3, mainLED_TASK_PRIORITY+3, NULL );

    // Start the scheduler.
    vTaskStartScheduler();

    // Will only get here if there was insufficient memory to create the idle
    // task.
    for( ;; );
}

