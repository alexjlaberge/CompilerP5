	# standard Decaf preamble 
	  .text
	  .align 2
	  .globl main
  _Wild:
	# BeginFunc 80
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 80	# decrement sp to make space for locals/temps
	  lw $t4, 4($fp)	# fill names to $t4 from $fp+4
	  lw $t3, 8($fp)	# fill answer to $t3 from $fp+8
	# _tmp0 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp0
	  move $t5, $t0	# copy regs
  _L0:
	# _tmp1 = *(names + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp2 = i < _tmp1
	  slt $t0, $t5, $t0	
	# IfZ _tmp2 Goto _L1
	  beqz $t0, _L1	# branch if _tmp2 is zero 
	# _tmp3 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp4 = i < _tmp3
	  slt $t1, $t5, $t2	
	# _tmp5 = *(names + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp6 = i < _tmp5
	  slt $t0, $t5, $t0	
	# _tmp7 = _tmp6 == _tmp3
	  seq $t0, $t0, $t2	
	# _tmp8 = _tmp4 || _tmp7
	  or $t0, $t1, $t0	
	# IfZ _tmp8 Goto _L2
	  beqz $t0, _L2	# branch if _tmp8 is zero 
	# _tmp9 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string1: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string1	# load label
	# PushParam _tmp9
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t4, 4($fp)	# spill names from $t4 to $fp+4
	  sw $t3, 8($fp)	# spill answer from $t3 to $fp+8
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  jal _PrintString   	# jump to function
	  lw $t4, 4($fp)	# fill names to $t4 from $fp+4
	  lw $t3, 8($fp)	# fill answer to $t3 from $fp+8
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t4, 4($fp)	# spill names from $t4 to $fp+4
	  sw $t3, 8($fp)	# spill answer from $t3 to $fp+8
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  jal _Halt          	# jump to function
	  lw $t4, 4($fp)	# fill names to $t4 from $fp+4
	  lw $t3, 8($fp)	# fill answer to $t3 from $fp+8
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
  _L2:
	# _tmp10 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp11 = _tmp10 * i
	  mul $t0, $t0, $t5	
	# _tmp12 = names + _tmp11
	  add $t0, $t4, $t0	
	# _tmp13 = *(_tmp12)
	  lw $t0, 0($t0) 	# load with offset
	# PushParam answer
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# PushParam _tmp13
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp14 = LCall _StringEqual
	  sw $t4, 4($fp)	# spill names from $t4 to $fp+4
	  sw $t3, 8($fp)	# spill answer from $t3 to $fp+8
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  jal _StringEqual   	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t4, 4($fp)	# fill names to $t4 from $fp+4
	  lw $t3, 8($fp)	# fill answer to $t3 from $fp+8
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# IfZ _tmp14 Goto _L3
	  beqz $t0, _L3	# branch if _tmp14 is zero 
	# _tmp15 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# Return _tmp15
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _L3:
	# _tmp16 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp17 = i + _tmp16
	  add $t0, $t5, $t0	
	# i = _tmp17
	  move $t5, $t0	# copy regs
	# Goto _L0
	  b _L0		# unconditional branch
  _L1:
	# _tmp18 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# Return _tmp18
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  main:
	# BeginFunc 212
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 212	# decrement sp to make space for locals/temps
	# _tmp19 = 3
	  li $t2, 3		# load constant value 3 into $t2
	# _tmp20 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp21 = _tmp19 < _tmp20
	  slt $t0, $t2, $t0	
	# IfZ _tmp21 Goto _L4
	  beqz $t0, _L4	# branch if _tmp21 is zero 
	# _tmp22 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string2: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t0, _string2	# load label
	# PushParam _tmp22
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, -12($fp)	# spill _tmp19 from $t2 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t2, -12($fp)	# fill _tmp19 to $t2 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t2, -12($fp)	# spill _tmp19 from $t2 to $fp-12
	  jal _Halt          	# jump to function
	  lw $t2, -12($fp)	# fill _tmp19 to $t2 from $fp-12
  _L4:
	# _tmp23 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp24 = _tmp23 + _tmp19
	  add $t0, $t0, $t2	
	# _tmp25 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp26 = _tmp24 * _tmp25
	  mul $t0, $t0, $t1	
	# PushParam _tmp26
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp27 = LCall _Alloc
	  sw $t2, -12($fp)	# spill _tmp19 from $t2 to $fp-12
	  sw $t1, -36($fp)	# spill _tmp25 from $t1 to $fp-36
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t2, -12($fp)	# fill _tmp19 to $t2 from $fp-12
	  lw $t1, -36($fp)	# fill _tmp25 to $t1 from $fp-36
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp27) = _tmp19
	  sw $t2, 0($t0) 	# store with offset
	# _tmp28 = _tmp27 + _tmp25
	  add $t0, $t0, $t1	
	# names = _tmp28
	  move $t4, $t0	# copy regs
	# _tmp29 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp30 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp31 = _tmp29 < _tmp30
	  slt $t1, $t3, $t2	
	# _tmp32 = *(names + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp33 = _tmp29 < _tmp32
	  slt $t0, $t3, $t0	
	# _tmp34 = _tmp33 == _tmp30
	  seq $t0, $t0, $t2	
	# _tmp35 = _tmp31 || _tmp34
	  or $t0, $t1, $t0	
	# IfZ _tmp35 Goto _L5
	  beqz $t0, _L5	# branch if _tmp35 is zero 
	# _tmp36 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string3: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string3	# load label
	# PushParam _tmp36
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t4, -8($fp)	# spill names from $t4 to $fp-8
	  sw $t3, -52($fp)	# spill _tmp29 from $t3 to $fp-52
	  jal _PrintString   	# jump to function
	  lw $t4, -8($fp)	# fill names to $t4 from $fp-8
	  lw $t3, -52($fp)	# fill _tmp29 to $t3 from $fp-52
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t4, -8($fp)	# spill names from $t4 to $fp-8
	  sw $t3, -52($fp)	# spill _tmp29 from $t3 to $fp-52
	  jal _Halt          	# jump to function
	  lw $t4, -8($fp)	# fill names to $t4 from $fp-8
	  lw $t3, -52($fp)	# fill _tmp29 to $t3 from $fp-52
  _L5:
	# _tmp37 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp38 = _tmp37 * _tmp29
	  mul $t0, $t0, $t3	
	# _tmp39 = names + _tmp38
	  add $t1, $t4, $t0	
	# _tmp40 = "Satish"
	  .data			# create string constant marked with label
	  _string4: .asciiz "Satish"
	  .text
	  la $t0, _string4	# load label
	# *(_tmp39) = _tmp40
	  sw $t0, 0($t1) 	# store with offset
	# _tmp41 = 1
	  li $t3, 1		# load constant value 1 into $t3
	# _tmp42 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp43 = _tmp41 < _tmp42
	  slt $t1, $t3, $t2	
	# _tmp44 = *(names + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp45 = _tmp41 < _tmp44
	  slt $t0, $t3, $t0	
	# _tmp46 = _tmp45 == _tmp42
	  seq $t0, $t0, $t2	
	# _tmp47 = _tmp43 || _tmp46
	  or $t0, $t1, $t0	
	# IfZ _tmp47 Goto _L6
	  beqz $t0, _L6	# branch if _tmp47 is zero 
	# _tmp48 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string5: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string5	# load label
	# PushParam _tmp48
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t4, -8($fp)	# spill names from $t4 to $fp-8
	  sw $t3, -100($fp)	# spill _tmp41 from $t3 to $fp-100
	  jal _PrintString   	# jump to function
	  lw $t4, -8($fp)	# fill names to $t4 from $fp-8
	  lw $t3, -100($fp)	# fill _tmp41 to $t3 from $fp-100
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t4, -8($fp)	# spill names from $t4 to $fp-8
	  sw $t3, -100($fp)	# spill _tmp41 from $t3 to $fp-100
	  jal _Halt          	# jump to function
	  lw $t4, -8($fp)	# fill names to $t4 from $fp-8
	  lw $t3, -100($fp)	# fill _tmp41 to $t3 from $fp-100
  _L6:
	# _tmp49 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp50 = _tmp49 * _tmp41
	  mul $t0, $t0, $t3	
	# _tmp51 = names + _tmp50
	  add $t1, $t4, $t0	
	# _tmp52 = "Chun"
	  .data			# create string constant marked with label
	  _string6: .asciiz "Chun"
	  .text
	  la $t0, _string6	# load label
	# *(_tmp51) = _tmp52
	  sw $t0, 0($t1) 	# store with offset
	# _tmp53 = 2
	  li $t3, 2		# load constant value 2 into $t3
	# _tmp54 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp55 = _tmp53 < _tmp54
	  slt $t1, $t3, $t2	
	# _tmp56 = *(names + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp57 = _tmp53 < _tmp56
	  slt $t0, $t3, $t0	
	# _tmp58 = _tmp57 == _tmp54
	  seq $t0, $t0, $t2	
	# _tmp59 = _tmp55 || _tmp58
	  or $t0, $t1, $t0	
	# IfZ _tmp59 Goto _L7
	  beqz $t0, _L7	# branch if _tmp59 is zero 
	# _tmp60 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string7: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string7	# load label
	# PushParam _tmp60
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t4, -8($fp)	# spill names from $t4 to $fp-8
	  sw $t3, -148($fp)	# spill _tmp53 from $t3 to $fp-148
	  jal _PrintString   	# jump to function
	  lw $t4, -8($fp)	# fill names to $t4 from $fp-8
	  lw $t3, -148($fp)	# fill _tmp53 to $t3 from $fp-148
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t4, -8($fp)	# spill names from $t4 to $fp-8
	  sw $t3, -148($fp)	# spill _tmp53 from $t3 to $fp-148
	  jal _Halt          	# jump to function
	  lw $t4, -8($fp)	# fill names to $t4 from $fp-8
	  lw $t3, -148($fp)	# fill _tmp53 to $t3 from $fp-148
  _L7:
	# _tmp61 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp62 = _tmp61 * _tmp53
	  mul $t0, $t0, $t3	
	# _tmp63 = names + _tmp62
	  add $t1, $t4, $t0	
	# _tmp64 = "Supriya"
	  .data			# create string constant marked with label
	  _string8: .asciiz "Supriya"
	  .text
	  la $t0, _string8	# load label
	# *(_tmp63) = _tmp64
	  sw $t0, 0($t1) 	# store with offset
  _L8:
	# _tmp65 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# IfZ _tmp65 Goto _L9
	  beqz $t0, _L9	# branch if _tmp65 is zero 
	# _tmp66 = "\nWho is your favorite EECS483 staff member? "
	  .data			# create string constant marked with label
	  _string9: .asciiz "\nWho is your favorite EECS483 staff member? "
	  .text
	  la $t0, _string9	# load label
	# PushParam _tmp66
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t4, -8($fp)	# spill names from $t4 to $fp-8
	  jal _PrintString   	# jump to function
	  lw $t4, -8($fp)	# fill names to $t4 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp67 = LCall _ReadLine
	  sw $t4, -8($fp)	# spill names from $t4 to $fp-8
	  jal _ReadLine      	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t4, -8($fp)	# fill names to $t4 from $fp-8
	# PushParam _tmp67
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam names
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t4, 4($sp)	# copy param value to stack
	# _tmp68 = LCall _Wild
	  sw $t4, -8($fp)	# spill names from $t4 to $fp-8
	  jal _Wild          	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t4, -8($fp)	# fill names to $t4 from $fp-8
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# IfZ _tmp68 Goto _L10
	  beqz $t0, _L10	# branch if _tmp68 is zero 
	# _tmp69 = "You just earned 1000 bonus points!\n"
	  .data			# create string constant marked with label
	  _string10: .asciiz "You just earned 1000 bonus points!\n"
	  .text
	  la $t0, _string10	# load label
	# PushParam _tmp69
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L9
	  b _L9		# unconditional branch
  _L10:
	# _tmp70 = "That's not a good way to make points. Try again!\..."
	  .data			# create string constant marked with label
	  _string11: .asciiz "That's not a good way to make points. Try again!\n"
	  .text
	  la $t0, _string11	# load label
	# PushParam _tmp70
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t4, -8($fp)	# spill names from $t4 to $fp-8
	  jal _PrintString   	# jump to function
	  lw $t4, -8($fp)	# fill names to $t4 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L8
	  b _L8		# unconditional branch
  _L9:
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
