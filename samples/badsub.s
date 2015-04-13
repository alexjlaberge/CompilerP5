	# standard Decaf preamble 
	  .text
	  .align 2
	  .globl main
  main:
	# BeginFunc 124
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 124	# decrement sp to make space for locals/temps
	# _tmp0 = 10
	  li $t2, 10		# load constant value 10 into $t2
	# _tmp1 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp2 = _tmp0 < _tmp1
	  slt $t0, $t2, $t0	
	# IfZ _tmp2 Goto _L0
	  beqz $t0, _L0	# branch if _tmp2 is zero 
	# _tmp3 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string1: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t0, _string1	# load label
	# PushParam _tmp3
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, -16($fp)	# spill _tmp0 from $t2 to $fp-16
	  jal _PrintString   	# jump to function
	  lw $t2, -16($fp)	# fill _tmp0 to $t2 from $fp-16
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t2, -16($fp)	# spill _tmp0 from $t2 to $fp-16
	  jal _Halt          	# jump to function
	  lw $t2, -16($fp)	# fill _tmp0 to $t2 from $fp-16
  _L0:
	# _tmp4 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp5 = _tmp4 + _tmp0
	  add $t0, $t0, $t2	
	# _tmp6 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp7 = _tmp5 * _tmp6
	  mul $t0, $t0, $t1	
	# PushParam _tmp7
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp8 = LCall _Alloc
	  sw $t2, -16($fp)	# spill _tmp0 from $t2 to $fp-16
	  sw $t1, -40($fp)	# spill _tmp6 from $t1 to $fp-40
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t2, -16($fp)	# fill _tmp0 to $t2 from $fp-16
	  lw $t1, -40($fp)	# fill _tmp6 to $t1 from $fp-40
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp8) = _tmp0
	  sw $t2, 0($t0) 	# store with offset
	# _tmp9 = _tmp8 + _tmp6
	  add $t0, $t0, $t1	
	# arr = _tmp9
	  move $t3, $t0	# copy regs
	# _tmp10 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp10
	  move $t4, $t0	# copy regs
  _L1:
	# _tmp11 = 10
	  li $t0, 10		# load constant value 10 into $t0
	# _tmp12 = i < _tmp11
	  slt $t1, $t4, $t0	
	# _tmp13 = i == _tmp11
	  seq $t0, $t4, $t0	
	# _tmp14 = _tmp12 || _tmp13
	  or $t0, $t1, $t0	
	# IfZ _tmp14 Goto _L2
	  beqz $t0, _L2	# branch if _tmp14 is zero 
	# _tmp15 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp16 = i < _tmp15
	  slt $t1, $t4, $t2	
	# _tmp17 = *(arr + -4)
	  lw $t0, -4($t3) 	# load with offset
	# _tmp18 = i < _tmp17
	  slt $t0, $t4, $t0	
	# _tmp19 = _tmp18 == _tmp15
	  seq $t0, $t0, $t2	
	# _tmp20 = _tmp16 || _tmp19
	  or $t0, $t1, $t0	
	# IfZ _tmp20 Goto _L3
	  beqz $t0, _L3	# branch if _tmp20 is zero 
	# _tmp21 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string2: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string2	# load label
	# PushParam _tmp21
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, -8($fp)	# spill arr from $t3 to $fp-8
	  sw $t4, -12($fp)	# spill i from $t4 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t3, -8($fp)	# fill arr to $t3 from $fp-8
	  lw $t4, -12($fp)	# fill i to $t4 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t3, -8($fp)	# spill arr from $t3 to $fp-8
	  sw $t4, -12($fp)	# spill i from $t4 to $fp-12
	  jal _Halt          	# jump to function
	  lw $t3, -8($fp)	# fill arr to $t3 from $fp-8
	  lw $t4, -12($fp)	# fill i to $t4 from $fp-12
  _L3:
	# _tmp22 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp23 = _tmp22 * i
	  mul $t0, $t0, $t4	
	# _tmp24 = arr + _tmp23
	  add $t0, $t3, $t0	
	# *(_tmp24) = i
	  sw $t4, 0($t0) 	# store with offset
	# PushParam i
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t4, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  sw $t3, -8($fp)	# spill arr from $t3 to $fp-8
	  sw $t4, -12($fp)	# spill i from $t4 to $fp-12
	  jal _PrintInt      	# jump to function
	  lw $t3, -8($fp)	# fill arr to $t3 from $fp-8
	  lw $t4, -12($fp)	# fill i to $t4 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp25 = "\n"
	  .data			# create string constant marked with label
	  _string3: .asciiz "\n"
	  .text
	  la $t0, _string3	# load label
	# PushParam _tmp25
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, -8($fp)	# spill arr from $t3 to $fp-8
	  sw $t4, -12($fp)	# spill i from $t4 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t3, -8($fp)	# fill arr to $t3 from $fp-8
	  lw $t4, -12($fp)	# fill i to $t4 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp26 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp27 = i + _tmp26
	  add $t0, $t4, $t0	
	# i = _tmp27
	  move $t4, $t0	# copy regs
	# Goto _L1
	  b _L1		# unconditional branch
  _L2:
	# _tmp28 = "Done\n"
	  .data			# create string constant marked with label
	  _string4: .asciiz "Done\n"
	  .text
	  la $t0, _string4	# load label
	# PushParam _tmp28
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _PrintInt:
	  subu $sp, $sp, 8	# decrement sp to make space to save ra,fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  lw $a0, 4($fp)	# fill a from $fp+4
	# LCall _PrintInt
	  li $v0, 1
	  syscall
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function

  _ReadInteger:
	  subu $sp, $sp, 8	# decrement sp to make space to save ra,fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  li $v0, 5
	  syscall
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function


  _PrintBool:
	  subu $sp, $sp, 8      # decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)        # save fp
	  sw $ra, 4($sp)        # save ra
	  addiu $fp, $sp, 8     # set up new fp
	  lw $a0, 4($fp)        # fill a from $fp+4
	  li $v0, 4
	  beq $a0, $0, PrintBoolFalse
	  la $a0, _PrintBoolTrueString
	  j PrintBoolEnd
  PrintBoolFalse:
 	  la $a0, _PrintBoolFalseString
  PrintBoolEnd:
	  syscall
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp         # pop callee frame off stack
	  lw $ra, -4($fp)       # restore saved ra
	  lw $fp, 0($fp)        # restore saved fp
	  jr $ra                # return from function

      .data			# create string constant marked with label
      _PrintBoolTrueString: .asciiz "true"
      .text

      .data			# create string constant marked with label
      _PrintBoolFalseString: .asciiz "false"
      .text

  _PrintString:
	  subu $sp, $sp, 8      # decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)        # save fp
	  sw $ra, 4($sp)        # save ra
	  addiu $fp, $sp, 8     # set up new fp
	  lw $a0, 4($fp)        # fill a from $fp+4
	  li $v0, 4
	  syscall
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp         # pop callee frame off stack
	  lw $ra, -4($fp)       # restore saved ra
	  lw $fp, 0($fp)        # restore saved fp
	  jr $ra                # return from function

  _Alloc:
	  subu $sp, $sp, 8      # decrement sp to make space to save ra,fp
	  sw $fp, 8($sp)        # save fp
	  sw $ra, 4($sp)        # save ra
	  addiu $fp, $sp, 8     # set up new fp
	  lw $a0, 4($fp)        # fill a from $fp+4
	  li $v0, 9
	  syscall
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp         # pop callee frame off stack
	  lw $ra, -4($fp)       # restore saved ra
	  lw $fp, 0($fp)        # restore saved fp
	  jr $ra                # return from function

  _Halt:
	  li $v0, 10
	  syscall
	# EndFunc


  _StringEqual:
	  subu $sp, $sp, 8      # decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)        # save fp
	  sw $ra, 4($sp)        # save ra
	  addiu $fp, $sp, 8     # set up new fp
	  lw $a0, 4($fp)        # fill a from $fp+4
	  lw $a1, 8($fp)        # fill a from $fp+8
	  beq $a0,$a1,Lrunt10
  Lrunt12:
	  lbu  $v0,($a0)
	  lbu  $a2,($a1)
	  bne $v0,$a2,Lrunt11
	  addiu $a0,$a0,1
	  addiu $a1,$a1,1
	  bne $v0,$0,Lrunt12
      li  $v0,1
      j Lrunt10
  Lrunt11:
	  li  $v0,0
  Lrunt10:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp         # pop callee frame off stack
	  lw $ra, -4($fp)       # restore saved ra
	  lw $fp, 0($fp)        # restore saved fp
	  jr $ra                # return from function



  _ReadLine:
	  subu $sp, $sp, 8      # decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)        # save fp
	  sw $ra, 4($sp)        # save ra
	  addiu $fp, $sp, 8     # set up new fp
	  li $a0, 101
	  li $v0, 9
	  syscall
	  addi $a0, $v0, 0
	  li $v0, 8
	  li $a1,101 
	  syscall
	  addiu $v0,$a0,0       # pointer to begin of string
  Lrunt21:
	  lb $a1,($a0)          # load character at pointer
	  addiu $a0,$a0,1       # forward pointer
	  bnez $a1,Lrunt21      # loop until end of string is reached
	  lb $a1,-2($a0)        # load character before end of string
	  li $a2,10             # newline character	  bneq $a1,$a2,Lrunt20  # do not remove last character if not newline
	  sb $0,-2($a0)         # Add the terminating character in its place
  Lrunt20:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp         # pop callee frame off stack
	  lw $ra, -4($fp)       # restore saved ra
	  lw $fp, 0($fp)        # restore saved fp
	  jr $ra                # return from function
