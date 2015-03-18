ENTRY(main)
MEMORY
{
  FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 128K
  RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 1024K

}

SECTIONS
{
	.text :
	{
		KEEP(*(.isr_vector))
 		*(.text)
 		*(.text.*)
		*(.rodata*)
		_sromfs = .;
                *(.rom*)
		_eromfs = .;
		_sidata = .;
	} >FLASH


	.ARM.exidx : 
	{	
		__exidx_start = .;
		*(.ARM.exidx*)
		__exidx_end = .;
	} >RAM

	/* Initialized data will initially be loaded in FLASH at the end of the .text section. */
    .data : AT (_sidata) 
    {
		_sdata = .;
		*(.data)		/* Initialized data */
		_edata = .;
	} >RAM

	.bss : {
		_sbss = .;
		*(.bss)         /* Zero-filled run time allocate data memory */
		_ebss = .;
	} >RAM
    
    _estack = ORIGIN(RAM) + LENGTH(RAM);
 }  
