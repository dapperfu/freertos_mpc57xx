************************************************************************************
Freescale demo application for FreeRTOS v8.2.3 on Calypso3M
readme.txt
Freescale(TM) and the Freescale logo are trademarks of Freescale Semiconductor, Inc.
All other product or service names are the property of their respective owners.
(C) Freescale Semiconductor, Inc. 2015
************************************************************************************

This package contains a demo application for FreeRTOS V8.2.3 running on Calypso3M.

The sample application can be executed on the X-MPC574XG-MB board with 
X-MPC574XG-176DS daughter card.

To build the application use the makefile in the current folder.
To execute the application use the start.bat file in the T32_Calypso3M folder.

Calypso3M_running_board.jpg and Calypso3M_running_T32.png show the demo running 
on the board and the corresponding T32 debugger window.

The directory structure is as follows:

./:
    bin                                 ; contains the generated ELF and MAP files
    ld                                  ; gcc linker scripts
    src                                 ; generic source code
    src_hw                              ; hw specific source code
    Calypso3M_running_board.jpg         ; Calypso board running the demo app
    Calypso3M_running_T32.png           ; T32 debugger running the demo app
    makefile                            ; demo application make file
    readme.txt                          ; this file

./bin:
    demo_flash.elf                      ; ELF file that can be flashed to Calypso3M
    demo_flash.map                      ; generated MAP file
    
./ld:   
    demo_flash.ld                       ; demo linker script for GCC
    
./src:  
    FreeRTOSConfig.h                    ; FreeRTOS config file
    main.c                              ; main demo application file
    
./src_hw:                               ; hw specific source folde
    cbootstrap.c                        ; C bootstrap source code
    crt0.s                              ; startup code
    handlers.s                          ; hw interrupts handlers
    hw_base.h                           ; platform specific peripheral base addresses
    hw_clock.h                          ; platform specific clock support
    hw_flashrchw.c                      ; flash header
    hw_gpio.h                           ; gpio code
    hw_intc.h                           ; interrupt controller
    hw_pit.h                            ; PIT timer
    hw_platform.c                       ; platform specific code
    hw_platform.h                       ; platform specific header
    hw_typedefs.h                       ; hw specific typedefs
    hw_wdg.h                            ; watchdog code
    
./T32_Calypso3M:                        ; Trace32 folder
    5746c.cmm                           ; Calypso specific CMM file
    config.t32                          ; T32 support file
    flash.cmm                           ; CMM file to program flash
    start.bat                           ; BAT file to start the application

