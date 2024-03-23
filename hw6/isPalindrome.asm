;;=============================================================
;;  CS 2110 - Spring 2024
;;  Homework 6 - isPalindrome
;;=============================================================
;;  Name: Sreehitha Kalagara
;;============================================================

;;  In this file, you must implement the 'isPalindrome' subroutine.
;; open -n -a LC3Tools
 

.orig x3000
    ;; You do not need to write anything here
    LD R6, STACK_PTR

    ;; Pushes arguments (word addr and len)
    ADD R6, R6, -2
    LEA R0, STRING
    LD R1, LENGTH
    STR R0, R6, 0
    STR R1, R6, 1
    JSR IS_PALINDROME
    LDR R0, R6, 0
    ADD R6, R6, 3
    HALT
    STACK_PTR .fill xF000
    LENGTH .fill 3                 ;; Change this to be length of STRING
    STRING .stringz "aba"	       ;; You can change this string for debugging!


;;  IS_PALINDROME **RECURSIVE** Pseudocode
;;
;;  isPalindrome(word (addr), len) { 
;;      if (len == 0 || len == 1) {
;;          return 1;
;;      } else {
;;          if (word[0] == word[len - 1]) {
;;              return IS_PALINDROME(word + 1, len - 2);
;;          } else { 
;;              return 0;
;;          }
;;      }
;;  }
;;
IS_PALINDROME ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the isPalindrome subroutine here!
    ;; NOTE: Your implementation MUST be done recursively
    ;; Stack Buildup
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
    
    ;; isPalindrome functionality
    LDR R0, R5, 4 ; R0 = addr of string
    LDR R1, R5, 5 ; R1 = len
    
    BRnp IF11 ; if len == 0 branch to IF1
    AND R0, R0, 0
    ADD R0, R0, 1
    STR R0, R5, 3 ; store 1 as the return value
    BR RETURN
    IF11
    
    ADD R2, R1, -1 ; R2 = len - 1
    BRnp IF12 ; if len == 1 branch to IF1
    AND R0, R0, 0
    ADD R0, R0, 1
    STR R0, R5, 3 ; store 1 as the return value
    BR RETURN
    IF12

    ADD R2, R2, R0 ; len - 1 + string
    LDR R2, R2, 0 ; R2 = string[len - 1]
    LDR R3, R0, 0 ; R3 = string[0]
    NOT R2, R2
    ADD R2, R2, 1 ; R2 = -string[len - 1]
    ADD R2, R2, R3 ; R2 = string[0] - string[len - 1]
    BRnp IF2
    
    ADD R0, R0, 1 ; string + 1
    ADD R1, R1, -2 ; len - 2
    ADD R3, R6, 0 ; R3 = R6
    ADD R6, R6, -2 ; allocate space for args
    STR R0, R6, 0 ; push string argument
    STR R1, R6, 1 ; push len argument
    JSR IS_PALINDROME
    LDR R2, R6, 0 ; R1 = IS_PALINDROME(string + 1, len - 2)
    STR R2, R5, 3 ; store IS_PALINDROME(string + 1, len - 2) as return value
    ADD R6, R3, 0
    BR RETURN
    
    IF2
    AND R2, R0, 0
    STR R2, R5, 3 ; store 0 as the return value
    
    RETURN
    ;; Stack Teardown ***without storing return value
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