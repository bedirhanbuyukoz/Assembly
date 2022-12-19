.data #tüm veri yapıları, veri bölümüne girer
    str1: .asciiz "Bedirhan " #yazdırılacak dizge
    str2: .asciiz "Buyukoz"   #yazdırılacak dizge2
    str3: .asciiz "!"         #yazdırılacak dizge3
    stop: .byte 0             #Null biti
.text  #.text assembler yönergesi aşağıdakilerin kod olacağını belirtir




main: #String main metodu

    la $a0, str1  #str1 adresini yükl
    la $a1, str2  #str2 adresini yükle
    jal concat    #birleştirme jal
    la $a0, str3  #str3 adresini yükle		
    jal print     #yazdırma jal
    li $v0, 10    #print_string sistem servisi çağrısı
    syscall        #Spim, sistem çağrısı talimatı ile küçük işletim sistemi benzeri hizmetler setini sağlar    




concat: #birleştirmenin yapılacağı kısım
    move $t0, $a0  #$t0=$a0
    move $t1, $a1  #$t1=$a1
    move $t2, $zero #$t2=$zero



    loop:
        lb $t3, 0($t0)  #t3 = SE (MEM[$t0 +0]:1)
        beq $t3, 0, done #if($t3==0)pc+4+done
        sb $t3, 0($t2)   #MEM [$s +0]:1 = LB($t) (Mips referans çizelgesine bakıldı) kaynak https://uweb.engr.arizona.edu/~ece369/Resources/spim/MIPSReference.pdf
        addi $t2, $t2, 1 #$t2'i 1'e sabitle 
        addi $t0, $t0, 1 #$t0'ı 1'e sabitle 
        j loop #loop'un adresine git



    done:
    move $a0, $t1  #$a0 = $t1
    move $t0, $zero #$t0=$zero
    move $t1, $zero #$t1=$zero



    loop2:
        lb $t4, 0($t1) #$t4 = SE (MEM [$t1 + 0]:1)
        beq $t4, $zero, done2 #if($t4==$zero)pc+4+done2
        addi $t1, $t1, 1 #$t1'i 1'e sabitle 
        j loop2 #loop2'nin adresine git



    done2:
    move $t3, $t0 #$t3=$t0
    move $t0, $zero #$t0=$zero 



    loop3:
        lb $t4, 0($t3) #$t4 = SE (MEM [$t3 + 0]:1)
        beq $t4, $zero, done3 #if($t4==$zero)pc+4+done3
        sb $t4, 0($t0) MEM [$t0 + 0]:1 = LB ($t)
        addi $t3, $t3, 1 #$t3'ü 1'e sabitle 
        addi $t0, $t0, 1 #$t0'ı 1'e sabitle 
        j loop3 #loop3'ün adresine git


    done3:
    move $a0, $zero #$a0=$zero
    move $v0, 4 #v0 = 4 adresinde
    syscall  #Spim, sistem çağrısı talimatı ile küçük işletim sistemi benzeri hizmetler setini sağla    
    move $v0, 1 #v0 = 1 adresinde
    move $a0, $t2 $a0=$t2
    syscall  #Spim, sistem çağrısı talimatı ile küçük işletim sistemi benzeri hizmetler setini sağlar    
    move $v0, 10 #v0 = 10 adresinde
    syscall  #Spim, sistem çağrısı talimatı ile küçük işletim sistemi benzeri hizmetler setini sağlar    
