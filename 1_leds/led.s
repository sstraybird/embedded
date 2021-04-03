.global _start  /*全局标号 */

_start:
    /*1.使能所有时钟 */
    ldr r0,=0x020C4068      /*将0x020c4068加载到R0中,0x020c4068为寄存器CCGR0的地址 */
    ldr r1,=0xFFFFFFFF      
    str r1,[r0]             /*将R1中的值写入到r0所保存的地址中 */

    ldr r0,=0X020C406c      /*CCGR1 */
    str r1,[r0]

    ldr r0,=0X020C4070      /*CCGR2 */
    str r1,[r0]

    ldr r0,=0X020C4074      /*CCGR3 */
    str r1,[r0]

    ldr r0,=0X020C4078      /*CCGR4 */
    str r1,[r0]

    ldr r0,=0X020C407C      /*CCGR5 */
    str r1,[r0]

    ldr r0,=0x020c4080      /*CCGR6 */
    str r1,[r0]

    /*2、设置GPIO1_IO03复用为GPIO1_IO03 */
    ldr r0, =0X020E0068     /*将寄存器SW_MUX_GPIO1_IO03_BASE加载到r0中 */
    ldr r1, =0x5            /* 设置寄存器SW_MUX_GPIO1_IO03_BASE的MUX_MODE为5 */
    str r1,[r0]         

    /*3、设置GPIO1_IO03的IO属性
        *bit 16:0 HYS关闭
        *bit [15:14]: 00 默认下拉
        *bit [13]: 0 kepper功能
        *bit [12]: 1 pull/keeper使能
        *bit [11]: 0 关闭开路输出
        *bit [7:6]: 10 速度100Mhz
        *bit [5:3]: 110 R0/6驱动能力
        *bit [0]: 0 低转换率
    */
    ldr r0, =0X020E02F4 /*寄存器SW_PAD_GPIO1_IO03_BASE */
    ldr r1, =0X10B0
    str r1,[r0]

    /* 4、设置GPIO1_IO03为输出 */
    ldr r0, =0X0209C004         /*寄存器GPIO1_GDIR */
    ldr r1, =0X0000008
    str r1,[r0]

    /*5、打开LED0
     * 设置GPIO1_IO03输出低电平
    */
    ldr r0, =0X0209C000 /*寄存器GPIO1_DR */
    ldr r1, =0
    str r1,[r0]

    /*
     * 描述： loop死循环      
     */
     loop:
        b loop
        