	# standard Decaf preamble 
	  .text
	  .align 2
	  .globl main
  _Binky:
	# BeginFunc 92
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 92	# decrement sp to make space for locals/temps
	  lw $t4, 8($fp)	# fill b to $t4 from $fp+8
	  lw $t5, 12($fp)	# fill c to $t5 from $fp+12
	# _tmp0 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp1 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp2 = _tmp0 < _tmp1
	  slt $t1, $t3, $t2	
	# _tmp3 = *(c + -4)
	  lw $t0, -4($t5) 	# load with offset
	# _tmp4 = _tmp0 < _tmp3
	  slt $t0, $t3, $t0	
	# _tmp5 = _tmp4 == _tmp1
	  seq $t0, $t0, $t2	
	# _tmp6 = _tmp2 || _tmp5
	  or $t0, $t1, $t0	
	# IfZ _tmp6 Goto _L0
	  beqz $t0, _L0	# branch if _tmp6 is zero 
	# _tmp7 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string1: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string1	# load label
	# PushParam _tmp7
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t4, 8($fp)	# spill b from $t4 to $fp+8
	  sw $t5, 12($fp)	# spill c from $t5 to $fp+12
	  sw $t3, -8($fp)	# spill _tmp0 from $t3 to $fp-8
	  jal _PrintString   	# jump to function
	  lw $t4, 8($fp)	# fill b to $t4 from $fp+8
	  lw $t5, 12($fp)	# fill c to $t5 from $fp+12
	  lw $t3, -8($fp)	# fill _tmp0 to $t3 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t4, 8($fp)	# spill b from $t4 to $fp+8
	  sw $t5, 12($fp)	# spill c from $t5 to $fp+12
	  sw $t3, -8($fp)	# spill _tmp0 from $t3 to $fp-8
	  jal _Halt          	# jump to function
	  lw $t4, 8($fp)	# fill b to $t4 from $fp+8
	  lw $t5, 12($fp)	# fill c to $t5 from $fp+12
	  lw $t3, -8($fp)	# fill _tmp0 to $t3 from $fp-8
  _L0:
	# _tmp8 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp9 = _tmp8 * _tmp0
	  mul $t0, $t0, $t3	
	# _tmp10 = c + _tmp9
	  add $t0, $t5, $t0	
	# _tmp11 = *(_tmp10)
	  lw $t3, 0($t0) 	# load with offset
	# _tmp12 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp13 = _tmp11 < _tmp12
	  slt $t1, $t3, $t2	
	# _tmp14 = *(b + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp15 = _tmp11 < _tmp14
	  slt $t0, $t3, $t0	
	# _tmp16 = _tmp15 == _tmp12
	  seq $t0, $t0, $t2	
	# _tmp17 = _tmp13 || _tmp16
	  or $t0, $t1, $t0	
	# IfZ _tmp17 Goto _L1
	  beqz $t0, _L1	# branch if _tmp17 is zero 
	# _tmp18 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string2: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string2	# load label
	# PushParam _tmp18
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t4, 8($fp)	# spill b from $t4 to $fp+8
	  sw $t3, -52($fp)	# spill _tmp11 from $t3 to $fp-52
	  jal _PrintString   	# jump to function
	  lw $t4, 8($fp)	# fill b to $t4 from $fp+8
	  lw $t3, -52($fp)	# fill _tmp11 to $t3 from $fp-52
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t4, 8($fp)	# spill b from $t4 to $fp+8
	  sw $t3, -52($fp)	# spill _tmp11 from $t3 to $fp-52
	  jal _Halt          	# jump to function
	  lw $t4, 8($fp)	# fill b to $t4 from $fp+8
	  lw $t3, -52($fp)	# fill _tmp11 to $t3 from $fp-52
  _L1:
	# _tmp19 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp20 = _tmp19 * _tmp11
	  mul $t0, $t0, $t3	
	# _tmp21 = b + _tmp20
	  add $t0, $t4, $t0	
	# _tmp22 = *(_tmp21)
	  lw $t0, 0($t0) 	# load with offset
	# Return _tmp22
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
	# BeginFunc 508
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 508	# decrement sp to make space for locals/temps
	# _tmp23 = 5
	  li $t2, 5		# load constant value 5 into $t2
	# _tmp24 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp25 = _tmp23 < _tmp24
	  slt $t0, $t2, $t0	
	# IfZ _tmp25 Goto _L2
	  beqz $t0, _L2	# branch if _tmp25 is zero 
	# _tmp26 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string3: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t0, _string3	# load label
	# PushParam _tmp26
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, -16($fp)	# spill _tmp23 from $t2 to $fp-16
	  jal _PrintString   	# jump to function
	  lw $t2, -16($fp)	# fill _tmp23 to $t2 from $fp-16
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t2, -16($fp)	# spill _tmp23 from $t2 to $fp-16
	  jal _Halt          	# jump to function
	  lw $t2, -16($fp)	# fill _tmp23 to $t2 from $fp-16
  _L2:
	# _tmp27 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp28 = _tmp27 + _tmp23
	  add $t0, $t0, $t2	
	# _tmp29 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp30 = _tmp28 * _tmp29
	  mul $t0, $t0, $t1	
	# PushParam _tmp30
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp31 = LCall _Alloc
	  sw $t2, -16($fp)	# spill _tmp23 from $t2 to $fp-16
	  sw $t1, -40($fp)	# spill _tmp29 from $t1 to $fp-40
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t2, -16($fp)	# fill _tmp23 to $t2 from $fp-16
	  lw $t1, -40($fp)	# fill _tmp29 to $t1 from $fp-40
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp31) = _tmp23
	  sw $t2, 0($t0) 	# store with offset
	# _tmp32 = _tmp31 + _tmp29
	  add $t0, $t0, $t1	
	# d = _tmp32
	  move $t7, $t0	# copy regs
	# _tmp33 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp34 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp35 = _tmp33 < _tmp34
	  slt $t1, $t3, $t2	
	# _tmp36 = *(d + -4)
	  lw $t0, -4($t7) 	# load with offset
	# _tmp37 = _tmp33 < _tmp36
	  slt $t0, $t3, $t0	
	# _tmp38 = _tmp37 == _tmp34
	  seq $t0, $t0, $t2	
	# _tmp39 = _tmp35 || _tmp38
	  or $t0, $t1, $t0	
	# IfZ _tmp39 Goto _L3
	  beqz $t0, _L3	# branch if _tmp39 is zero 
	# _tmp40 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string4: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string4	# load label
	# PushParam _tmp40
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t3, -56($fp)	# spill _tmp33 from $t3 to $fp-56
	  jal _PrintString   	# jump to function
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t3, -56($fp)	# fill _tmp33 to $t3 from $fp-56
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t3, -56($fp)	# spill _tmp33 from $t3 to $fp-56
	  jal _Halt          	# jump to function
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t3, -56($fp)	# fill _tmp33 to $t3 from $fp-56
  _L3:
	# _tmp41 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp42 = _tmp41 * _tmp33
	  mul $t0, $t0, $t3	
	# _tmp43 = d + _tmp42
	  add $t3, $t7, $t0	
	# _tmp44 = 12
	  li $t2, 12		# load constant value 12 into $t2
	# _tmp45 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp46 = _tmp44 < _tmp45
	  slt $t0, $t2, $t0	
	# IfZ _tmp46 Goto _L4
	  beqz $t0, _L4	# branch if _tmp46 is zero 
	# _tmp47 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string5: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t0, _string5	# load label
	# PushParam _tmp47
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t3, -96($fp)	# spill _tmp43 from $t3 to $fp-96
	  sw $t2, -100($fp)	# spill _tmp44 from $t2 to $fp-100
	  jal _PrintString   	# jump to function
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t3, -96($fp)	# fill _tmp43 to $t3 from $fp-96
	  lw $t2, -100($fp)	# fill _tmp44 to $t2 from $fp-100
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t3, -96($fp)	# spill _tmp43 from $t3 to $fp-96
	  sw $t2, -100($fp)	# spill _tmp44 from $t2 to $fp-100
	  jal _Halt          	# jump to function
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t3, -96($fp)	# fill _tmp43 to $t3 from $fp-96
	  lw $t2, -100($fp)	# fill _tmp44 to $t2 from $fp-100
  _L4:
	# _tmp48 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp49 = _tmp48 + _tmp44
	  add $t0, $t0, $t2	
	# _tmp50 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp51 = _tmp49 * _tmp50
	  mul $t0, $t0, $t1	
	# PushParam _tmp51
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp52 = LCall _Alloc
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t3, -96($fp)	# spill _tmp43 from $t3 to $fp-96
	  sw $t2, -100($fp)	# spill _tmp44 from $t2 to $fp-100
	  sw $t1, -124($fp)	# spill _tmp50 from $t1 to $fp-124
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t3, -96($fp)	# fill _tmp43 to $t3 from $fp-96
	  lw $t2, -100($fp)	# fill _tmp44 to $t2 from $fp-100
	  lw $t1, -124($fp)	# fill _tmp50 to $t1 from $fp-124
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp52) = _tmp44
	  sw $t2, 0($t0) 	# store with offset
	# _tmp53 = _tmp52 + _tmp50
	  add $t0, $t0, $t1	
	# *(_tmp43) = _tmp53
	  sw $t0, 0($t3) 	# store with offset
	# _tmp54 = 10
	  li $t2, 10		# load constant value 10 into $t2
	# _tmp55 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp56 = _tmp54 < _tmp55
	  slt $t0, $t2, $t0	
	# IfZ _tmp56 Goto _L5
	  beqz $t0, _L5	# branch if _tmp56 is zero 
	# _tmp57 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string6: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t0, _string6	# load label
	# PushParam _tmp57
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t2, -140($fp)	# spill _tmp54 from $t2 to $fp-140
	  jal _PrintString   	# jump to function
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t2, -140($fp)	# fill _tmp54 to $t2 from $fp-140
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t2, -140($fp)	# spill _tmp54 from $t2 to $fp-140
	  jal _Halt          	# jump to function
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t2, -140($fp)	# fill _tmp54 to $t2 from $fp-140
  _L5:
	# _tmp58 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp59 = _tmp58 + _tmp54
	  add $t0, $t0, $t2	
	# _tmp60 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp61 = _tmp59 * _tmp60
	  mul $t0, $t0, $t1	
	# PushParam _tmp61
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp62 = LCall _Alloc
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t2, -140($fp)	# spill _tmp54 from $t2 to $fp-140
	  sw $t1, -164($fp)	# spill _tmp60 from $t1 to $fp-164
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t2, -140($fp)	# fill _tmp54 to $t2 from $fp-140
	  lw $t1, -164($fp)	# fill _tmp60 to $t1 from $fp-164
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp62) = _tmp54
	  sw $t2, 0($t0) 	# store with offset
	# _tmp63 = _tmp62 + _tmp60
	  add $t0, $t0, $t1	
	# c = _tmp63
	  move $t6, $t0	# copy regs
	# _tmp64 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp65 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp66 = _tmp64 < _tmp65
	  slt $t1, $t3, $t2	
	# _tmp67 = *(c + -4)
	  lw $t0, -4($t6) 	# load with offset
	# _tmp68 = _tmp64 < _tmp67
	  slt $t0, $t3, $t0	
	# _tmp69 = _tmp68 == _tmp65
	  seq $t0, $t0, $t2	
	# _tmp70 = _tmp66 || _tmp69
	  or $t0, $t1, $t0	
	# IfZ _tmp70 Goto _L6
	  beqz $t0, _L6	# branch if _tmp70 is zero 
	# _tmp71 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string7: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string7	# load label
	# PushParam _tmp71
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t6, -8($fp)	# spill c from $t6 to $fp-8
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t3, -180($fp)	# spill _tmp64 from $t3 to $fp-180
	  jal _PrintString   	# jump to function
	  lw $t6, -8($fp)	# fill c to $t6 from $fp-8
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t3, -180($fp)	# fill _tmp64 to $t3 from $fp-180
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t6, -8($fp)	# spill c from $t6 to $fp-8
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t3, -180($fp)	# spill _tmp64 from $t3 to $fp-180
	  jal _Halt          	# jump to function
	  lw $t6, -8($fp)	# fill c to $t6 from $fp-8
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t3, -180($fp)	# fill _tmp64 to $t3 from $fp-180
  _L6:
	# _tmp72 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp73 = _tmp72 * _tmp64
	  mul $t0, $t0, $t3	
	# _tmp74 = c + _tmp73
	  add $t3, $t6, $t0	
	# _tmp75 = 4
	  li $t2, 4		# load constant value 4 into $t2
	# _tmp76 = 5
	  li $t1, 5		# load constant value 5 into $t1
	# _tmp77 = 3
	  li $t0, 3		# load constant value 3 into $t0
	# _tmp78 = _tmp76 * _tmp77
	  mul $t1, $t1, $t0	
	# _tmp79 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp80 = _tmp78 / _tmp79
	  div $t1, $t1, $t0	
	# _tmp81 = 2
	  li $t0, 2		# load constant value 2 into $t0
	# _tmp82 = _tmp80 % _tmp81
	  rem $t0, $t1, $t0	
	# _tmp83 = _tmp75 + _tmp82
	  add $t0, $t2, $t0	
	# *(_tmp74) = _tmp83
	  sw $t0, 0($t3) 	# store with offset
	# _tmp84 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp85 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp86 = _tmp84 < _tmp85
	  slt $t1, $t3, $t2	
	# _tmp87 = *(d + -4)
	  lw $t0, -4($t7) 	# load with offset
	# _tmp88 = _tmp84 < _tmp87
	  slt $t0, $t3, $t0	
	# _tmp89 = _tmp88 == _tmp85
	  seq $t0, $t0, $t2	
	# _tmp90 = _tmp86 || _tmp89
	  or $t0, $t1, $t0	
	# IfZ _tmp90 Goto _L7
	  beqz $t0, _L7	# branch if _tmp90 is zero 
	# _tmp91 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string8: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string8	# load label
	# PushParam _tmp91
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t6, -8($fp)	# spill c from $t6 to $fp-8
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t3, -260($fp)	# spill _tmp84 from $t3 to $fp-260
	  jal _PrintString   	# jump to function
	  lw $t6, -8($fp)	# fill c to $t6 from $fp-8
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t3, -260($fp)	# fill _tmp84 to $t3 from $fp-260
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t6, -8($fp)	# spill c from $t6 to $fp-8
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t3, -260($fp)	# spill _tmp84 from $t3 to $fp-260
	  jal _Halt          	# jump to function
	  lw $t6, -8($fp)	# fill c to $t6 from $fp-8
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t3, -260($fp)	# fill _tmp84 to $t3 from $fp-260
  _L7:
	# _tmp92 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp93 = _tmp92 * _tmp84
	  mul $t0, $t0, $t3	
	# _tmp94 = d + _tmp93
	  add $t0, $t7, $t0	
	# _tmp95 = *(_tmp94)
	  lw $t4, 0($t0) 	# load with offset
	# _tmp96 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp97 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp98 = _tmp96 < _tmp97
	  slt $t1, $t3, $t2	
	# _tmp99 = *(c + -4)
	  lw $t0, -4($t6) 	# load with offset
	# _tmp100 = _tmp96 < _tmp99
	  slt $t0, $t3, $t0	
	# _tmp101 = _tmp100 == _tmp97
	  seq $t0, $t0, $t2	
	# _tmp102 = _tmp98 || _tmp101
	  or $t0, $t1, $t0	
	# IfZ _tmp102 Goto _L8
	  beqz $t0, _L8	# branch if _tmp102 is zero 
	# _tmp103 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string9: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string9	# load label
	# PushParam _tmp103
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t6, -8($fp)	# spill c from $t6 to $fp-8
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t4, -304($fp)	# spill _tmp95 from $t4 to $fp-304
	  sw $t3, -308($fp)	# spill _tmp96 from $t3 to $fp-308
	  jal _PrintString   	# jump to function
	  lw $t6, -8($fp)	# fill c to $t6 from $fp-8
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t4, -304($fp)	# fill _tmp95 to $t4 from $fp-304
	  lw $t3, -308($fp)	# fill _tmp96 to $t3 from $fp-308
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t6, -8($fp)	# spill c from $t6 to $fp-8
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t4, -304($fp)	# spill _tmp95 from $t4 to $fp-304
	  sw $t3, -308($fp)	# spill _tmp96 from $t3 to $fp-308
	  jal _Halt          	# jump to function
	  lw $t6, -8($fp)	# fill c to $t6 from $fp-8
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t4, -304($fp)	# fill _tmp95 to $t4 from $fp-304
	  lw $t3, -308($fp)	# fill _tmp96 to $t3 from $fp-308
  _L8:
	# _tmp104 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp105 = _tmp104 * _tmp96
	  mul $t0, $t0, $t3	
	# _tmp106 = c + _tmp105
	  add $t0, $t6, $t0	
	# _tmp107 = *(_tmp106)
	  lw $t3, 0($t0) 	# load with offset
	# _tmp108 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp109 = _tmp107 < _tmp108
	  slt $t1, $t3, $t2	
	# _tmp110 = *(_tmp95 + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp111 = _tmp107 < _tmp110
	  slt $t0, $t3, $t0	
	# _tmp112 = _tmp111 == _tmp108
	  seq $t0, $t0, $t2	
	# _tmp113 = _tmp109 || _tmp112
	  or $t0, $t1, $t0	
	# IfZ _tmp113 Goto _L9
	  beqz $t0, _L9	# branch if _tmp113 is zero 
	# _tmp114 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string10: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string10	# load label
	# PushParam _tmp114
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t6, -8($fp)	# spill c from $t6 to $fp-8
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t4, -304($fp)	# spill _tmp95 from $t4 to $fp-304
	  sw $t3, -352($fp)	# spill _tmp107 from $t3 to $fp-352
	  jal _PrintString   	# jump to function
	  lw $t6, -8($fp)	# fill c to $t6 from $fp-8
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t4, -304($fp)	# fill _tmp95 to $t4 from $fp-304
	  lw $t3, -352($fp)	# fill _tmp107 to $t3 from $fp-352
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t6, -8($fp)	# spill c from $t6 to $fp-8
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t4, -304($fp)	# spill _tmp95 from $t4 to $fp-304
	  sw $t3, -352($fp)	# spill _tmp107 from $t3 to $fp-352
	  jal _Halt          	# jump to function
	  lw $t6, -8($fp)	# fill c to $t6 from $fp-8
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t4, -304($fp)	# fill _tmp95 to $t4 from $fp-304
	  lw $t3, -352($fp)	# fill _tmp107 to $t3 from $fp-352
  _L9:
	# _tmp115 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp116 = _tmp115 * _tmp107
	  mul $t0, $t0, $t3	
	# _tmp117 = _tmp95 + _tmp116
	  add $t1, $t4, $t0	
	# _tmp118 = 55
	  li $t0, 55		# load constant value 55 into $t0
	# *(_tmp117) = _tmp118
	  sw $t0, 0($t1) 	# store with offset
	# _tmp119 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp120 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp121 = _tmp119 < _tmp120
	  slt $t1, $t3, $t2	
	# _tmp122 = *(c + -4)
	  lw $t0, -4($t6) 	# load with offset
	# _tmp123 = _tmp119 < _tmp122
	  slt $t0, $t3, $t0	
	# _tmp124 = _tmp123 == _tmp120
	  seq $t0, $t0, $t2	
	# _tmp125 = _tmp121 || _tmp124
	  or $t0, $t1, $t0	
	# IfZ _tmp125 Goto _L10
	  beqz $t0, _L10	# branch if _tmp125 is zero 
	# _tmp126 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string11: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string11	# load label
	# PushParam _tmp126
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t6, -8($fp)	# spill c from $t6 to $fp-8
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t3, -400($fp)	# spill _tmp119 from $t3 to $fp-400
	  jal _PrintString   	# jump to function
	  lw $t6, -8($fp)	# fill c to $t6 from $fp-8
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t3, -400($fp)	# fill _tmp119 to $t3 from $fp-400
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t6, -8($fp)	# spill c from $t6 to $fp-8
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t3, -400($fp)	# spill _tmp119 from $t3 to $fp-400
	  jal _Halt          	# jump to function
	  lw $t6, -8($fp)	# fill c to $t6 from $fp-8
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t3, -400($fp)	# fill _tmp119 to $t3 from $fp-400
  _L10:
	# _tmp127 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp128 = _tmp127 * _tmp119
	  mul $t0, $t0, $t3	
	# _tmp129 = c + _tmp128
	  add $t0, $t6, $t0	
	# _tmp130 = *(_tmp129)
	  lw $t0, 0($t0) 	# load with offset
	# PushParam _tmp130
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  sw $t6, -8($fp)	# spill c from $t6 to $fp-8
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  jal _PrintInt      	# jump to function
	  lw $t6, -8($fp)	# fill c to $t6 from $fp-8
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp131 = " "
	  .data			# create string constant marked with label
	  _string12: .asciiz " "
	  .text
	  la $t0, _string12	# load label
	# PushParam _tmp131
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t6, -8($fp)	# spill c from $t6 to $fp-8
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t6, -8($fp)	# fill c to $t6 from $fp-8
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp132 = 2
	  li $t5, 2		# load constant value 2 into $t5
	# _tmp133 = 100
	  li $t4, 100		# load constant value 100 into $t4
	# _tmp134 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp135 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp136 = _tmp134 < _tmp135
	  slt $t1, $t3, $t2	
	# _tmp137 = *(d + -4)
	  lw $t0, -4($t7) 	# load with offset
	# _tmp138 = _tmp134 < _tmp137
	  slt $t0, $t3, $t0	
	# _tmp139 = _tmp138 == _tmp135
	  seq $t0, $t0, $t2	
	# _tmp140 = _tmp136 || _tmp139
	  or $t0, $t1, $t0	
	# IfZ _tmp140 Goto _L11
	  beqz $t0, _L11	# branch if _tmp140 is zero 
	# _tmp141 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string13: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string13	# load label
	# PushParam _tmp141
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t6, -8($fp)	# spill c from $t6 to $fp-8
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t5, -452($fp)	# spill _tmp132 from $t5 to $fp-452
	  sw $t4, -456($fp)	# spill _tmp133 from $t4 to $fp-456
	  sw $t3, -460($fp)	# spill _tmp134 from $t3 to $fp-460
	  jal _PrintString   	# jump to function
	  lw $t6, -8($fp)	# fill c to $t6 from $fp-8
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t5, -452($fp)	# fill _tmp132 to $t5 from $fp-452
	  lw $t4, -456($fp)	# fill _tmp133 to $t4 from $fp-456
	  lw $t3, -460($fp)	# fill _tmp134 to $t3 from $fp-460
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t6, -8($fp)	# spill c from $t6 to $fp-8
	  sw $t7, -12($fp)	# spill d from $t7 to $fp-12
	  sw $t5, -452($fp)	# spill _tmp132 from $t5 to $fp-452
	  sw $t4, -456($fp)	# spill _tmp133 from $t4 to $fp-456
	  sw $t3, -460($fp)	# spill _tmp134 from $t3 to $fp-460
	  jal _Halt          	# jump to function
	  lw $t6, -8($fp)	# fill c to $t6 from $fp-8
	  lw $t7, -12($fp)	# fill d to $t7 from $fp-12
	  lw $t5, -452($fp)	# fill _tmp132 to $t5 from $fp-452
	  lw $t4, -456($fp)	# fill _tmp133 to $t4 from $fp-456
	  lw $t3, -460($fp)	# fill _tmp134 to $t3 from $fp-460
  _L11:
	# _tmp142 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp143 = _tmp142 * _tmp134
	  mul $t0, $t0, $t3	
	# _tmp144 = d + _tmp143
	  add $t0, $t7, $t0	
	# _tmp145 = *(_tmp144)
	  lw $t0, 0($t0) 	# load with offset
	# PushParam c
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t6, 4($sp)	# copy param value to stack
	# PushParam _tmp145
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp133
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t4, 4($sp)	# copy param value to stack
	# _tmp146 = LCall _Binky
	  sw $t5, -452($fp)	# spill _tmp132 from $t5 to $fp-452
	  jal _Binky         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t5, -452($fp)	# fill _tmp132 to $t5 from $fp-452
	# PopParams 12
	  add $sp, $sp, 12	# pop params off stack
	# _tmp147 = _tmp132 * _tmp146
	  mul $t0, $t5, $t0	
	# PushParam _tmp147
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
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
