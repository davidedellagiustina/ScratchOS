; @desc     Basic two-stages boot sector: load kernel from disk, switch to protected mode, enable paging, relocate kernel and transfer control to it
; @author   Davide Della Giustina
; @date     14/11/2019

[org 0x7c00]

KERNEL_OFFSET equ 0x3500
SECOND_STAGE_BOOTLOADER equ 0x1000

[bits 16]

jmp init

%include "src/boot/lib/16bit/print.asm"
%include "src/boot/lib/16bit/println.asm"
%include "src/boot/lib/16bit/hexprint.asm"
%include "src/boot/lib/16bit/loaddisk.asm"
%include "src/boot/gdt.asm"
%include "src/boot/lib/32bit/print.asm"

[bits 16] ; Real mode code

; Initialization
init:
    mov [BOOT_DRIVE], dl ; Boot drive number is stored by the BIOS, so save it
    mov bp, 0x9000 ; Stack
    mov sp, bp
    mov bx, BOOTING_OS_MSG ; Boot message
    call print
    call load_second_stage ; Load second stage bootloader
    call load_kernel ; Load kernel into memory
    call switch_to_pm ; Switch to protected mode

; Load and call second stage bootloader that will enable paging and relocate the kernel code
load_second_stage:
    mov al, 0x02 ; Start sector: sector 0x01 is this bootsector itself
    mov bx, SECOND_STAGE_BOOTLOADER
    mov dh, SECOND_STAGE_BL_SECTORS_SIZE ; Defined by assembler at compile-time
    mov dl, [BOOT_DRIVE]
    call loaddisk
    ret

; Load kernel into memory
load_kernel:
    mov al, 0x02
    add al, SECOND_STAGE_BL_SECTORS_SIZE
    mov bx, KERNEL_OFFSET
    mov dh, KERNEL_SECTORS_SIZE ; This variable is defined by the assembler at compile-time
    mov dl, [BOOT_DRIVE]
    call loaddisk
    ret

; Switch to protected mode
switch_to_pm:
    cli ; Must stop receiving interrupts, will be re-enabled later
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    jmp CODE_SEG:pm_init ; Long jump (i.e. other segment)

[bits 32] ; Protected mode code

; Protected mode initialization
pm_init:
    mov ax, DATA_SEG ; Segment registers
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ebp, 0x90000 ; Stack
    mov esp, ebp
    call main

; Main routine
main:
    call SECOND_STAGE_BOOTLOADER ; Enable paging and relocate kernel
    call KERNEL_OFFSET ; Transfer control to kernel
    jmp $ ; We should never get back here

BOOT_DRIVE: db 0
BOOTING_OS_MSG: db 'Booting OwlOs...', 0

times 510-($-$$) db 0 ; Padding to 1 whole sector (512B)
dw 0xaa55 ; Magic number