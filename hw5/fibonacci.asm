;;=============================================================
;; CS 2110 - Spring 2024
;; Homework 5 - Fibonacci
;;=============================================================
;; Name: Sreehitha Kalagara
;;=============================================================


;; Suggested Pseudocode (see PDF for explanation)
;;
;; n = mem[N];
;; resAddr = mem[RESULT]
;; 
;; if (n == 1) {
;;     mem[resAddr] = 0;
;; } else if (n > 1) {
;;     mem[resAddr] = 0;
;;     mem[resAddr + 1] = 1;
;;     for (i = 2; i < n; i++) {
;;         x = mem[resAddr + i - 1];
;;         y = mem[resAddr + i - 2];
;;         mem[resAddr + i] = x + y;
;;     }
;; }

.orig x3000
    ;; YOUR CODE HERE
    LD R1, N ;; R1 = n
    LD R2, RESULT
    ADD R3, R1, -1
    BRnp ELSEIF
    STR R3, R2, 0
    BR NEITHER
    ELSEIF
    ADD R3, R1, -1
    BRnz NEITHER
    AND R3, R3, 0
    STR R3, R2, 0
    ADD R3, R3, 1
    STR R3, R2, 1
    ;;for loop
    AND R4, R4, 0
    ADD R4, R4, 2 ;; R4 = i = 2
    FORLOOP
    NOT R5, R4
    ADD R5, R5, 1
    ADD R5, R5, R1 ;; R5 = n - i
    BRnz NEITHER
    ADD R6, R2, R4
    LDR R6, R6, -1
    ADD R7, R2, R4
    LDR R7, R7, -2
    ADD R5, R2, R4
    ADD R6, R6, R7
    STR R6, R5, 0
    ADD R4, R4, 1
    BR FORLOOP
    NEITHER
    HALT

;; Do not rename or remove any existing labels
;; You may change the value of N for debugging
N       .fill 5
RESULT  .fill x4000
.end

.orig x4000
.blkw 100
.end