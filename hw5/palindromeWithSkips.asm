;;=============================================================
;; CS 2110 - Spring 2024
;; Homework 5 - palindromeWithSkips
;;=============================================================
;; Name:
;;=============================================================

;;  NOTE: Let's decide to represent "true" as a 1 in memory and "false" as a 0 in memory.
;;
;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  String str = "aibohphobia";
;;  char skipChar = mem[mem[CHARADDR]];
;;  int length = 0;
;;  while (str[length] != '\0') {
;;		length++;
;;	}
;; 	
;;	int left = 0;
;;  int right = length - 1;
;;  boolean isPalindrome = true;
;;  while(left < right) {
;;      if (str[left] == skipChar) {
;;          left++;
;;          continue;
;;      }
;;      if (str[right] == skipChar) {
;;          right--;
;;          continue;
;;      }
;;		if (str[left] != str[right]) {
;;			isPalindrome = false;
;;          break;
;;		}
;;
;;		left++;
;;		right--;
;;	}
;;	mem[mem[ANSWERADDR]] = isPalindrome;

.orig x3000
	;; YOUR CODE HERE
	LD R0, STRING ;; R0 = str = address of STRING
	LDI R1, CHARADDR ;; R1 = skipChar
	AND R2, R2, 0 ;; R2 = length = 0
	
	WHILE1
	ADD R3, R0, R2 ;; R3 = address with STRING + length 
	LDR R3, R3, 0 ;; R3 = str[length]
	BRz END1 ;; str[length] != 0 
	ADD R2, R2, 1
	BR WHILE1
	END1
	
	;; no longer need R3
	AND R3, R3, 0 ;; R3 = left = 0
	ADD R2, R2, -1 ;; R2 = right = length - 1
	AND R4, R4, 0
	ADD R4, R4, 1 ;; R4 = isPalindrome = true (0+1)
	
	WHILE2
	NOT R5, R2
	ADD R5, R5, 1 ;; R5 = -right
	ADD R5, R5, R3 ;; R5 = left - right
	BRzp END2
	
	;; don't need R5, so use for conditionals
	
	ADD R5, R0, R3 ;; R5 = address with STRING + left
	LDR R5, R5, 0 ;; R5 = str[left]
	NOT R6, R5
	ADD R6, R6, 1 ;; R6 = -str[left]
	ADD R6, R6, R1 ;; R6 = skipChar - str[left]
	BRnp IF1
	ADD R3, R3, 1 ;; R3 = left++
	BR WHILE2
	IF1
	
	
	ADD R6, R0, R2 ;; R6 = address with STRING + right
	LDR R6, R6, 0 ;; R6 = str[right]
	NOT R7, R6
	ADD R7, R7, 1 ;; R7 = -str[right]
	ADD R7, R7, R1 ;; R5 = skipChar - str[right]
	BRnp IF2
	ADD R2, R2, -1 ;; R2 = right--
	BR WHILE2
	IF2
	
	NOT R5, R5
	ADD R5, R5, 1 ;; R5 = -str[left]
	ADD R5, R5, R6 ;; R5 = str[right] - str[left]
	BRz IF3
	ADD R4, R4, -1
	BR END2
	IF3
	
	
	ADD R3, R3, 1 ;; left++
	ADD R2, R2, -1 ;; right--
	BR WHILE2
	END2
	
	STI R4, ANSWERADDR
	HALT

;; Do not change these values!
CHARADDR    .fill x4004
STRING	    .fill x4019
ANSWERADDR 	.fill x5005
.end

;; Do not change any of the .orig lines!

.orig x4004
    .stringz "b"           ;;Feel free to change this char for debugging
.end

.orig x4019				   
	.stringz "af" ;; Feel free to change this string for debugging.
.end

.orig x5005
	ANSWER  .blkw 1        ;;Do not change this value
.end