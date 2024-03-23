;;=============================================================
;;  CS 2110 - Spring 2024
;;  Homework 6 - GCD
;;=============================================================
;;  Name: Sreehitha Kalagara
;;============================================================

;;  In this file, you must implement the 'MOD' and 'GCD' subroutines.

.orig x3000
    ;; You do not need to write anything here
    LD R6, STACK_PTR

    ;; Pushes arguments A and B
    ADD R6, R6, -2
    LD R1, A
    STR R1, R6, 0
    LD R1, B
    STR R1, R6, 1 
    JSR GCD
    LDR R0, R6, 0
    ADD R6, R6, 3
    HALT

    STACK_PTR   .fill xF000
    ;; You can change these numbers for debugging!
    A           .fill 10
    B           .fill 4


;;  MOD Pseudocode (see PDF for explanation and examples)   
;;  
;;  MOD(int a, int b) {
;;      while (a >= b) {
;;          a -= b;
;;      }
;;      return a;
;;  }

MOD ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the MOD subroutine here!
    
    ADD R6, R6, -1 ;reserve space for return value
    ADD R6, R6, -1
    STR R7, R6, 0 ;store old return address
    ADD R6, R6, -1
    STR R5, R6, 0 ; store old frame pointer
    ADD R6, R6, -1 ; reserve space for local var (not needed)
    ADD R5, R6, 0 ; set R5 to R6 (pointing to first local)
    ; Store R0 - R4
    ADD R6, R6, -1
    STR R0, R6, 0
    ADD R6, R6, -1
    STR R1, R6, 0
    ADD R6, R6, -1
    STR R2, R6, 0
    ADD R6, R6, -1
    STR R3, R6, 0
    ADD R6, R6, -1
    STR R4, R6, 0
    
    ; MOD
    LDR R0, R5, 4 ; R0 = a
    LDR R1, R5, 5 ; R1 = b
    
    WHILE1
    NOT R2, R1
    ADD R2, R2, 1 ; R2 = -b
    ADD R2, R2, R0 ; R2 = a - b
    BRn END1
    ADD R0, R2, 0 ; R0 = a = a - b
    BR WHILE1
    END1
    
    ; Stack Teardown
    STR R0, R5, 3 ; store return value
    
    ; restore registers and pop off values
    LDR R0, R6, 4
    LDR R1, R6, 3
    LDR R2, R6, 2
    LDR R3, R6, 1
    LDR R4, R6, 0
    ADD R6, R6, 5
    
    ADD R6, R6, 1 ; pop local variable
    LDR R5, R6, 0 ; restore old frame pointer
    ADD R6, R6, 1 ; R6 -> return address
    LDR R7, R6, 0 ; restore old return address
    ADD R6, R6, 1 ; R6 -> return value
    RET


;;  GCD Pseudocode (see PDF for explanation and examples)
;;
;;  GCD(int a, int b) {
;;      if (b == 0) {
;;          return a;
;;      }
;;        
;;      while (b != 0) {
;;          int temp = b;
;;          b = MOD(a, b);
;;          a = temp;
;;      }
;;      return a;
;;  }

GCD ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the GCD subroutine here!
    
    ; Stack Buildup
    ADD R6, R6, -1 ; reserve space for return value
    ADD R6, R6, -1
    STR R7, R6, 0 ; store old return address
    ADD R6, R6, -1
    STR R5, R6, 0 ; store old frame pointer
    ADD R6, R6, -1 ; reserve space for local var (not needed)
    ADD R5, R6, 0 ; set R5 to R6 (pointing to first local)
    ; Store R0 - R4
    ADD R6, R6, -1
    STR R0, R6, 0
    ADD R6, R6, -1
    STR R1, R6, 0
    ADD R6, R6, -1
    STR R2, R6, 0
    ADD R6, R6, -1
    STR R3, R6, 0
    ADD R6, R6, -1
    STR R4, R6, 0
    
    ; GCD Functionality
    LDR R0, R5, 4 ; R0 = a
    LDR R1, R5, 5 ; R1 = b
    
    BRz RETURN ; first if statement
    
    WHILE
    ADD R1, R1, 0
    BRz ENDWHILE
    ADD R2, R1, 0 ; R2 = temp = b
    
    ; MOD call
    ADD R3, R6, 0 ; R3 = R6
    ADD R6, R6, -2 ; allocate space for args
    STR R0, R6, 0
    STR R1, R6, 1 
    JSR MOD
    LDR R1, R6, 0 ; b = MOD(a, b)
    ADD R6, R3, 0 ; R6 = R3 (resets R6 to what it was)
    
    ADD R0, R2, 0 ; a = temp
    BR WHILE
    ENDWHILE
    
    RETURN
    ; Stack Teardown
    STR R0, R5, 3 ; store return value
    
    ; restore registers and pop off values
    LDR R0, R6, 4
    LDR R1, R6, 3
    LDR R2, R6, 2
    LDR R3, R6, 1
    LDR R4, R6, 0
    ADD R6, R6, 5
    
    ADD R6, R6, 1 ; pop local variable
    LDR R5, R6, 0 ; restore old frame pointer
    ADD R6, R6, 1 ; R6 -> return address
    LDR R7, R6, 0 ; restore old return address
    ADD R6, R6, 1 ; R6 -> return value
    
    RET
    
    
.end