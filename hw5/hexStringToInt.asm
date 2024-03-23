;;=============================================================
;; CS 2110 - Spring 2024
;; Homework 5 - hexStringToInt
;;=============================================================
;; Name: 
;;=============================================================

;;  Suggested Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  String hexString = "F1ED";
;;  int length = mem[LENGTH];
;;  int value = 0;
;;  int i = 0;
;;  while (i < length) {
;;      int leftShifts = 4;
;;      while (leftShifts > 0) {
;;          value += value;
;;          leftShifts--;
;;      }
;;      if (hexString[i] >= 65) {
;;          value += hexString[i] - 55;
;;      } else {
;;          value += hexString[i] - 48;
;;      }
;;      i++;
;;  }
;;  mem[mem[RESULTADDR]] = value;

.orig x3000
    ;; YOUR CODE HERE
    LD R0, HEXSTRING ;; R0 = hexString
    ;; length = 4
    AND R1, R1, 0 ;; R1 = value = 0
    AND R2, R2, 0 ;; R2 = i = 0
    
    
    WHILE
    ADD R3, R2, -4 ;; i - length
    BRzp END ;; end outer loop
    LD R4, LENGTH
    
    WHILE2
    ADD R4, R4, 0
    BRnz END2 ;; end inner loop
    ADD R1, R1, R1
    ADD R4, R4, -1
    BR WHILE2
    END2
    
    
    
    ADD R5, R0, R2
    LDR R5, R5, 0 ;; R5 = hexString[i]
    
    
    LD R6, SIXTYFIVE ;; R6 = 65
    NOT R6, R6
    ADD R6, R6, 1 ;; R6 = -65
    ADD R6, R6, R5 ;; hexString[i] - 65
    
    BRn IF
    
    LD R6, ASCIICHAR ;; R6 = 55
    NOT R6, R6
    ADD R6, R6, 1 ;; R6 = -55
    ADD R6, R6, R5 ;; hexString[i] - 55
    ADD R1, R6, R1 ;; add to values
    
    BR ELSE
    IF
    
    LD R6, ASCIIDIG
    NOT R6, R6
    ADD R6, R6, 1 ;; R6 = -48
    ADD R6, R6, R5 ;; hexString[i] - 48
    ADD R1, R6, R1 ;; add to values
    
    ELSE
    
    ADD R2, R2, 1
    BR WHILE
    END
    
    STI R1, RESULTADDR
    
    HALT
    
;; Do not change these values!
ASCIIDIG        .fill 48
ASCIICHAR       .fill 55
SIXTYFIVE       .fill 65
HEXSTRING       .fill x5000
LENGTH          .fill 4
RESULTADDR      .fill x4000
.end

.orig x4000                    ;;Don't change the .orig statement
    ANSWER .blkw 1             ;;Do not change this value
.end


.orig x5000                    ;;  Don't change the .orig statement
    .stringz "F1ED"            ;;  You can change this string for debugging! Hex characters will be uppercase.
.end
