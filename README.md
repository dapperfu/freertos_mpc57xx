# MPC57xx FreeRTOS 9.0 

This is a modified version of 

- [Download S32 Design Studio for Power v1.1 for Linux](http://www.nxp.com/products/automotive-products/microcontrollers-and-processors/arm-mcus-and-mpus/s32-processors-microcontrollers/s32-design-studio-ide:S32DS?tab=Design_Tools_Tab)
- Install to /opt/Freescale/S32_Power_v1.1

Clone this repository to ``/opt/Freescale/freertos``

    git clone https://github.com/jed-frey/freertos_mpc57xx.git /opt/Freescale/freertos
    
To compile, change to the MPC57xx Demo directory ```/opt/Freescale/freertos/FreeRTOS/Demo/MPC57xx``` and build for your desired target.

    
    
    make PLATFORM=mpc5746c

    make PLATFORM=mpc5748g
