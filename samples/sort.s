	# standard Decaf preamble 
	  .text
	  .align 2
	  .globl main
  _ReadArray:
	# BeginFunc 128
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 128	# decrement sp to make space for locals/temps
	# _tmp0 = "How many scores? "
	  .data			# create string constant marked with label
	  _string1: .asciiz "How many scores? "
	  .text
	  la $t0, _string1	# load label
	# PushParam _tmp0
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp1 = LCall _ReadInteger
	  jal _ReadInteger   	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# numScores = _tmp1
	  move $t2, $t0	# copy regs
	# _tmp2 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp3 = numScores < _tmp2
	  slt $t0, $t2, $t0	
	# IfZ _tmp3 Goto _L0
	  beqz $t0, _L0	# branch if _tmp3 is zero 
	# _tmp4 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string2: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t0, _string2	# load label
	# PushParam _tmp4
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, -20($fp)	# spill numScores from $t2 to $fp-20
	  jal _PrintString   	# jump to function
	  lw $t2, -20($fp)	# fill numScores to $t2 from $fp-20
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t2, -20($fp)	# spill numScores from $t2 to $fp-20
	  jal _Halt          	# jump to function
	  lw $t2, -20($fp)	# fill numScores to $t2 from $fp-20
  _L0:
	# _tmp5 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp6 = _tmp5 + numScores
	  add $t0, $t0, $t2	
	# _tmp7 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp8 = _tmp6 * _tmp7
	  mul $t0, $t0, $t1	
	# PushParam _tmp8
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp9 = LCall _Alloc
	  sw $t2, -20($fp)	# spill numScores from $t2 to $fp-20
	  sw $t1, -52($fp)	# spill _tmp7 from $t1 to $fp-52
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t2, -20($fp)	# fill numScores to $t2 from $fp-20
	  lw $t1, -52($fp)	# fill _tmp7 to $t1 from $fp-52
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp9) = numScores
	  sw $t2, 0($t0) 	# store with offset
	# _tmp10 = _tmp9 + _tmp7
	  add $t0, $t0, $t1	
	# arr = _tmp10
	  move $t3, $t0	# copy regs
	# _tmp11 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp11
	  move $t5, $t0	# copy regs
  _L1:
	# _tmp12 = *(arr + -4)
	  lw $t0, -4($t3) 	# load with offset
	# _tmp13 = i < _tmp12
	  slt $t0, $t5, $t0	
	# IfZ _tmp13 Goto _L2
	  beqz $t0, _L2	# branch if _tmp13 is zero 
	# _tmp14 = "Enter next number: "
	  .data			# create string constant marked with label
	  _string3: .asciiz "Enter next number: "
	  .text
	  la $t0, _string3	# load label
	# PushParam _tmp14
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t3, -16($fp)	# spill arr from $t3 to $fp-16
	  jal _PrintString   	# jump to function
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t3, -16($fp)	# fill arr to $t3 from $fp-16
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp15 = LCall _ReadInteger
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t3, -16($fp)	# spill arr from $t3 to $fp-16
	  jal _ReadInteger   	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t3, -16($fp)	# fill arr to $t3 from $fp-16
	# num = _tmp15
	  move $t4, $t0	# copy regs
	# _tmp16 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp17 = i < _tmp16
	  slt $t1, $t5, $t2	
	# _tmp18 = *(arr + -4)
	  lw $t0, -4($t3) 	# load with offset
	# _tmp19 = i < _tmp18
	  slt $t0, $t5, $t0	
	# _tmp20 = _tmp19 == _tmp16
	  seq $t0, $t0, $t2	
	# _tmp21 = _tmp17 || _tmp20
	  or $t0, $t1, $t0	
	# IfZ _tmp21 Goto _L3
	  beqz $t0, _L3	# branch if _tmp21 is zero 
	# _tmp22 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string4: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string4	# load label
	# PushParam _tmp22
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t4, -12($fp)	# spill num from $t4 to $fp-12
	  sw $t3, -16($fp)	# spill arr from $t3 to $fp-16
	  jal _PrintString   	# jump to function
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t4, -12($fp)	# fill num to $t4 from $fp-12
	  lw $t3, -16($fp)	# fill arr to $t3 from $fp-16
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t4, -12($fp)	# spill num from $t4 to $fp-12
	  sw $t3, -16($fp)	# spill arr from $t3 to $fp-16
	  jal _Halt          	# jump to function
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t4, -12($fp)	# fill num to $t4 from $fp-12
	  lw $t3, -16($fp)	# fill arr to $t3 from $fp-16
  _L3:
	# _tmp23 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp24 = _tmp23 * i
	  mul $t0, $t0, $t5	
	# _tmp25 = arr + _tmp24
	  add $t0, $t3, $t0	
	# *(_tmp25) = num
	  sw $t4, 0($t0) 	# store with offset
	# _tmp26 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp27 = i + _tmp26
	  add $t0, $t5, $t0	
	# i = _tmp27
	  move $t5, $t0	# copy regs
	# Goto _L1
	  b _L1		# unconditional branch
  _L2:
	# Return arr
	  move $v0, $t3		# assign return value into $v0
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
  _Sort:
	# BeginFunc 304
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 304	# decrement sp to make space for locals/temps
	  lw $t4, 4($fp)	# fill arr to $t4 from $fp+4
	# _tmp28 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# i = _tmp28
	  move $t5, $t0	# copy regs
  _L4:
	# _tmp29 = *(arr + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp30 = i < _tmp29
	  slt $t0, $t5, $t0	
	# IfZ _tmp30 Goto _L5
	  beqz $t0, _L5	# branch if _tmp30 is zero 
	# _tmp31 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp32 = i - _tmp31
	  sub $t0, $t5, $t0	
	# j = _tmp32
	  move $t7, $t0	# copy regs
	# _tmp33 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp34 = i < _tmp33
	  slt $t1, $t5, $t2	
	# _tmp35 = *(arr + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp36 = i < _tmp35
	  slt $t0, $t5, $t0	
	# _tmp37 = _tmp36 == _tmp33
	  seq $t0, $t0, $t2	
	# _tmp38 = _tmp34 || _tmp37
	  or $t0, $t1, $t0	
	# IfZ _tmp38 Goto _L6
	  beqz $t0, _L6	# branch if _tmp38 is zero 
	# _tmp39 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string5: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string5	# load label
	# PushParam _tmp39
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t4, 4($fp)	# spill arr from $t4 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t7, -12($fp)	# spill j from $t7 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t4, 4($fp)	# fill arr to $t4 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t7, -12($fp)	# fill j to $t7 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t4, 4($fp)	# spill arr from $t4 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t7, -12($fp)	# spill j from $t7 to $fp-12
	  jal _Halt          	# jump to function
	  lw $t4, 4($fp)	# fill arr to $t4 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t7, -12($fp)	# fill j to $t7 from $fp-12
  _L6:
	# _tmp40 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp41 = _tmp40 * i
	  mul $t0, $t0, $t5	
	# _tmp42 = arr + _tmp41
	  add $t0, $t4, $t0	
	# _tmp43 = *(_tmp42)
	  lw $t0, 0($t0) 	# load with offset
	# val = _tmp43
	  move $t6, $t0	# copy regs
  _L7:
	# _tmp44 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp45 = _tmp44 < j
	  slt $t1, $t0, $t7	
	# _tmp46 = _tmp44 == j
	  seq $t0, $t0, $t7	
	# _tmp47 = _tmp45 || _tmp46
	  or $t0, $t1, $t0	
	# IfZ _tmp47 Goto _L8
	  beqz $t0, _L8	# branch if _tmp47 is zero 
	# _tmp48 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp49 = j < _tmp48
	  slt $t1, $t7, $t2	
	# _tmp50 = *(arr + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp51 = j < _tmp50
	  slt $t0, $t7, $t0	
	# _tmp52 = _tmp51 == _tmp48
	  seq $t0, $t0, $t2	
	# _tmp53 = _tmp49 || _tmp52
	  or $t0, $t1, $t0	
	# IfZ _tmp53 Goto _L9
	  beqz $t0, _L9	# branch if _tmp53 is zero 
	# _tmp54 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string6: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string6	# load label
	# PushParam _tmp54
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t4, 4($fp)	# spill arr from $t4 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t7, -12($fp)	# spill j from $t7 to $fp-12
	  sw $t6, -16($fp)	# spill val from $t6 to $fp-16
	  jal _PrintString   	# jump to function
	  lw $t4, 4($fp)	# fill arr to $t4 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t7, -12($fp)	# fill j to $t7 from $fp-12
	  lw $t6, -16($fp)	# fill val to $t6 from $fp-16
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t4, 4($fp)	# spill arr from $t4 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t7, -12($fp)	# spill j from $t7 to $fp-12
	  sw $t6, -16($fp)	# spill val from $t6 to $fp-16
	  jal _Halt          	# jump to function
	  lw $t4, 4($fp)	# fill arr to $t4 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t7, -12($fp)	# fill j to $t7 from $fp-12
	  lw $t6, -16($fp)	# fill val to $t6 from $fp-16
  _L9:
	# _tmp55 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp56 = _tmp55 * j
	  mul $t0, $t0, $t7	
	# _tmp57 = arr + _tmp56
	  add $t0, $t4, $t0	
	# _tmp58 = *(_tmp57)
	  lw $t0, 0($t0) 	# load with offset
	# _tmp59 = _tmp58 < val
	  slt $t1, $t0, $t6	
	# _tmp60 = _tmp58 == val
	  seq $t0, $t0, $t6	
	# _tmp61 = _tmp59 || _tmp60
	  or $t0, $t1, $t0	
	# IfZ _tmp61 Goto _L10
	  beqz $t0, _L10	# branch if _tmp61 is zero 
	# Goto _L8
	  b _L8		# unconditional branch
  _L10:
	# _tmp62 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp63 = j + _tmp62
	  add $t3, $t7, $t0	
	# _tmp64 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp65 = _tmp63 < _tmp64
	  slt $t1, $t3, $t2	
	# _tmp66 = *(arr + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp67 = _tmp63 < _tmp66
	  slt $t0, $t3, $t0	
	# _tmp68 = _tmp67 == _tmp64
	  seq $t0, $t0, $t2	
	# _tmp69 = _tmp65 || _tmp68
	  or $t0, $t1, $t0	
	# IfZ _tmp69 Goto _L11
	  beqz $t0, _L11	# branch if _tmp69 is zero 
	# _tmp70 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string7: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string7	# load label
	# PushParam _tmp70
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t4, 4($fp)	# spill arr from $t4 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t7, -12($fp)	# spill j from $t7 to $fp-12
	  sw $t6, -16($fp)	# spill val from $t6 to $fp-16
	  sw $t3, -160($fp)	# spill _tmp63 from $t3 to $fp-160
	  jal _PrintString   	# jump to function
	  lw $t4, 4($fp)	# fill arr to $t4 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t7, -12($fp)	# fill j to $t7 from $fp-12
	  lw $t6, -16($fp)	# fill val to $t6 from $fp-16
	  lw $t3, -160($fp)	# fill _tmp63 to $t3 from $fp-160
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t4, 4($fp)	# spill arr from $t4 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t7, -12($fp)	# spill j from $t7 to $fp-12
	  sw $t6, -16($fp)	# spill val from $t6 to $fp-16
	  sw $t3, -160($fp)	# spill _tmp63 from $t3 to $fp-160
	  jal _Halt          	# jump to function
	  lw $t4, 4($fp)	# fill arr to $t4 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t7, -12($fp)	# fill j to $t7 from $fp-12
	  lw $t6, -16($fp)	# fill val to $t6 from $fp-16
	  lw $t3, -160($fp)	# fill _tmp63 to $t3 from $fp-160
  _L11:
	# _tmp71 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp72 = _tmp71 * _tmp63
	  mul $t0, $t0, $t3	
	# _tmp73 = arr + _tmp72
	  add $t3, $t4, $t0	
	# _tmp74 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp75 = j < _tmp74
	  slt $t1, $t7, $t2	
	# _tmp76 = *(arr + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp77 = j < _tmp76
	  slt $t0, $t7, $t0	
	# _tmp78 = _tmp77 == _tmp74
	  seq $t0, $t0, $t2	
	# _tmp79 = _tmp75 || _tmp78
	  or $t0, $t1, $t0	
	# IfZ _tmp79 Goto _L12
	  beqz $t0, _L12	# branch if _tmp79 is zero 
	# _tmp80 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string8: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string8	# load label
	# PushParam _tmp80
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t4, 4($fp)	# spill arr from $t4 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t7, -12($fp)	# spill j from $t7 to $fp-12
	  sw $t6, -16($fp)	# spill val from $t6 to $fp-16
	  sw $t3, -200($fp)	# spill _tmp73 from $t3 to $fp-200
	  jal _PrintString   	# jump to function
	  lw $t4, 4($fp)	# fill arr to $t4 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t7, -12($fp)	# fill j to $t7 from $fp-12
	  lw $t6, -16($fp)	# fill val to $t6 from $fp-16
	  lw $t3, -200($fp)	# fill _tmp73 to $t3 from $fp-200
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t4, 4($fp)	# spill arr from $t4 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t7, -12($fp)	# spill j from $t7 to $fp-12
	  sw $t6, -16($fp)	# spill val from $t6 to $fp-16
	  sw $t3, -200($fp)	# spill _tmp73 from $t3 to $fp-200
	  jal _Halt          	# jump to function
	  lw $t4, 4($fp)	# fill arr to $t4 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t7, -12($fp)	# fill j to $t7 from $fp-12
	  lw $t6, -16($fp)	# fill val to $t6 from $fp-16
	  lw $t3, -200($fp)	# fill _tmp73 to $t3 from $fp-200
  _L12:
	# _tmp81 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp82 = _tmp81 * j
	  mul $t0, $t0, $t7	
	# _tmp83 = arr + _tmp82
	  add $t0, $t4, $t0	
	# _tmp84 = *(_tmp83)
	  lw $t0, 0($t0) 	# load with offset
	# *(_tmp73) = _tmp84
	  sw $t0, 0($t3) 	# store with offset
	# _tmp85 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp86 = j - _tmp85
	  sub $t0, $t7, $t0	
	# j = _tmp86
	  move $t7, $t0	# copy regs
	# Goto _L7
	  b _L7		# unconditional branch
  _L8:
	# _tmp87 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp88 = j + _tmp87
	  add $t3, $t7, $t0	
	# _tmp89 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp90 = _tmp88 < _tmp89
	  slt $t1, $t3, $t2	
	# _tmp91 = *(arr + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp92 = _tmp88 < _tmp91
	  slt $t0, $t3, $t0	
	# _tmp93 = _tmp92 == _tmp89
	  seq $t0, $t0, $t2	
	# _tmp94 = _tmp90 || _tmp93
	  or $t0, $t1, $t0	
	# IfZ _tmp94 Goto _L13
	  beqz $t0, _L13	# branch if _tmp94 is zero 
	# _tmp95 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string9: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string9	# load label
	# PushParam _tmp95
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t4, 4($fp)	# spill arr from $t4 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t6, -16($fp)	# spill val from $t6 to $fp-16
	  sw $t3, -260($fp)	# spill _tmp88 from $t3 to $fp-260
	  jal _PrintString   	# jump to function
	  lw $t4, 4($fp)	# fill arr to $t4 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t6, -16($fp)	# fill val to $t6 from $fp-16
	  lw $t3, -260($fp)	# fill _tmp88 to $t3 from $fp-260
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t4, 4($fp)	# spill arr from $t4 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t6, -16($fp)	# spill val from $t6 to $fp-16
	  sw $t3, -260($fp)	# spill _tmp88 from $t3 to $fp-260
	  jal _Halt          	# jump to function
	  lw $t4, 4($fp)	# fill arr to $t4 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t6, -16($fp)	# fill val to $t6 from $fp-16
	  lw $t3, -260($fp)	# fill _tmp88 to $t3 from $fp-260
  _L13:
	# _tmp96 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp97 = _tmp96 * _tmp88
	  mul $t0, $t0, $t3	
	# _tmp98 = arr + _tmp97
	  add $t0, $t4, $t0	
	# *(_tmp98) = val
	  sw $t6, 0($t0) 	# store with offset
	# _tmp99 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp100 = i + _tmp99
	  add $t0, $t5, $t0	
	# i = _tmp100
	  move $t5, $t0	# copy regs
	# Goto _L4
	  b _L4		# unconditional branch
  _L5:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _PrintArray:
	# BeginFunc 80
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 80	# decrement sp to make space for locals/temps
	  lw $t3, 4($fp)	# fill arr to $t3 from $fp+4
	# _tmp101 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp101
	  move $t4, $t0	# copy regs
	# _tmp102 = "Sorted results: "
	  .data			# create string constant marked with label
	  _string10: .asciiz "Sorted results: "
	  .text
	  la $t0, _string10	# load label
	# PushParam _tmp102
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill arr from $t3 to $fp+4
	  sw $t4, -8($fp)	# spill i from $t4 to $fp-8
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill arr to $t3 from $fp+4
	  lw $t4, -8($fp)	# fill i to $t4 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L14:
	# _tmp103 = *(arr + -4)
	  lw $t0, -4($t3) 	# load with offset
	# _tmp104 = i < _tmp103
	  slt $t0, $t4, $t0	
	# IfZ _tmp104 Goto _L15
	  beqz $t0, _L15	# branch if _tmp104 is zero 
	# _tmp105 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp106 = i < _tmp105
	  slt $t1, $t4, $t2	
	# _tmp107 = *(arr + -4)
	  lw $t0, -4($t3) 	# load with offset
	# _tmp108 = i < _tmp107
	  slt $t0, $t4, $t0	
	# _tmp109 = _tmp108 == _tmp105
	  seq $t0, $t0, $t2	
	# _tmp110 = _tmp106 || _tmp109
	  or $t0, $t1, $t0	
	# IfZ _tmp110 Goto _L16
	  beqz $t0, _L16	# branch if _tmp110 is zero 
	# _tmp111 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string11: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string11	# load label
	# PushParam _tmp111
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill arr from $t3 to $fp+4
	  sw $t4, -8($fp)	# spill i from $t4 to $fp-8
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill arr to $t3 from $fp+4
	  lw $t4, -8($fp)	# fill i to $t4 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t3, 4($fp)	# spill arr from $t3 to $fp+4
	  sw $t4, -8($fp)	# spill i from $t4 to $fp-8
	  jal _Halt          	# jump to function
	  lw $t3, 4($fp)	# fill arr to $t3 from $fp+4
	  lw $t4, -8($fp)	# fill i to $t4 from $fp-8
  _L16:
	# _tmp112 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp113 = _tmp112 * i
	  mul $t0, $t0, $t4	
	# _tmp114 = arr + _tmp113
	  add $t0, $t3, $t0	
	# _tmp115 = *(_tmp114)
	  lw $t0, 0($t0) 	# load with offset
	# PushParam _tmp115
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  sw $t3, 4($fp)	# spill arr from $t3 to $fp+4
	  sw $t4, -8($fp)	# spill i from $t4 to $fp-8
	  jal _PrintInt      	# jump to function
	  lw $t3, 4($fp)	# fill arr to $t3 from $fp+4
	  lw $t4, -8($fp)	# fill i to $t4 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp116 = " "
	  .data			# create string constant marked with label
	  _string12: .asciiz " "
	  .text
	  la $t0, _string12	# load label
	# PushParam _tmp116
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill arr from $t3 to $fp+4
	  sw $t4, -8($fp)	# spill i from $t4 to $fp-8
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill arr to $t3 from $fp+4
	  lw $t4, -8($fp)	# fill i to $t4 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp117 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp118 = i + _tmp117
	  add $t0, $t4, $t0	
	# i = _tmp118
	  move $t4, $t0	# copy regs
	# Goto _L14
	  b _L14		# unconditional branch
  _L15:
	# _tmp119 = "\n"
	  .data			# create string constant marked with label
	  _string13: .asciiz "\n"
	  .text
	  la $t0, _string13	# load label
	# PushParam _tmp119
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
  main:
	# BeginFunc 16
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 16	# decrement sp to make space for locals/temps
	# _tmp120 = "\nThis program will read in a bunch of numbers an..."
	  .data			# create string constant marked with label
	  _string14: .asciiz "\nThis program will read in a bunch of numbers and print them\n"
	  .text
	  la $t0, _string14	# load label
	# PushParam _tmp120
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp121 = "back out in sorted order.\n\n"
	  .data			# create string constant marked with label
	  _string15: .asciiz "back out in sorted order.\n\n"
	  .text
	  la $t0, _string15	# load label
	# PushParam _tmp121
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp122 = LCall _ReadArray
	  jal _ReadArray     	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# arr = _tmp122
	  move $t0, $t0	# copy regs
	# PushParam arr
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _Sort
	  sw $t0, -8($fp)	# spill arr from $t0 to $fp-8
	  jal _Sort          	# jump to function
	  lw $t0, -8($fp)	# fill arr to $t0 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam arr
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintArray
	  jal _PrintArray    	# jump to function
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
