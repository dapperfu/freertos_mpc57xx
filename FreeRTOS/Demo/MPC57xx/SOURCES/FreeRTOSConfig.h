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
#ifndef FREERTOS_CONFIG_H
#define FREERTOS_CONFIG_H

/*-----------------------------------------------------------
 * Application specific definitions.
 *
 * These definitions should be adjusted for your particular hardware and
 * application requirements.
 *
 * THESE PARAMETERS ARE DESCRIBED WITHIN THE 'CONFIGURATION' SECTION OF THE
 * FreeRTOS API DOCUMENTATION AVAILABLE ON THE FreeRTOS.org WEB SITE. 
 *
 * See http://www.freertos.org/a00110.html.
 *----------------------------------------------------------*/

#define configUSE_PREEMPTION                        1
#define configUSE_IDLE_HOOK                         0
#define configUSE_TICK_HOOK                         1

/* 
 * tune this to the actual frequency used by the system timer periperal
 * after reset with no PLL programming
 * - Z4 is running at 16MHz
 * - PIT channels running on the F40 clock at 4MHz
 */
#define configCPU_CLOCK_HZ                         ((unsigned portLONG ) 4000000 )
#define configTICK_RATE_HZ                         ((TickType_t) 1000 )

#define configMAX_PRIORITIES                       ( 7 )
#define configMINIMAL_STACK_SIZE                   ((unsigned portSHORT ) 256)
#define configTOTAL_HEAP_SIZE                      ((size_t) (150 * 1024) )
#define configMAX_TASK_NAME_LEN                    ( 13 )
#define configUSE_TRACE_FACILITY                    0
#define configUSE_16_BIT_TICKS                      0
#define configIDLE_SHOULD_YIELD                     1
#define configUSE_MUTEXES                           1
#define configUSE_RECURSIVE_MUTEXES                 1
#define configUSE_COUNTING_SEMAPHORES               1
#define configCHECK_FOR_STACK_OVERFLOW              0
#define configUSE_APPLICATION_TASK_TAG              0
#define configUSE_FPU                               0

/* Software timer definitions. */
#define configUSE_TIMERS						1
#define configTIMER_TASK_PRIORITY				( (configMAX_PRIORITIES) - 1 )
#define configTIMER_QUEUE_LENGTH				5
#define configTIMER_TASK_STACK_DEPTH			( configMINIMAL_STACK_SIZE * 2 )



/* Calypso specific: pit channel to use 0-15 */
#define configUSE_PIT_CHANNEL                     15


/* Co-routine definitions. */
#define configUSE_CO_ROUTINES                     0
#define configMAX_CO_ROUTINE_PRIORITIES         ( 4 )

/* Set the following definitions to 1 to include the API function, or zero
to exclude the API function. */
#define INCLUDE_vTaskPrioritySet                  1
#define INCLUDE_uxTaskPriorityGet                 1
#define INCLUDE_vTaskDelete                       1
#define INCLUDE_vTaskCleanUpResources             1
#define INCLUDE_vTaskSuspend                      1
#define INCLUDE_vResumeFromISR                    1
#define INCLUDE_vTaskDelayUntil                   1
#define INCLUDE_vTaskDelay                        1
#define INCLUDE_xTaskGetSchedulerState            0
#define INCLUDE_xTaskGetCurrentTaskHandle         1
#define INCLUDE_uxTaskGetStackHighWaterMark       0
#define INCLUDE_eTaskGetState                     1
#define INCLUDE_xTimerPendFunctionCall            1
#define configMAX_API_CALL_INTERRUPT_PRIORITY     8

#endif /* FREERTOS_CONFIG_H */


