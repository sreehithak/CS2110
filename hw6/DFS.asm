;;=============================================================
;;  CS 2110 - Spring 2024
;;  Homework 6 - DFS
;;=============================================================
;;  Name: Sreehitha Kalagara
;;============================================================

;;  In this file, you must implement the 'SET_VISITED', 'IS_VISITED', and 'DFS' subroutines.


.orig x3000
    ;; You do not need to write anything here
    LD R6, STACK_PTR

    ;; Pushes arguments (address of node 1, target node 5)
    ADD R6, R6, -1
    AND R1, R1, 0
    ADD R1, R1, 5
    STR R1, R6, 0
    ADD R6, R6, -1
    LD R1, STARTING_NODE_ADDRESS
    STR R1, R6, 0
    JSR DFS
    LDR R0, R6, 0
    ADD R6, R6, 3
    HALT

    STACK_PTR .fill xF000
    STARTING_NODE_ADDRESS .fill x6110
    VISITED_VECTOR_ADDR .fill x4199 ;; stores the address of the visited vector.

;;  SET_VISITED Pseudocode

;; Parameter: The address of the node
;; Updates the visited vector to mark the given node as visited

;;  SET_VISITED(addr node) {
;;      visited = mem[mem[VISITED_VECTOR_ADDR]];
;;      data = mem[node];
;;      mask = 1;
;;      while (data > 0) {
;;          mask = mask + mask;
;;          data--;
;;      }
;;      mem[mem[VISITED_VECTOR_ADDR]] = (visited | mask); //Hint: Use DeMorgan's Law!
;;  }

SET_VISITED ;; Do not change this label! Treat this as like the name of the function in a function header
;; Code your implementation for the SET_VISITED subroutine here!
    
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
    
    ;; SET_VISITED Functionality
    LDI R1, VISITED_VECTOR_ADDR ; R1 = visited
    AND R2, R2, 0 ; R2 = 0
    ADD R2, R2, 1 ; R2 = mask = 1
    LDR R0, R5, 4 ; R0 = node
    LDR R0, R0, 0 ; R0 = data
    
    WHILE1
    ADD R0, R0, 0
    BRnz END1
    ADD R2, R2, R2 ; R2 = mask = mask + mask
    ADD R0, R0, -1 ; data--
    BR WHILE1
    END1
    NOT R1, R1
    NOT R2, R2
    AND R1, R1, R2
    NOT R1, R1
    STI R1, VISITED_VECTOR_ADDR
    
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

;;  IS_VISITED Pseudocode

;; Parameter: The address of the node
;; Returns: 1 if the node has been visited, 0 if it has not been visited

;;  IS_VISITED(addr node) {
;;       visited = mem[mem[VISITED_VECTOR_ADDR]];
;;       data = mem[node];
;;       mask = 1;
;;       while (data > 0) {
;;           mask = mask + mask;
;;           data--;
;;       }
;;       return (visited & mask) != 0;
;;   }

IS_VISITED ;; Do not change this label! Treat this as like the name of the function in a function header
;; Code your implementation for the IS_VISITED subroutine here!
    
    ;; Stack Buildup
    ADD R6, R6, -1 ;reserve space for return value
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
    
    ;; IS_VISITED Functionality
    LDI R1, VISITED_VECTOR_ADDR ; R1 = visited
    AND R2, R2, 0 ; R2 = 0
    ADD R2, R2, 1 ; R2 = mask = 1
    LDR R0, R5, 4 ; R0 = node
    LDR R0, R0, 0 ; R0 = data
    
    WHILE5
    ADD R0, R0, 0
    BRnz END5
    ADD R2, R2, R2 ; R2 = mask = mask + mask
    ADD R0, R0, -1 ; data--
    BR WHILE5
    END5
    
    AND R2, R2, R1 ; visited & mask
    BRz NOTIF1
    AND R1, R1, 0
    ADD R1, R1, 1
    STR R1, R5, 3 ; Stores 1 as return value
    BR NOTELSE
    NOTIF1
    AND R1, R1, 0
    STR R1, R5, 3 ; Stores 0 as return value
    NOTELSE
    
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



;;  DFS Pseudocode (see PDF for explanation and examples)

;; Parameters: The address of the starting (or current) node, the data of the target node
;; Returns: the address of the node (if the node is found), 0 if the node is not found

;;  DFS(addr node, int target) {
;;        SET_VISITED(node);
;;        if (mem[node] == target) {
;;           return node;
;;        }
;;        result = 0;
;;        for (i = node + 1; mem[i] != 0 && result == 0; i++) {
;;            if (! IS_VISITED(mem[i])) {
;;                result = DFS(mem[i], target);
;;            }
;;        }       
;;        return result;
;;  }

DFS ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the DFS subroutine here!
    
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
    
    ;; DFS Functionality
    LDR R0, R5, 4 ; R0 = node ; 24848
    LDR R1, R5, 5 ; R1 = target ; 5
    
    ; calling SET_VISITED(node)
    ADD R3, R6, 0 ; saves R6 in R3
    ADD R6, R6, -1
    STR R0, R6, 0 ; pushes node onto stack
    JSR SET_VISITED
    ADD R6, R3, 0 ; restores R6 from R3
    
    ; first if statement
    LDR R3, R0, 0 ; R3 = mem[node]
    NOT R3, R3
    ADD R3, R3, 1 ; R3 = -mem[node]
    ADD R3, R3, R1 ; R3 = target - mem[node]
    BRnp NOTIF
    STR R0, R5, 3 ; stores node as return value
    BR RETURN
    NOTIF
    
    AND R2, R2, 0 ; R2 = result = 0
    
    ; for loop
    FOR
    ADD R0, R0, 1 ; i = node + 1
    LDR R4, R0, 0 ; mem[i]
    BRz END2
    ADD R2, R2, 0 ; R2 = result
    BRnp END2
    
    ; calling IS_VISITED(mem[i])
    ADD R3, R6, 0 ; saves R6 in R3
    ADD R6, R6, -1
    STR R4, R6, 0 ; pushes mem[i] onto stack
    JSR IS_VISITED
    LDR R3, R6, 0 ; R3 = returned value
    ADD R6, R6, 2 ; restores R6 from R3
    ADD R3, R3, 0 ; R3
    
    BRnp IF5
    ; calling DFS(mem[i], target)
    ADD R3, R6, 0 ; saves R6 in R3
    ADD R6, R6, -1
    STR R1, R6, 0
    ADD R6, R6, -1
    STR R4, R6, 0 ; pushes mem[i] onto stack
    JSR DFS
    LDR R2, R6, 0 ; R2 = result = returned value
    ADD R6, R3, 0 ; restores R6 from R3
    IF5
    
    BR FOR
    END2
    STR R2, R5, 3 ; stores result as return value
    
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

;; Assuming the graphs starting node (1) is at address x6100, here's how the graph (see below and in the PDF) is represented in memory
;;
;;         0      3
;;          \   / | \
;;            4   1 - 2 
;;             \ /    |
;;              5  -  6
;;

.orig x4199
    .fill 0 ;; visited set will be at address x4199, initialized to 0
.end

.orig x6110         ;; node 1 itself lives here at x6110
    .fill 1         ;; node.data (1)
    .fill x6120     ;; node 2 lives at this address
    .fill x6130     ;; node 3 lives at this address
    .fill x6150     ;; node 5 lives at this address   
    .fill 0
.end

.orig x6120	        ;; node 2 itself lives here at x6120
    .fill 2         ;; node.data (2)
    .fill x6110     ;; node 1 lives at this address
    .fill x6130     ;; node 3 lives at this address
    .fill x6160     ;; node 6 lives at this address
    .fill 0
.end

.orig x6130	        ;; node 3 itself lives here at x6130
    .fill 3         ;; node.data (3)
    .fill x6110     ;; node 1 lives at this address
    .fill x6120     ;; node 2 lives at this address
    .fill x6140     ;; node 4 lives at this address
    .fill 0
.end

.orig x6140	        ;; node 4 itself lives here at x6140
    .fill 4         ;; node.data (4)
    .fill x6100     ;; node 0 lives at this address
    .fill x6130     ;; node 3 lives at this address
    .fill x6150     ;; node 5 lives at this address
    .fill 0
.end

.orig x6100         ;; node 0 itself lives here at x6000
    .fill 0         ;; node.data (0)
    .fill x6140     ;; node 4 lives at this address
    .fill 0
.end

.orig x6150	        ;; node 5 itself lives here at x6150
    .fill 5         ;; node.data (5)
    .fill x6110     ;; node 1 lives at this address
    .fill x6140     ;; node 4 lives at this address
    .fill x6160     ;; node 6 lives at this address
    .fill 0
.end

.orig x6160	        ;; node 6 itself lives here at x6160
    .fill 6         ;; node.data (6)
    .fill x6120     ;; node 2 lives at this address
    .fill x6150     ;; node 5 lives at this address
    .fill 0
.end