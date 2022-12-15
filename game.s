name "Tic Tac Toe"
org 100h
 
 .DATA
 
    grid db '1','2','3'  ; defining the 2D array grid
         db '4','5','6'
         db '7','8','9'
         
    player db ?  
    
    
    welcomeMsg db 'Welcome to Tic Tac Toe! $' ; terminator is the dollar sign   
    inputMsg db 'Enter Position Number, Player Turn is: $'
    draw db 'Draw! $'
    won db 'Player Won: $'  
    
 .CODE
    main:
         
        mov cx,9              ; looping 9 times because the maximum number of inputs in a tic tac toe game is 9 (cx from 9 to 1)
        x:   
            call clearScreen  ; clears the console from the previous loop to look nicer
            call printWelcomeMsg
            call printGrid
             
            
            mov bx, cx
            and bx, 1       ; anding bx with 1, if the result is 0 its even if its 1 its odd
            cmp bx, 0
            je isEven       ; jmp if cx is even (equal 0) 
            mov player,'x'  ; if odd its x player turn
            jmp endif
            isEven:
            mov player,'o'  ; if even its o player turn
            endif:
            
            notValid:
            call printNewLine
            call printInputMsg
            call readInput ; al holds the position on the grid ( 1 => 9 )
            
            push cx
            mov cx, 9
            mov bx, 0           ; loop on the grid to find the position (bx is used as an index to access the grid, cant use cx for that)
            y:
            cmp grid[bx],al     ; check if the grid position is equal to the position taken from the user
            je update           ; if true update position with player (x or o), if false do nothing, continue the loop
            jmp continue
            update:
            mov dl,player       ; moving player to dl because we cant mov memory to memory
            mov grid[bx],dl  
            continue:
            inc bx
            loop y
            pop cx
            call checkwin        
        loop x           
        
    
        call printDraw   ; if we exit the loop and no one won, then its draw
        
        programEnd:   
        
        mov     ah, 0    ; wait for any key interupt
        int     16h      
    ret              ; %%%%%%%%%%%%%%%%% final return in main that CLOSES THE PROGRAM and returns to operating system %%%%%%%%%%%%%%%%%% 
    
           
        
        
        ; Procedures/Functions:
        
        printGrid:
            push cx      ; pushing and popping cx before and after the function because cx is used in a loop where the function is called
            mov bx,0
            mov cx,3
            x1:
                call printNewLine 
                push cx          ; push cx to stack to maintain the index of the first loop
                mov cx, 3
                x2:
                    mov dl, grid[bx]  
                    sub al, 30h  ; to convert ascii to char 
                    mov ah, 2h   ; print character interupt is 2
                    int 21h
                    call printSpace              
                    inc bx       ; increment bx to move the index the next element (from 0 to 8)
                loop x2
                pop cx           ; pop cx from stack to get the index of the first loop             
            loop x1
            pop cx
            call printNewLine                        
        ret 
        
        printNewLine:
            mov dl, 0ah      ; new line in ascii 
            mov ah, 2        
            int 21h
            mov dl, 13       ; carriage return in ascii 
            mov ah, 2        
            int 21h
        ret 
        
        printSpace:
            mov dl, 32       ; space in ascii 
            mov ah, 2         
            int 21h
        ret
        
        readInput:
           mov ah, 1 ; 1 for input, the value is in al
           int 21h
           
           cmp al,'1'
           je valid
           cmp al,'2'
           je valid
           cmp al,'3'
           je valid
           cmp al,'4'
           je valid
           cmp al,'5'
           je valid
           cmp al,'6'
           je valid
           cmp al,'7'
           je valid
           cmp al,'8'
           je valid
           cmp al,'9'
           je valid
           jmp notValid
           valid:        
        ret
        
       printWelcomeMsg:
            lea dx, welcomeMsg  ; load offset of welcome msg into dl.
            mov ah, 9           ; print string interupt is 9  
            int 21h
        ret
        
       printDraw:
            call printNewLine
            lea dx, draw  
            mov ah, 9             
            int 21h
        ret
        
       printWon:   
            call printNewLine
            call printGrid ; print grid one last time to show how the player won
            lea dx, won  
            mov ah, 9             
            int 21h
            mov dl, player 
            sub al, 30h   
            mov ah, 2h  
            int 21h
            jmp programEnd
        ret   
        
        printInputMsg:
            lea dx, inputMsg    ; load offset of welcome msg into dl.
            mov ah, 9           ; print string interupt is 9  
            int 21h
            mov dl, player      ; print current player 
            sub al, 30h   
            mov ah, 2h  
            int 21h 
            call printSpace
        ret
        
        checkWin:
            mov bl, grid[0]
            cmp bl, grid[1]              
            jne skip1      ;skip if not true and check the other possible wins, keep repeating that for all 8 possible wins
            cmp bl, grid[2]  
            jne skip1 
            call printWon
            skip1:
            
            mov bl, grid[3]
            cmp bl, grid[4]              
            jne skip2  
            cmp bl, grid[5]  
            jne skip2
            call printWon
            skip2: 
            
            mov bl, grid[6]
            cmp bl, grid[7]              
            jne skip3  
            cmp bl, grid[8]  
            jne skip3
            call printWon
            skip3: 
            
            mov bl, grid[0]
            cmp bl, grid[3]              
            jne skip4  
            cmp bl, grid[6]  
            jne skip4
            call printWon
            skip4:   
            
            mov bl, grid[1]
            cmp bl, grid[4]              
            jne skip5  
            cmp bl, grid[7]  
            jne skip5
            call printWon
            skip5:
            
            mov bl, grid[2]
            cmp bl, grid[5]              
            jne skip6  
            cmp bl, grid[8]  
            jne skip6
            call printWon
            skip6:
            
            mov bl, grid[0]
            cmp bl, grid[4]              
            jne skip7  
            cmp bl, grid[8]  
            jne skip7
            call printWon
            skip7:
            
            mov bl, grid[2]
            cmp bl, grid[4]              
            jne skip8  
            cmp bl, grid[6]  
            jne skip8
            call printWon
            skip8:             
        ret
        
        clearScreen:
            mov ax, 3   ; clears the screen in ascii
            int 10h
        ret    
    end main 
