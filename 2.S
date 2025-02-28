.data
mlines:.space 4
ncols:.space 4
p:.space 4
y:.space 4
x:.space 4
k:.space 4
s:.space 4
t:.space 4
i:.space 4
j:.space 4
pointer1:.space 4
pointer2:.space 4
rkey:.asciz "r"
wkey:.asciz "w"
fin:.asciz "in.txt"
fout:.asciz "out.txt"
sum:.space 4
matrix:.zero 1600
matrixcpy:.zero 1600
formatScanf:.asciz "%d"
formatPrintf:.asciz "%d "
endl:.asciz "\n"
lineIndex:.space 4
colIndex:.space 4
nrelem1:.space 4
nrelem2:.space 4
.text
.global main
main:
push $rkey
push $fin
call fopen
addl $8,%esp
movl %eax,pointer1
push $wkey
push $fout
call fopen
addl $8,%esp
movl %eax,pointer2
push $mlines
push $formatScanf
push pointer1
call fscanf
add $12,%esp
push $ncols
push $formatScanf
push pointer1
call fscanf
add $12,%esp
push $p
push $formatScanf
push pointer1
call fscanf
add $12,%esp
mov $matrix,%edi
mov $matrixcpy,%esi
mov $0,%ecx
et_p:
cmp p,%ecx
je citire_k
push %ecx
push $x
push $formatScanf
push pointer1
call fscanf
add $12,%esp
push $y
push $formatScanf
push pointer1
call fscanf
add $12,%esp
mov x,%eax
mull ncols
add y,%eax
movl $1,(%edi,%eax,4)
pop %ecx
inc %ecx
jmp et_p
citire_k:
    push $k
    push $formatScanf
    push pointer1
    call fscanf
    add $12,%esp
movl mlines,%edx
movl %edx,nrelem1
incl nrelem1
incl nrelem1
movl ncols,%edx
movl %edx,nrelem2
incl nrelem2
incl nrelem2
jmp et_mat2
et_mat2:
    movl $0,lineIndex
    movl $1,s
et_lines2:
    mov lineIndex,%ecx
    cmp mlines,%ecx
    je et_atribuirex
    movl $0,colIndex
    movl $1,t
et_cols2:
    mov colIndex,%ecx
    cmp ncols,%ecx
    je incrementare1
    mov lineIndex,%eax
    mull ncols
    add colIndex,%eax
    movl (%edi,%eax,4),%ebx
    movl s,%eax
    mull nrelem2
    addl t,%eax
    mov %ebx,(%esi,%eax,4)
    incl colIndex
    incl t
    jmp et_cols2
incrementare1:
    incl lineIndex
    incl s
    jmp et_lines2
et_atribuirex:
    movl $0,x
et_prelucrare:
movl x,%ecx
cmp k,%ecx
je et_afiarerezultat
movl $1,lineIndex
et_lines4:
    movl lineIndex,%ecx
    cmp mlines,%ecx
    jg et_copiere
    movl $1,colIndex
et_cols4:
    movl $0,sum
    movl colIndex,%ecx
    cmp ncols,%ecx
    jg incrementare2
    movl lineIndex,%eax
    mull nrelem2
    addl colIndex,%eax
    mov %eax,%ebx
    subl nrelem2,%ebx #deasupra
    mov (%esi,%ebx,4),%edx
    addl %edx,sum
    addl $1,%ebx
    mov (%esi,%ebx,4),%edx #dreapta sus
    addl %edx,sum
    subl $2,%ebx #stanga sus
    mov (%esi,%ebx,4),%edx
    addl %edx,sum
    mov %eax,%ebx
    sub $1,%ebx #stanga
    mov (%esi,%ebx,4),%edx
    addl %edx,sum
    addl $2,%ebx #dreapta
    mov (%esi,%ebx,4),%edx
    addl %edx,sum
    mov %eax,%ebx
    addl nrelem2,%ebx #dedesubt
    mov (%esi,%ebx,4),%edx
    addl %edx,sum
    subl $1,%ebx #stanga jos
    mov (%esi,%ebx,4),%edx
    addl %edx,sum
    addl $2,%ebx #dreapta jos
    mov (%esi,%ebx,4),%edx
    addl %edx,sum
    mov (%esi,%eax,4),%ebx
    cmp $1,%ebx
    je caz1
    jmp caz2
    caz1:
    cmpl $2,sum
    jl atribuire1
    cmpl $3,sum
    jg atribuire1
    jmp increment_col
    atribuire1:
    movl lineIndex,%eax
    subl $1,%eax
    mull ncols
    movl colIndex,%edx
    subl $1,%edx
    add %edx,%eax
    movl $0,(%edi,%eax,4)
    incl colIndex
    jmp et_cols4
    caz2:
    cmpl $3,sum
    je atribuire2
    incl colIndex
    jmp et_cols4
    atribuire2:
    movl lineIndex,%eax
    subl $1,%eax
    mull ncols
    movl colIndex,%edx
    subl $1,%edx
    add %edx,%eax
    movl $1,(%edi,%eax,4)
    incl colIndex
    jmp et_cols4
incrementare2:
incl lineIndex
jmp et_lines4
increment_col:
incl colIndex
jmp et_cols4
et_copiere:
    movl $0,i
    movl $1,s
et_lines5:
    mov i,%ecx
    cmp mlines,%ecx
    je incrementare_x
    movl $0,j
    movl $1,t
et_cols5:
    mov j,%ecx
    cmp ncols,%ecx
    je incrementare3
    mov i,%eax
    mull ncols
    addl j,%eax
    movl (%edi,%eax,4),%ebx
    movl s,%eax
    mull nrelem2
    addl t,%eax
    mov %ebx,(%esi,%eax,4)
    incl j
    incl t
    jmp et_cols5
incrementare3:
    incl i
    incl s
    jmp et_lines5
incrementare_x:
incl x
jmp et_prelucrare
et_afiarerezultat:
movl $0,lineIndex
et_linesfinal:
    mov lineIndex,%ecx
    cmp mlines,%ecx
    je et_exit
    movl $0,colIndex
et_colsfinal:
    mov colIndex,%ecx
    cmp ncols,%ecx
    je et_count_linesfinal
    mov lineIndex,%eax
    mull ncols
    add colIndex,%eax
    movl (%edi,%eax,4),%ebx
    push %ebx
    push $formatPrintf
    push pointer2
    call fprintf
    add $12,%esp
    incl colIndex
    jmp et_colsfinal
et_count_linesfinal:
    push $endl
    push pointer2
    call fprintf
    add $8,%esp
    incl lineIndex
    jmp et_linesfinal

et_exit:
    pushl $0
    call fflush
    addl $4,%esp
    mov $1,%eax
    mov $0,%ebx
    int $0x80
