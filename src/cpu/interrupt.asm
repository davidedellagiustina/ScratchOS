; @desc     Interrupt definitions
; @author   Davide Della Giustina
; @date     31/12/2019

[bits 32]
[extern isr_handler] ; Defined in isr.c

isr_common_stub:
    ; 1) Save the CPU state
    pusha ; Push edi, esi, ebp, esp, ebx, edx, ecx, eax
    mov ax, ds
    push eax ; Save data segment descriptor
    mov ax, 0x10 ; Kernel data segment descriptor
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    ; 2) Call C handler
    call isr_handler
    ; 3) Restore state
    pop eax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    popa
    add esp, 8 ; Clean up the pushed error code and ISR number
    sti
    iret ; Pops cs, eip, eflags, ss, esp

global isr0
global isr1
global isr2
global isr3
global isr4
global isr5
global isr6
global isr7
global isr8
global isr9
global isr10
global isr11
global isr12
global isr13
global isr14
global isr15
global isr16
global isr17
global isr18
global isr19
global isr20
global isr21
global isr22
global isr23
global isr24
global isr25
global isr26
global isr27
global isr28
global isr29
global isr30
global isr31

; ISR 0: Divide By Zero Exception
isr0:
    cli
    push byte 0 ; Err code
    push byte 0 ; Err no
    jmp isr_common_stub

; ISR 1: Debug Exception
isr1:
    cli
    push byte 0
    push byte 1
    jmp isr_common_stub

; ISR 2: Non Maskable Interrupt Exception
isr2:
    cli
    push byte 0
    push byte 2
    jmp isr_common_stub

; ISR 3: Breakpoint Exception
isr3:
    cli
    push byte 0
    push byte 3
    jmp isr_common_stub

; ISR 4: Into Detected Overflow Exception
isr4:
    cli
    push byte 0
    push byte 4
    jmp isr_common_stub

; ISR 5: Out Of Bounds Exception
isr5:
    cli
    push byte 0
    push byte 5
    jmp isr_common_stub

; ISR 6: Invalid Opcode Exception
isr6:
    cli
    push byte 0
    push byte 6
    jmp isr_common_stub

; ISR 7: No Coprocessor Exception
isr7:
    cli
    push byte 0
    push byte 7
    jmp isr_common_stub

; ISR 8: Double Fault Exception (with error code)
isr8:
    cli
    push byte 8
    jmp isr_common_stub

; ISR 9: Coprocessor Segment Overrun Exception
isr9:
    cli
    push byte 0
    push byte 9
    jmp isr_common_stub

; ISR 10: Bas TSS Exception (with error code)
isr10:
    cli
    push byte 10
    jmp isr_common_stub

; ISR 11: Segment Not Present Exception (with error code)
isr11:
    cli
    push byte 11
    jmp isr_common_stub

; ISR 12: Stack Fault Exception (with error code)
isr12:
    cli
    push byte 12
    jmp isr_common_stub

; ISR 13: General Protection Fault Exception (with error code)
isr13:
    cli
    push byte 13
    jmp isr_common_stub

; ISR 14: Page Fault Exception (with error code)
isr14:
    cli
    push byte 14
    jmp isr_common_stub

; ISR 15: Unknown Interrupt Exception
isr15:
    cli
    push byte 0
    push byte 15
    jmp isr_common_stub

; ISR 16: Coprocessor Fault Exception
isr16:
    cli
    push byte 0
    push byte 16
    jmp isr_common_stub

; ISR 17: Alignment Check Exception
isr17:
    cli
    push byte 0
    push byte 17
    jmp isr_common_stub

; ISR 18: Machine Check Exception
isr18:
    cli
    push byte 0
    push byte 18
    jmp isr_common_stub

; ISR 19: Reserved Exception
isr19:
    cli
    push byte 0
    push byte 19
    jmp isr_common_stub

; ISR 20: Reserved Exception
isr20:
    cli
    push byte 0
    push byte 20
    jmp isr_common_stub

; ISR 21: Reserved Exception
isr21:
    cli
    push byte 0
    push byte 21
    jmp isr_common_stub

; ISR 22: Reserved Exception
isr22:
    cli
    push byte 0
    push byte 22
    jmp isr_common_stub

; ISR 23: Reserved Exception
isr23:
    cli
    push byte 0
    push byte 23
    jmp isr_common_stub

; ISR 24: Reserved Exception
isr24:
    cli
    push byte 0
    push byte 24
    jmp isr_common_stub

; ISR 25: Reserved Exception
isr25:
    cli
    push byte 0
    push byte 25
    jmp isr_common_stub

; ISR 26: Reserved Exception
isr26:
    cli
    push byte 0
    push byte 26
    jmp isr_common_stub

; ISR 27: Reserved Exception
isr27:
    cli
    push byte 0
    push byte 27
    jmp isr_common_stub

; ISR 28: Reserved Exception
isr28:
    cli
    push byte 0
    push byte 28
    jmp isr_common_stub

; ISR 29: Reserved Exception
isr29:
    cli
    push byte 0
    push byte 29
    jmp isr_common_stub

; ISR 30: Reserved Exception
isr30:
    cli
    push byte 0
    push byte 30
    jmp isr_common_stub

; ISR 31: Reserved Exception
isr31:
    cli
    push byte 0
    push byte 31
    jmp isr_common_stub