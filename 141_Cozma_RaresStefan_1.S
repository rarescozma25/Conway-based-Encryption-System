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
contor:.long 0
nrbiti:.space 4
nrelemprelungire:.space 4
nrbitiparola:.space 4
nrelemmatr:.space 4
sum:.space 4
matrix:.zero 1600
matrixcpy:.zero 1600
formatScanf:.asciz "%d"
formatPrintf:.asciz "%d "
formatScanf_sir:.asciz "%s"
formatPrintf_sir:.asciz "%s"
formatPrintf_hex:.asciz "%02X"
formatPrintf_afisare:.asciz "0x"
formatPrintf_caracter:.asciz "%c"
endl:.asciz "\n"
lineIndex:.space 4
colIndex:.space 4
nrelem1:.space 4
nrelem2:.space 4
cheia:.space 4
parola:.space 100
l_parola:.space 4
.text
.global main
main:
push $mlines
push $formatScanf
call scanf
add $8,%esp
push $ncols
push $formatScanf
call scanf
add $8,%esp
push $p
push $formatScanf
call scanf
add $8,%esp
mov $matrix,%edi
mov $matrixcpy,%esi
mov $0,%ecx
et_p:
cmp p,%ecx
je citire_k
push %ecx
push $x
push $formatScanf
call scanf
add $8,%esp
push $y
push $formatScanf
call scanf
add $8,%esp
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
    call scanf
    add $8,%esp
movl mlines,%edx
movl %edx,nrelem1
incl nrelem1
incl nrelem1
movl ncols,%edx
movl %edx,nrelem2
incl nrelem2
incl nrelem2
citire_cheie:
push $cheia
push $formatScanf
call scanf
addl $8,%esp
citire_parola:
push $parola
push $formatScanf_sir
call scanf
add $8,%esp
mov $0,%ecx
mov $parola,%esi
mov $0,%edx
et_for:
movb (%esi,%ecx,1),%dl
cmpb $0,%dl
je atribuire_lungime
inc %ecx
jmp et_for
atribuire_lungime:
mov %ecx,l_parola
mov $matrixcpy,%esi
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
je et_compararecheie
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
et_compararecheie:
mov $matrixcpy,%esi
cmpl $0,cheia
je criptare
jmp decriptare
decriptare:
mov nrelem1,%eax
mull nrelem2
mov %eax,nrelemmatr
subl $2,l_parola
mov l_parola,%eax
mov $4,%ebx
mull %ebx
movl %eax,nrbitiparola
movl nrbitiparola,%eax
cmpl nrelemmatr,%eax
jg prelungire2
jmp et_xor2
prelungire2:
mov nrbitiparola,%eax
subl nrelemmatr,%eax
movl %eax,nrelemprelungire
movl nrelemmatr,%eax
movl $0,%ecx
et_for4:
cmp %ecx,nrelemprelungire
je et_xor2
mov (%esi,%ecx,4),%ebx
mov %ebx,(%esi,%eax,4)
inc %eax
inc %ecx
inc %ecx
cmp %ecx,nrelemmatr
je reinitializare2
dec %ecx
jmp et_for4
reinitializare2:
subl %ecx,nrelemprelungire
mov $0,%ecx
jmp et_for4
et_xor2:
movl $2,lineIndex
addl $2,l_parola
mov $parola,%edi
xor %eax,%eax
et_for5:
movl lineIndex,%ecx
cmp %ecx,l_parola
je et_exit
movb (%edi,%ecx,1),%ah
cmp $65,%ah
jge este_litera
jmp este_cifra
pentru_al:
shr $4,%eax
inc %ecx
movb (%edi,%ecx,1),%ah
dec %ecx
cmp $65,%ah
jge este_litera1
jmp este_cifra1
continuare:
movb %ah,%dl
add %edx,%eax
movb $0,%ah
movl $8,nrbiti
movl $0,colIndex
xor %edx,%edx
jmp et_for6
este_litera:
subb $55,%ah
jmp pentru_al
este_cifra:
subb $48,%ah
jmp pentru_al
este_litera1:
subb $55,%ah
jmp continuare
este_cifra1:
subb $48,%ah
jmp continuare
et_for6:
movl colIndex,%ecx
cmp %ecx,nrbiti
je afisare2
mov contor,%ecx
movl (%esi,%ecx,4),%ebx
shl %edx
xor %ebx,%edx
movl colIndex,%ecx
incl contor
incl colIndex
jmp et_for6
afisare2:
mov %edx,%ebx
xor %eax,%ebx
push %ebx
push $formatPrintf_caracter
call printf
addl $8,%esp
push $0
call fflush
addl $4,%esp
incl lineIndex
incl lineIndex
mov $parola,%edi
mov $matrixcpy,%esi
jmp et_for5
criptare:
mov nrelem1,%eax
mull nrelem2
mov %eax,nrelemmatr
mov l_parola,%eax
mov $8,%ebx
mull %ebx
movl %eax,nrbitiparola
mov nrbitiparola,%eax
cmpl nrelemmatr,%eax
jg prelungire
jmp et_xor
prelungire:
mov nrbitiparola,%eax
subl nrelemmatr,%eax
movl %eax,nrelemprelungire
movl nrelemmatr,%eax
movl $0,%ecx    
et_for1:
cmp %ecx,nrelemprelungire
je et_xor
mov (%esi,%ecx,4),%ebx
mov %ebx,(%esi,%eax,4)
inc %eax
inc %ecx
inc %ecx
cmp %ecx,nrelemmatr
je reinitializare
dec %ecx
jmp et_for1
reinitializare:
subl %ecx,nrelemprelungire
mov $0,%ecx
jmp et_for1
et_xor:
movl $0,lineIndex
push $formatPrintf_afisare
call printf
addl $4,%esp
mov $parola,%edi
et_for2:
movl lineIndex,%ecx
cmp %ecx,l_parola
je et_exit
movb (%edi,%ecx,1),%al
movl $8,nrbiti
movl $0,colIndex
xor %edx,%edx
et_for3:
movl colIndex,%ecx
cmp %ecx,nrbiti
je afisare
mov contor,%ecx
movl (%esi,%ecx,4),%ebx
shl %edx
xor %ebx,%edx
movl colIndex,%ecx
incl contor
incl colIndex
jmp et_for3
afisare:
mov %edx,%ebx
xor %eax,%ebx
push %ebx
push $formatPrintf_hex
call printf
addl $8,%esp
push $0
call fflush
addl $4,%esp
incl lineIndex
jmp et_for2
et_exit:
    pushl $0
    call fflush
    addl $4,%esp
    mov $1,%eax
    mov $0,%ebx
    int $0x80
