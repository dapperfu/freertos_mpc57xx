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

/* Scheduler include files. */
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"

/* Standard demo includes. */
#include "TimerDemo.h"
#include "QueueOverwrite.h"
#include "EventGroupsDemo.h"
#include "TaskNotify.h"
#include "IntSemTest.h"

#include "hw_platform.h"

#define mainLED_DELAY                        ( ( TickType_t ) 500 / portTICK_PERIOD_MS )
#define mainLED_TASK_PRIORITY                ( tskIDLE_PRIORITY )


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
  
  /* The full demo includes a software timer demo/test that requires
  prodding periodically from the tick interrupt. */
  vTimerPeriodicISRTests();

  /* Call the periodic queue overwrite from ISR demo. */
  vQueueOverwritePeriodicISRDemo();

  /* Call the periodic event group from ISR demo. */
  vPeriodicEventGroupsProcessing();

  /* Use task notifications from an interrupt. */
  xNotifyTaskFromISR();

  /* Use mutexes from interrupts. */
  vInterruptSemaphorePeriodicTest();
}

#endif

void vLEDTask( void *pvParameters )
{
    unsigned int ID = (unsigned int)pvParameters;
   
    for( ;; )
    {   
        /* Not very exiting - just delay... */
        vTaskDelay( ( 5000UL / portTICK_PERIOD_MS ) );

        /* set the GIO pin to 1 */
        SetGPIO(ID);

        /* delay */
        vTaskDelay( ( 5000UL / portTICK_PERIOD_MS ) );

        /* clear the GIO pin */
        ClrGPIO(ID);
    }
}

extern void main_full( void );

int main( void )
{

    HWPeriphEnableAll();
    HWWatchdogDisable();

    InitGPIO(LED0);
    
    OS_PlatformInit();
    
    xTaskCreate( vLEDTask, ( const char * const ) "LedTask", configMINIMAL_STACK_SIZE, (void*)0x0, mainLED_TASK_PRIORITY, NULL );

	main_full();
	/* Start the scheduler. */
    vTaskStartScheduler();
    // Will only get here if there was insufficient memory to create the idle
    // task.
    for( ;; );
}

