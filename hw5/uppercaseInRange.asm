;;=============================================================
;; CS 2110 - Spring 2024
;; Homework 5 - uppercaseInRange 
;;=============================================================
;; Name: 
;;=============================================================

;;  Suggested Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  String strl = "touppERcase";
;;  int start = mem[START];
;;  int end = mem[END];
;;  int length = mem[LENGTH];
;;  if (end > length) {
;;      end = length;
;;  }
;;
;;  for (int x = start; x < end; x++) {
;;      if (str[x] >= 'a') {
;;          str[x] = str[x] - 32;
;;      }
;;  }

;; to index a string: LDR and offset is string index


.orig x3000
    ;; YOUR CODE HERE
    LD R1, STRING ;; R1 = str = touppERcase
    LD R2, START ;; R2 = start
    LD R3, END ;; R3 = end
    LD R4, LENGTH ;; R4 = length
    
    NOT R5, R4
    ADD R5, R5, 1 ;; R5 = -length
    ADD R5, R5, R3 ;; R5 = R3 - R4 = end - length
    BRnz ELSE
    AND R3, R3, 0
    ADD R3, R4, 0 ;; end = length
    ELSE
    
    
    LD R6, ASCII_A ;; R6 = 'a'
    ;; R2 = x = start
    ;; R4 (length) no longer needed
    ;; R5 (end - length) not needed
    
    FORLOOP
    NOT R4, R3
    ADD R4, R4, 1
    ADD R4, R4, R2 ;; x - end
    BRzp DONE
    
    
    ;; can change R4
    ADD R4, R1, R2
    LDR R5, R4, 0
    
    NOT R0, R5
    ADD R0, R0, 1
    ADD R0, R0, R6 ;; R6 - R7 = a - str[x]
    BRp NO ;; str[x] >= 'a'
    
    ADD R5, R5, -16
    ADD R5, R5, -16
    STR R5, R4, 0
    
    NO
    
    
    ADD R2, R2, 1
    BR FORLOOP
    DONE
    HALT

;; Do not change these values!
STRING          .fill x5000
ASCII_A         .fill 97

;; You can change these numbers for debugging!
LENGTH          .fill 11
START           .fill 2
END             .fill 9

.end

.orig x5000                    ;;  Don't change the .orig statement
    .stringz "touppERcase"     ;;  You can change this string for debugging!
.end
