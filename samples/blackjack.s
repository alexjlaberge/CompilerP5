	# standard Decaf preamble 
	  .text
	  .align 2
	  .globl main
  _Random.Init:
	# BeginFunc 0
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t0, 8($fp)	# fill seedVal to $t0 from $fp+8
	# *(this + 4) = seedVal
	  sw $t0, 4($t3) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Random.GenRandom:
	# BeginFunc 40
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 40	# decrement sp to make space for locals/temps
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# _tmp0 = 15625
	  li $t2, 15625		# load constant value 15625 into $t2
	# _tmp1 = *(this + 4)
	  lw $t1, 4($t3) 	# load with offset
	# _tmp2 = 10000
	  li $t0, 10000		# load constant value 10000 into $t0
	# _tmp3 = _tmp1 % _tmp2
	  rem $t0, $t1, $t0	
	# _tmp4 = _tmp0 * _tmp3
	  mul $t1, $t2, $t0	
	# _tmp5 = 22221
	  li $t0, 22221		# load constant value 22221 into $t0
	# _tmp6 = _tmp4 + _tmp5
	  add $t1, $t1, $t0	
	# _tmp7 = 65536
	  li $t0, 65536		# load constant value 65536 into $t0
	# _tmp8 = _tmp6 % _tmp7
	  rem $t0, $t1, $t0	
	# *(this + 4) = _tmp8
	  sw $t0, 4($t3) 	# store with offset
	# _tmp9 = *(this + 4)
	  lw $t0, 4($t3) 	# load with offset
	# Return _tmp9
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
  _Random.RndInt:
	# BeginFunc 16
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 16	# decrement sp to make space for locals/temps
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t1, 8($fp)	# fill max to $t1 from $fp+8
	# _tmp10 = *(this)
	  lw $t0, 0($t3) 	# load with offset
	# _tmp11 = *(_tmp10 + 4)
	  lw $t0, 4($t0) 	# load with offset
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# _tmp12 = ACall _tmp11
	  sw $t1, 8($fp)	# spill max from $t1 to $fp+8
	  jalr $t0            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t1, 8($fp)	# fill max to $t1 from $fp+8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp13 = _tmp12 % max
	  rem $t0, $t0, $t1	
	# Return _tmp13
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
	# VTable for class Random
	  .data
	  .align 2
	  Random:		# label for class Random vtable
	  .word _Random.Init
	  .word _Random.GenRandom
	  .word _Random.RndInt
	  .text
  _Deck.Init:
	# BeginFunc 40
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 40	# decrement sp to make space for locals/temps
	  lw $t5, 4($fp)	# fill this to $t5 from $fp+4
	# _tmp14 = 52
	  li $t2, 52		# load constant value 52 into $t2
	# _tmp15 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp16 = _tmp14 < _tmp15
	  slt $t0, $t2, $t0	
	# IfZ _tmp16 Goto _L0
	  beqz $t0, _L0	# branch if _tmp16 is zero 
	# _tmp17 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string1: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t0, _string1	# load label
	# PushParam _tmp17
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t5, 4($fp)	# spill this from $t5 to $fp+4
	  sw $t2, -8($fp)	# spill _tmp14 from $t2 to $fp-8
	  jal _PrintString   	# jump to function
	  lw $t5, 4($fp)	# fill this to $t5 from $fp+4
	  lw $t2, -8($fp)	# fill _tmp14 to $t2 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t5, 4($fp)	# spill this from $t5 to $fp+4
	  sw $t2, -8($fp)	# spill _tmp14 from $t2 to $fp-8
	  jal _Halt          	# jump to function
	  lw $t5, 4($fp)	# fill this to $t5 from $fp+4
	  lw $t2, -8($fp)	# fill _tmp14 to $t2 from $fp-8
  _L0:
	# _tmp18 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp19 = _tmp18 + _tmp14
	  add $t0, $t0, $t2	
	# _tmp20 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp21 = _tmp19 * _tmp20
	  mul $t0, $t0, $t1	
	# PushParam _tmp21
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp22 = LCall _Alloc
	  sw $t5, 4($fp)	# spill this from $t5 to $fp+4
	  sw $t2, -8($fp)	# spill _tmp14 from $t2 to $fp-8
	  sw $t1, -32($fp)	# spill _tmp20 from $t1 to $fp-32
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t5, 4($fp)	# fill this to $t5 from $fp+4
	  lw $t2, -8($fp)	# fill _tmp14 to $t2 from $fp-8
	  lw $t1, -32($fp)	# fill _tmp20 to $t1 from $fp-32
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp22) = _tmp14
	  sw $t2, 0($t0) 	# store with offset
	# _tmp23 = _tmp22 + _tmp20
	  add $t0, $t0, $t1	
	# *(this + 8) = _tmp23
	  sw $t0, 8($t5) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Deck.Shuffle:
	# BeginFunc 336
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 336	# decrement sp to make space for locals/temps
	  lw $t5, 4($fp)	# fill this to $t5 from $fp+4
	# _tmp24 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# *(this + 4) = _tmp24
	  sw $t0, 4($t5) 	# store with offset
  _L1:
	# _tmp25 = *(this + 4)
	  lw $t1, 4($t5) 	# load with offset
	# _tmp26 = 52
	  li $t0, 52		# load constant value 52 into $t0
	# _tmp27 = _tmp25 < _tmp26
	  slt $t0, $t1, $t0	
	# IfZ _tmp27 Goto _L2
	  beqz $t0, _L2	# branch if _tmp27 is zero 
	# _tmp28 = *(this + 8)
	  lw $t4, 8($t5) 	# load with offset
	# _tmp29 = *(this + 4)
	  lw $t3, 4($t5) 	# load with offset
	# _tmp30 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp31 = _tmp29 < _tmp30
	  slt $t1, $t3, $t2	
	# _tmp32 = *(_tmp28 + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp33 = _tmp29 < _tmp32
	  slt $t0, $t3, $t0	
	# _tmp34 = _tmp33 == _tmp30
	  seq $t0, $t0, $t2	
	# _tmp35 = _tmp31 || _tmp34
	  or $t0, $t1, $t0	
	# IfZ _tmp35 Goto _L3
	  beqz $t0, _L3	# branch if _tmp35 is zero 
	# _tmp36 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string2: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string2	# load label
	# PushParam _tmp36
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t5, 4($fp)	# spill this from $t5 to $fp+4
	  sw $t4, -24($fp)	# spill _tmp28 from $t4 to $fp-24
	  sw $t3, -28($fp)	# spill _tmp29 from $t3 to $fp-28
	  jal _PrintString   	# jump to function
	  lw $t5, 4($fp)	# fill this to $t5 from $fp+4
	  lw $t4, -24($fp)	# fill _tmp28 to $t4 from $fp-24
	  lw $t3, -28($fp)	# fill _tmp29 to $t3 from $fp-28
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t5, 4($fp)	# spill this from $t5 to $fp+4
	  sw $t4, -24($fp)	# spill _tmp28 from $t4 to $fp-24
	  sw $t3, -28($fp)	# spill _tmp29 from $t3 to $fp-28
	  jal _Halt          	# jump to function
	  lw $t5, 4($fp)	# fill this to $t5 from $fp+4
	  lw $t4, -24($fp)	# fill _tmp28 to $t4 from $fp-24
	  lw $t3, -28($fp)	# fill _tmp29 to $t3 from $fp-28
  _L3:
	# _tmp37 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp38 = _tmp37 * _tmp29
	  mul $t0, $t0, $t3	
	# _tmp39 = _tmp28 + _tmp38
	  add $t2, $t4, $t0	
	# _tmp40 = *(this + 4)
	  lw $t1, 4($t5) 	# load with offset
	# _tmp41 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp42 = _tmp40 + _tmp41
	  add $t1, $t1, $t0	
	# _tmp43 = 13
	  li $t0, 13		# load constant value 13 into $t0
	# _tmp44 = _tmp42 % _tmp43
	  rem $t0, $t1, $t0	
	# *(_tmp39) = _tmp44
	  sw $t0, 0($t2) 	# store with offset
	# _tmp45 = *(this + 4)
	  lw $t1, 4($t5) 	# load with offset
	# _tmp46 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp47 = _tmp45 + _tmp46
	  add $t0, $t1, $t0	
	# *(this + 4) = _tmp47
	  sw $t0, 4($t5) 	# store with offset
	# Goto _L1
	  b _L1		# unconditional branch
  _L2:
  _L4:
	# _tmp48 = *(this + 4)
	  lw $t1, 4($t5) 	# load with offset
	# _tmp49 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp50 = _tmp49 < _tmp48
	  slt $t0, $t0, $t1	
	# IfZ _tmp50 Goto _L5
	  beqz $t0, _L5	# branch if _tmp50 is zero 
	# _tmp51 = *(this + 4)
	  lw $t1, 4($t5) 	# load with offset
	# _tmp52 = *(gRnd)
	  lw $v0, 0($gp)	# fill gRnd to $v0 from $gp+0
	  lw $t0, 0($v0) 	# load with offset
	# _tmp53 = *(_tmp52 + 8)
	  lw $t0, 8($t0) 	# load with offset
	# PushParam _tmp51
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# PushParam gRnd
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $v0, 0($gp)	# fill gRnd to $v0 from $gp+0
	  sw $v0, 4($sp)	# copy param value to stack
	# _tmp54 = ACall _tmp53
	  sw $t5, 4($fp)	# spill this from $t5 to $fp+4
	  jalr $t0            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t5, 4($fp)	# fill this to $t5 from $fp+4
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# r = _tmp54
	  move $t6, $t0	# copy regs
	# _tmp55 = *(this + 4)
	  lw $t1, 4($t5) 	# load with offset
	# _tmp56 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp57 = _tmp55 - _tmp56
	  sub $t0, $t1, $t0	
	# *(this + 4) = _tmp57
	  sw $t0, 4($t5) 	# store with offset
	# _tmp58 = *(this + 8)
	  lw $t4, 8($t5) 	# load with offset
	# _tmp59 = *(this + 4)
	  lw $t3, 4($t5) 	# load with offset
	# _tmp60 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp61 = _tmp59 < _tmp60
	  slt $t1, $t3, $t2	
	# _tmp62 = *(_tmp58 + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp63 = _tmp59 < _tmp62
	  slt $t0, $t3, $t0	
	# _tmp64 = _tmp63 == _tmp60
	  seq $t0, $t0, $t2	
	# _tmp65 = _tmp61 || _tmp64
	  or $t0, $t1, $t0	
	# IfZ _tmp65 Goto _L6
	  beqz $t0, _L6	# branch if _tmp65 is zero 
	# _tmp66 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string3: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string3	# load label
	# PushParam _tmp66
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t5, 4($fp)	# spill this from $t5 to $fp+4
	  sw $t6, -116($fp)	# spill r from $t6 to $fp-116
	  sw $t4, -152($fp)	# spill _tmp58 from $t4 to $fp-152
	  sw $t3, -156($fp)	# spill _tmp59 from $t3 to $fp-156
	  jal _PrintString   	# jump to function
	  lw $t5, 4($fp)	# fill this to $t5 from $fp+4
	  lw $t6, -116($fp)	# fill r to $t6 from $fp-116
	  lw $t4, -152($fp)	# fill _tmp58 to $t4 from $fp-152
	  lw $t3, -156($fp)	# fill _tmp59 to $t3 from $fp-156
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t5, 4($fp)	# spill this from $t5 to $fp+4
	  sw $t6, -116($fp)	# spill r from $t6 to $fp-116
	  sw $t4, -152($fp)	# spill _tmp58 from $t4 to $fp-152
	  sw $t3, -156($fp)	# spill _tmp59 from $t3 to $fp-156
	  jal _Halt          	# jump to function
	  lw $t5, 4($fp)	# fill this to $t5 from $fp+4
	  lw $t6, -116($fp)	# fill r to $t6 from $fp-116
	  lw $t4, -152($fp)	# fill _tmp58 to $t4 from $fp-152
	  lw $t3, -156($fp)	# fill _tmp59 to $t3 from $fp-156
  _L6:
	# _tmp67 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp68 = _tmp67 * _tmp59
	  mul $t0, $t0, $t3	
	# _tmp69 = _tmp58 + _tmp68
	  add $t0, $t4, $t0	
	# _tmp70 = *(_tmp69)
	  lw $t0, 0($t0) 	# load with offset
	# temp = _tmp70
	  move $t4, $t0	# copy regs
	# _tmp71 = *(this + 8)
	  lw $t7, 8($t5) 	# load with offset
	# _tmp72 = *(this + 4)
	  lw $t3, 4($t5) 	# load with offset
	# _tmp73 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp74 = _tmp72 < _tmp73
	  slt $t1, $t3, $t2	
	# _tmp75 = *(_tmp71 + -4)
	  lw $t0, -4($t7) 	# load with offset
	# _tmp76 = _tmp72 < _tmp75
	  slt $t0, $t3, $t0	
	# _tmp77 = _tmp76 == _tmp73
	  seq $t0, $t0, $t2	
	# _tmp78 = _tmp74 || _tmp77
	  or $t0, $t1, $t0	
	# IfZ _tmp78 Goto _L7
	  beqz $t0, _L7	# branch if _tmp78 is zero 
	# _tmp79 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string4: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string4	# load label
	# PushParam _tmp79
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t5, 4($fp)	# spill this from $t5 to $fp+4
	  sw $t6, -116($fp)	# spill r from $t6 to $fp-116
	  sw $t4, -120($fp)	# spill temp from $t4 to $fp-120
	  sw $t7, -204($fp)	# spill _tmp71 from $t7 to $fp-204
	  sw $t3, -208($fp)	# spill _tmp72 from $t3 to $fp-208
	  jal _PrintString   	# jump to function
	  lw $t5, 4($fp)	# fill this to $t5 from $fp+4
	  lw $t6, -116($fp)	# fill r to $t6 from $fp-116
	  lw $t4, -120($fp)	# fill temp to $t4 from $fp-120
	  lw $t7, -204($fp)	# fill _tmp71 to $t7 from $fp-204
	  lw $t3, -208($fp)	# fill _tmp72 to $t3 from $fp-208
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t5, 4($fp)	# spill this from $t5 to $fp+4
	  sw $t6, -116($fp)	# spill r from $t6 to $fp-116
	  sw $t4, -120($fp)	# spill temp from $t4 to $fp-120
	  sw $t7, -204($fp)	# spill _tmp71 from $t7 to $fp-204
	  sw $t3, -208($fp)	# spill _tmp72 from $t3 to $fp-208
	  jal _Halt          	# jump to function
	  lw $t5, 4($fp)	# fill this to $t5 from $fp+4
	  lw $t6, -116($fp)	# fill r to $t6 from $fp-116
	  lw $t4, -120($fp)	# fill temp to $t4 from $fp-120
	  lw $t7, -204($fp)	# fill _tmp71 to $t7 from $fp-204
	  lw $t3, -208($fp)	# fill _tmp72 to $t3 from $fp-208
  _L7:
	# _tmp80 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp81 = _tmp80 * _tmp72
	  mul $t0, $t0, $t3	
	# _tmp82 = _tmp71 + _tmp81
	  add $t7, $t7, $t0	
	# _tmp83 = *(this + 8)
	  lw $t3, 8($t5) 	# load with offset
	# _tmp84 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp85 = r < _tmp84
	  slt $t1, $t6, $t2	
	# _tmp86 = *(_tmp83 + -4)
	  lw $t0, -4($t3) 	# load with offset
	# _tmp87 = r < _tmp86
	  slt $t0, $t6, $t0	
	# _tmp88 = _tmp87 == _tmp84
	  seq $t0, $t0, $t2	
	# _tmp89 = _tmp85 || _tmp88
	  or $t0, $t1, $t0	
	# IfZ _tmp89 Goto _L8
	  beqz $t0, _L8	# branch if _tmp89 is zero 
	# _tmp90 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string5: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string5	# load label
	# PushParam _tmp90
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t5, 4($fp)	# spill this from $t5 to $fp+4
	  sw $t6, -116($fp)	# spill r from $t6 to $fp-116
	  sw $t4, -120($fp)	# spill temp from $t4 to $fp-120
	  sw $t7, -248($fp)	# spill _tmp82 from $t7 to $fp-248
	  sw $t3, -252($fp)	# spill _tmp83 from $t3 to $fp-252
	  jal _PrintString   	# jump to function
	  lw $t5, 4($fp)	# fill this to $t5 from $fp+4
	  lw $t6, -116($fp)	# fill r to $t6 from $fp-116
	  lw $t4, -120($fp)	# fill temp to $t4 from $fp-120
	  lw $t7, -248($fp)	# fill _tmp82 to $t7 from $fp-248
	  lw $t3, -252($fp)	# fill _tmp83 to $t3 from $fp-252
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t5, 4($fp)	# spill this from $t5 to $fp+4
	  sw $t6, -116($fp)	# spill r from $t6 to $fp-116
	  sw $t4, -120($fp)	# spill temp from $t4 to $fp-120
	  sw $t7, -248($fp)	# spill _tmp82 from $t7 to $fp-248
	  sw $t3, -252($fp)	# spill _tmp83 from $t3 to $fp-252
	  jal _Halt          	# jump to function
	  lw $t5, 4($fp)	# fill this to $t5 from $fp+4
	  lw $t6, -116($fp)	# fill r to $t6 from $fp-116
	  lw $t4, -120($fp)	# fill temp to $t4 from $fp-120
	  lw $t7, -248($fp)	# fill _tmp82 to $t7 from $fp-248
	  lw $t3, -252($fp)	# fill _tmp83 to $t3 from $fp-252
  _L8:
	# _tmp91 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp92 = _tmp91 * r
	  mul $t0, $t0, $t6	
	# _tmp93 = _tmp83 + _tmp92
	  add $t0, $t3, $t0	
	# _tmp94 = *(_tmp93)
	  lw $t0, 0($t0) 	# load with offset
	# *(_tmp82) = _tmp94
	  sw $t0, 0($t7) 	# store with offset
	# _tmp95 = *(this + 8)
	  lw $t3, 8($t5) 	# load with offset
	# _tmp96 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp97 = r < _tmp96
	  slt $t1, $t6, $t2	
	# _tmp98 = *(_tmp95 + -4)
	  lw $t0, -4($t3) 	# load with offset
	# _tmp99 = r < _tmp98
	  slt $t0, $t6, $t0	
	# _tmp100 = _tmp99 == _tmp96
	  seq $t0, $t0, $t2	
	# _tmp101 = _tmp97 || _tmp100
	  or $t0, $t1, $t0	
	# IfZ _tmp101 Goto _L9
	  beqz $t0, _L9	# branch if _tmp101 is zero 
	# _tmp102 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string6: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string6	# load label
	# PushParam _tmp102
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t5, 4($fp)	# spill this from $t5 to $fp+4
	  sw $t6, -116($fp)	# spill r from $t6 to $fp-116
	  sw $t4, -120($fp)	# spill temp from $t4 to $fp-120
	  sw $t3, -300($fp)	# spill _tmp95 from $t3 to $fp-300
	  jal _PrintString   	# jump to function
	  lw $t5, 4($fp)	# fill this to $t5 from $fp+4
	  lw $t6, -116($fp)	# fill r to $t6 from $fp-116
	  lw $t4, -120($fp)	# fill temp to $t4 from $fp-120
	  lw $t3, -300($fp)	# fill _tmp95 to $t3 from $fp-300
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t5, 4($fp)	# spill this from $t5 to $fp+4
	  sw $t6, -116($fp)	# spill r from $t6 to $fp-116
	  sw $t4, -120($fp)	# spill temp from $t4 to $fp-120
	  sw $t3, -300($fp)	# spill _tmp95 from $t3 to $fp-300
	  jal _Halt          	# jump to function
	  lw $t5, 4($fp)	# fill this to $t5 from $fp+4
	  lw $t6, -116($fp)	# fill r to $t6 from $fp-116
	  lw $t4, -120($fp)	# fill temp to $t4 from $fp-120
	  lw $t3, -300($fp)	# fill _tmp95 to $t3 from $fp-300
  _L9:
	# _tmp103 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp104 = _tmp103 * r
	  mul $t0, $t0, $t6	
	# _tmp105 = _tmp95 + _tmp104
	  add $t0, $t3, $t0	
	# *(_tmp105) = temp
	  sw $t4, 0($t0) 	# store with offset
	# Goto _L4
	  b _L4		# unconditional branch
  _L5:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Deck.GetCard:
	# BeginFunc 92
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 92	# decrement sp to make space for locals/temps
	  lw $t5, 4($fp)	# fill this to $t5 from $fp+4
	# _tmp106 = *(this + 4)
	  lw $t2, 4($t5) 	# load with offset
	# _tmp107 = 52
	  li $t0, 52		# load constant value 52 into $t0
	# _tmp108 = _tmp107 < _tmp106
	  slt $t1, $t0, $t2	
	# _tmp109 = _tmp107 == _tmp106
	  seq $t0, $t0, $t2	
	# _tmp110 = _tmp108 || _tmp109
	  or $t0, $t1, $t0	
	# IfZ _tmp110 Goto _L10
	  beqz $t0, _L10	# branch if _tmp110 is zero 
	# _tmp111 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# Return _tmp111
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _L10:
	# _tmp112 = *(this + 8)
	  lw $t4, 8($t5) 	# load with offset
	# _tmp113 = *(this + 4)
	  lw $t3, 4($t5) 	# load with offset
	# _tmp114 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp115 = _tmp113 < _tmp114
	  slt $t1, $t3, $t2	
	# _tmp116 = *(_tmp112 + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp117 = _tmp113 < _tmp116
	  slt $t0, $t3, $t0	
	# _tmp118 = _tmp117 == _tmp114
	  seq $t0, $t0, $t2	
	# _tmp119 = _tmp115 || _tmp118
	  or $t0, $t1, $t0	
	# IfZ _tmp119 Goto _L11
	  beqz $t0, _L11	# branch if _tmp119 is zero 
	# _tmp120 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string7: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string7	# load label
	# PushParam _tmp120
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t5, 4($fp)	# spill this from $t5 to $fp+4
	  sw $t4, -36($fp)	# spill _tmp112 from $t4 to $fp-36
	  sw $t3, -40($fp)	# spill _tmp113 from $t3 to $fp-40
	  jal _PrintString   	# jump to function
	  lw $t5, 4($fp)	# fill this to $t5 from $fp+4
	  lw $t4, -36($fp)	# fill _tmp112 to $t4 from $fp-36
	  lw $t3, -40($fp)	# fill _tmp113 to $t3 from $fp-40
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t5, 4($fp)	# spill this from $t5 to $fp+4
	  sw $t4, -36($fp)	# spill _tmp112 from $t4 to $fp-36
	  sw $t3, -40($fp)	# spill _tmp113 from $t3 to $fp-40
	  jal _Halt          	# jump to function
	  lw $t5, 4($fp)	# fill this to $t5 from $fp+4
	  lw $t4, -36($fp)	# fill _tmp112 to $t4 from $fp-36
	  lw $t3, -40($fp)	# fill _tmp113 to $t3 from $fp-40
  _L11:
	# _tmp121 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp122 = _tmp121 * _tmp113
	  mul $t0, $t0, $t3	
	# _tmp123 = _tmp112 + _tmp122
	  add $t0, $t4, $t0	
	# _tmp124 = *(_tmp123)
	  lw $t0, 0($t0) 	# load with offset
	# result = _tmp124
	  move $t2, $t0	# copy regs
	# _tmp125 = *(this + 4)
	  lw $t1, 4($t5) 	# load with offset
	# _tmp126 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp127 = _tmp125 + _tmp126
	  add $t0, $t1, $t0	
	# *(this + 4) = _tmp127
	  sw $t0, 4($t5) 	# store with offset
	# Return result
	  move $v0, $t2		# assign return value into $v0
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
	# VTable for class Deck
	  .data
	  .align 2
	  Deck:		# label for class Deck vtable
	  .word _Deck.Init
	  .word _Deck.Shuffle
	  .word _Deck.GetCard
	  .text
  _BJDeck.Init:
	# BeginFunc 176
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 176	# decrement sp to make space for locals/temps
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# _tmp128 = 8
	  li $t3, 8		# load constant value 8 into $t3
	# _tmp129 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp130 = _tmp128 < _tmp129
	  slt $t0, $t3, $t0	
	# IfZ _tmp130 Goto _L12
	  beqz $t0, _L12	# branch if _tmp130 is zero 
	# _tmp131 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string8: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t0, _string8	# load label
	# PushParam _tmp131
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t3, -12($fp)	# spill _tmp128 from $t3 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t3, -12($fp)	# fill _tmp128 to $t3 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t3, -12($fp)	# spill _tmp128 from $t3 to $fp-12
	  jal _Halt          	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t3, -12($fp)	# fill _tmp128 to $t3 from $fp-12
  _L12:
	# _tmp132 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp133 = _tmp132 + _tmp128
	  add $t0, $t0, $t3	
	# _tmp134 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp135 = _tmp133 * _tmp134
	  mul $t0, $t0, $t1	
	# PushParam _tmp135
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp136 = LCall _Alloc
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t3, -12($fp)	# spill _tmp128 from $t3 to $fp-12
	  sw $t1, -36($fp)	# spill _tmp134 from $t1 to $fp-36
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t3, -12($fp)	# fill _tmp128 to $t3 from $fp-12
	  lw $t1, -36($fp)	# fill _tmp134 to $t1 from $fp-36
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp136) = _tmp128
	  sw $t3, 0($t0) 	# store with offset
	# _tmp137 = _tmp136 + _tmp134
	  add $t0, $t0, $t1	
	# *(this + 4) = _tmp137
	  sw $t0, 4($t2) 	# store with offset
	# _tmp138 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp138
	  move $t5, $t0	# copy regs
  _L13:
	# _tmp139 = 8
	  li $t0, 8		# load constant value 8 into $t0
	# _tmp140 = i < _tmp139
	  slt $t0, $t5, $t0	
	# IfZ _tmp140 Goto _L14
	  beqz $t0, _L14	# branch if _tmp140 is zero 
	# _tmp141 = *(this + 4)
	  lw $t4, 4($t2) 	# load with offset
	# _tmp142 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp143 = i < _tmp142
	  slt $t1, $t5, $t3	
	# _tmp144 = *(_tmp141 + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp145 = i < _tmp144
	  slt $t0, $t5, $t0	
	# _tmp146 = _tmp145 == _tmp142
	  seq $t0, $t0, $t3	
	# _tmp147 = _tmp143 || _tmp146
	  or $t0, $t1, $t0	
	# IfZ _tmp147 Goto _L15
	  beqz $t0, _L15	# branch if _tmp147 is zero 
	# _tmp148 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string9: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string9	# load label
	# PushParam _tmp148
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t4, -64($fp)	# spill _tmp141 from $t4 to $fp-64
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t4, -64($fp)	# fill _tmp141 to $t4 from $fp-64
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t4, -64($fp)	# spill _tmp141 from $t4 to $fp-64
	  jal _Halt          	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t4, -64($fp)	# fill _tmp141 to $t4 from $fp-64
  _L15:
	# _tmp149 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp150 = _tmp149 * i
	  mul $t0, $t0, $t5	
	# _tmp151 = _tmp141 + _tmp150
	  add $t3, $t4, $t0	
	# _tmp152 = 12
	  li $t0, 12		# load constant value 12 into $t0
	# PushParam _tmp152
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp153 = LCall _Alloc
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t3, -104($fp)	# spill _tmp151 from $t3 to $fp-104
	  jal _Alloc         	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t3, -104($fp)	# fill _tmp151 to $t3 from $fp-104
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp154 = Deck
	  la $t0, Deck	# load label
	# *(_tmp153) = _tmp154
	  sw $t0, 0($t1) 	# store with offset
	# *(_tmp151) = _tmp153
	  sw $t1, 0($t3) 	# store with offset
	# _tmp155 = *(this + 4)
	  lw $t4, 4($t2) 	# load with offset
	# _tmp156 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp157 = i < _tmp156
	  slt $t1, $t5, $t3	
	# _tmp158 = *(_tmp155 + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp159 = i < _tmp158
	  slt $t0, $t5, $t0	
	# _tmp160 = _tmp159 == _tmp156
	  seq $t0, $t0, $t3	
	# _tmp161 = _tmp157 || _tmp160
	  or $t0, $t1, $t0	
	# IfZ _tmp161 Goto _L16
	  beqz $t0, _L16	# branch if _tmp161 is zero 
	# _tmp162 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string10: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string10	# load label
	# PushParam _tmp162
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t4, -120($fp)	# spill _tmp155 from $t4 to $fp-120
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t4, -120($fp)	# fill _tmp155 to $t4 from $fp-120
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t4, -120($fp)	# spill _tmp155 from $t4 to $fp-120
	  jal _Halt          	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t4, -120($fp)	# fill _tmp155 to $t4 from $fp-120
  _L16:
	# _tmp163 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp164 = _tmp163 * i
	  mul $t0, $t0, $t5	
	# _tmp165 = _tmp155 + _tmp164
	  add $t0, $t4, $t0	
	# _tmp166 = *(_tmp165)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp167 = *(_tmp166)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp168 = *(_tmp167)
	  lw $t0, 0($t0) 	# load with offset
	# PushParam _tmp166
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp168
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  jalr $t0            	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp169 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp170 = i + _tmp169
	  add $t0, $t5, $t0	
	# i = _tmp170
	  move $t5, $t0	# copy regs
	# Goto _L13
	  b _L13		# unconditional branch
  _L14:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _BJDeck.DealCard:
	# BeginFunc 164
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 164	# decrement sp to make space for locals/temps
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# _tmp171 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# c = _tmp171
	  move $t3, $t0	# copy regs
	# _tmp172 = *(this + 8)
	  lw $t4, 8($t2) 	# load with offset
	# _tmp173 = 8
	  li $t1, 8		# load constant value 8 into $t1
	# _tmp174 = 52
	  li $t0, 52		# load constant value 52 into $t0
	# _tmp175 = _tmp173 * _tmp174
	  mul $t0, $t1, $t0	
	# _tmp176 = _tmp175 < _tmp172
	  slt $t1, $t0, $t4	
	# _tmp177 = _tmp175 == _tmp172
	  seq $t0, $t0, $t4	
	# _tmp178 = _tmp176 || _tmp177
	  or $t0, $t1, $t0	
	# IfZ _tmp178 Goto _L17
	  beqz $t0, _L17	# branch if _tmp178 is zero 
	# _tmp179 = 11
	  li $t0, 11		# load constant value 11 into $t0
	# Return _tmp179
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _L17:
  _L18:
	# _tmp180 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp181 = c == _tmp180
	  seq $t0, $t3, $t0	
	# IfZ _tmp181 Goto _L19
	  beqz $t0, _L19	# branch if _tmp181 is zero 
	# _tmp182 = 8
	  li $t1, 8		# load constant value 8 into $t1
	# _tmp183 = *(gRnd)
	  lw $v0, 0($gp)	# fill gRnd to $v0 from $gp+0
	  lw $t0, 0($v0) 	# load with offset
	# _tmp184 = *(_tmp183 + 8)
	  lw $t0, 8($t0) 	# load with offset
	# PushParam _tmp182
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# PushParam gRnd
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $v0, 0($gp)	# fill gRnd to $v0 from $gp+0
	  sw $v0, 4($sp)	# copy param value to stack
	# _tmp185 = ACall _tmp184
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jalr $t0            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# d = _tmp185
	  move $t5, $t0	# copy regs
	# _tmp186 = *(this + 4)
	  lw $t4, 4($t2) 	# load with offset
	# _tmp187 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp188 = d < _tmp187
	  slt $t1, $t5, $t3	
	# _tmp189 = *(_tmp186 + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp190 = d < _tmp189
	  slt $t0, $t5, $t0	
	# _tmp191 = _tmp190 == _tmp187
	  seq $t0, $t0, $t3	
	# _tmp192 = _tmp188 || _tmp191
	  or $t0, $t1, $t0	
	# IfZ _tmp192 Goto _L20
	  beqz $t0, _L20	# branch if _tmp192 is zero 
	# _tmp193 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string11: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string11	# load label
	# PushParam _tmp193
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t5, -56($fp)	# spill d from $t5 to $fp-56
	  sw $t4, -76($fp)	# spill _tmp186 from $t4 to $fp-76
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t5, -56($fp)	# fill d to $t5 from $fp-56
	  lw $t4, -76($fp)	# fill _tmp186 to $t4 from $fp-76
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t5, -56($fp)	# spill d from $t5 to $fp-56
	  sw $t4, -76($fp)	# spill _tmp186 from $t4 to $fp-76
	  jal _Halt          	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t5, -56($fp)	# fill d to $t5 from $fp-56
	  lw $t4, -76($fp)	# fill _tmp186 to $t4 from $fp-76
  _L20:
	# _tmp194 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp195 = _tmp194 * d
	  mul $t0, $t0, $t5	
	# _tmp196 = _tmp186 + _tmp195
	  add $t0, $t4, $t0	
	# _tmp197 = *(_tmp196)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp198 = *(_tmp197)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp199 = *(_tmp198 + 8)
	  lw $t0, 8($t0) 	# load with offset
	# PushParam _tmp197
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp200 = ACall _tmp199
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jalr $t0            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# c = _tmp200
	  move $t3, $t0	# copy regs
	# Goto _L18
	  b _L18		# unconditional branch
  _L19:
	# _tmp201 = 10
	  li $t0, 10		# load constant value 10 into $t0
	# _tmp202 = _tmp201 < c
	  slt $t0, $t0, $t3	
	# IfZ _tmp202 Goto _L21
	  beqz $t0, _L21	# branch if _tmp202 is zero 
	# _tmp203 = 10
	  li $t0, 10		# load constant value 10 into $t0
	# c = _tmp203
	  move $t3, $t0	# copy regs
	# Goto _L22
	  b _L22		# unconditional branch
  _L21:
	# _tmp204 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp205 = c == _tmp204
	  seq $t0, $t3, $t0	
	# IfZ _tmp205 Goto _L23
	  beqz $t0, _L23	# branch if _tmp205 is zero 
	# _tmp206 = 11
	  li $t0, 11		# load constant value 11 into $t0
	# c = _tmp206
	  move $t3, $t0	# copy regs
  _L23:
  _L22:
	# _tmp207 = *(this + 8)
	  lw $t1, 8($t2) 	# load with offset
	# _tmp208 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp209 = _tmp207 + _tmp208
	  add $t0, $t1, $t0	
	# *(this + 8) = _tmp209
	  sw $t0, 8($t2) 	# store with offset
	# Return c
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
  _BJDeck.Shuffle:
	# BeginFunc 92
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 92	# decrement sp to make space for locals/temps
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# _tmp210 = "Shuffling..."
	  .data			# create string constant marked with label
	  _string12: .asciiz "Shuffling..."
	  .text
	  la $t0, _string12	# load label
	# PushParam _tmp210
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp211 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp211
	  move $t5, $t0	# copy regs
  _L24:
	# _tmp212 = 8
	  li $t0, 8		# load constant value 8 into $t0
	# _tmp213 = i < _tmp212
	  slt $t0, $t5, $t0	
	# IfZ _tmp213 Goto _L25
	  beqz $t0, _L25	# branch if _tmp213 is zero 
	# _tmp214 = *(this + 4)
	  lw $t4, 4($t2) 	# load with offset
	# _tmp215 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp216 = i < _tmp215
	  slt $t1, $t5, $t3	
	# _tmp217 = *(_tmp214 + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp218 = i < _tmp217
	  slt $t0, $t5, $t0	
	# _tmp219 = _tmp218 == _tmp215
	  seq $t0, $t0, $t3	
	# _tmp220 = _tmp216 || _tmp219
	  or $t0, $t1, $t0	
	# IfZ _tmp220 Goto _L26
	  beqz $t0, _L26	# branch if _tmp220 is zero 
	# _tmp221 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string13: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string13	# load label
	# PushParam _tmp221
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t4, -28($fp)	# spill _tmp214 from $t4 to $fp-28
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t4, -28($fp)	# fill _tmp214 to $t4 from $fp-28
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t4, -28($fp)	# spill _tmp214 from $t4 to $fp-28
	  jal _Halt          	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t4, -28($fp)	# fill _tmp214 to $t4 from $fp-28
  _L26:
	# _tmp222 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp223 = _tmp222 * i
	  mul $t0, $t0, $t5	
	# _tmp224 = _tmp214 + _tmp223
	  add $t0, $t4, $t0	
	# _tmp225 = *(_tmp224)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp226 = *(_tmp225)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp227 = *(_tmp226 + 4)
	  lw $t0, 4($t0) 	# load with offset
	# PushParam _tmp225
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp227
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  jalr $t0            	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp228 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp229 = i + _tmp228
	  add $t0, $t5, $t0	
	# i = _tmp229
	  move $t5, $t0	# copy regs
	# Goto _L24
	  b _L24		# unconditional branch
  _L25:
	# _tmp230 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# *(this + 8) = _tmp230
	  sw $t0, 8($t2) 	# store with offset
	# _tmp231 = "done.\n"
	  .data			# create string constant marked with label
	  _string14: .asciiz "done.\n"
	  .text
	  la $t0, _string14	# load label
	# PushParam _tmp231
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
  _BJDeck.NumCardsRemaining:
	# BeginFunc 20
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 20	# decrement sp to make space for locals/temps
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# _tmp232 = 8
	  li $t1, 8		# load constant value 8 into $t1
	# _tmp233 = 52
	  li $t0, 52		# load constant value 52 into $t0
	# _tmp234 = _tmp232 * _tmp233
	  mul $t1, $t1, $t0	
	# _tmp235 = *(this + 8)
	  lw $t0, 8($t2) 	# load with offset
	# _tmp236 = _tmp234 - _tmp235
	  sub $t0, $t1, $t0	
	# Return _tmp236
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
	# VTable for class BJDeck
	  .data
	  .align 2
	  BJDeck:		# label for class BJDeck vtable
	  .word _BJDeck.Init
	  .word _BJDeck.DealCard
	  .word _BJDeck.Shuffle
	  .word _BJDeck.NumCardsRemaining
	  .text
  _Player.Init:
	# BeginFunc 16
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 16	# decrement sp to make space for locals/temps
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t1, 8($fp)	# fill num to $t1 from $fp+8
	# _tmp237 = 1000
	  li $t0, 1000		# load constant value 1000 into $t0
	# *(this + 20) = _tmp237
	  sw $t0, 20($t2) 	# store with offset
	# _tmp238 = "What is the name of player #"
	  .data			# create string constant marked with label
	  _string15: .asciiz "What is the name of player #"
	  .text
	  la $t0, _string15	# load label
	# PushParam _tmp238
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t1, 8($fp)	# spill num from $t1 to $fp+8
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t1, 8($fp)	# fill num to $t1 from $fp+8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam num
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jal _PrintInt      	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp239 = "? "
	  .data			# create string constant marked with label
	  _string16: .asciiz "? "
	  .text
	  la $t0, _string16	# load label
	# PushParam _tmp239
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp240 = LCall _ReadLine
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jal _ReadLine      	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# *(this + 24) = _tmp240
	  sw $t0, 24($t2) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.Hit:
	# BeginFunc 120
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 120	# decrement sp to make space for locals/temps
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t1, 8($fp)	# fill deck to $t1 from $fp+8
	# _tmp241 = *(deck)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp242 = *(_tmp241 + 4)
	  lw $t0, 4($t0) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp243 = ACall _tmp242
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jalr $t0            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# card = _tmp243
	  move $t3, $t0	# copy regs
	# _tmp244 = *(this + 24)
	  lw $t0, 24($t2) 	# load with offset
	# PushParam _tmp244
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t3, -8($fp)	# spill card from $t3 to $fp-8
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t3, -8($fp)	# fill card to $t3 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp245 = " was dealt a "
	  .data			# create string constant marked with label
	  _string17: .asciiz " was dealt a "
	  .text
	  la $t0, _string17	# load label
	# PushParam _tmp245
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t3, -8($fp)	# spill card from $t3 to $fp-8
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t3, -8($fp)	# fill card to $t3 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam card
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t3, -8($fp)	# spill card from $t3 to $fp-8
	  jal _PrintInt      	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t3, -8($fp)	# fill card to $t3 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp246 = ".\n"
	  .data			# create string constant marked with label
	  _string18: .asciiz ".\n"
	  .text
	  la $t0, _string18	# load label
	# PushParam _tmp246
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t3, -8($fp)	# spill card from $t3 to $fp-8
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t3, -8($fp)	# fill card to $t3 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp247 = *(this + 4)
	  lw $t0, 4($t2) 	# load with offset
	# _tmp248 = _tmp247 + card
	  add $t0, $t0, $t3	
	# *(this + 4) = _tmp248
	  sw $t0, 4($t2) 	# store with offset
	# _tmp249 = *(this + 12)
	  lw $t1, 12($t2) 	# load with offset
	# _tmp250 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp251 = _tmp249 + _tmp250
	  add $t0, $t1, $t0	
	# *(this + 12) = _tmp251
	  sw $t0, 12($t2) 	# store with offset
	# _tmp252 = 11
	  li $t0, 11		# load constant value 11 into $t0
	# _tmp253 = card == _tmp252
	  seq $t0, $t3, $t0	
	# IfZ _tmp253 Goto _L27
	  beqz $t0, _L27	# branch if _tmp253 is zero 
	# _tmp254 = *(this + 8)
	  lw $t1, 8($t2) 	# load with offset
	# _tmp255 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp256 = _tmp254 + _tmp255
	  add $t0, $t1, $t0	
	# *(this + 8) = _tmp256
	  sw $t0, 8($t2) 	# store with offset
  _L27:
  _L28:
	# _tmp257 = *(this + 4)
	  lw $t1, 4($t2) 	# load with offset
	# _tmp258 = 21
	  li $t0, 21		# load constant value 21 into $t0
	# _tmp259 = _tmp258 < _tmp257
	  slt $t3, $t0, $t1	
	# _tmp260 = *(this + 8)
	  lw $t1, 8($t2) 	# load with offset
	# _tmp261 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp262 = _tmp261 < _tmp260
	  slt $t0, $t0, $t1	
	# _tmp263 = _tmp259 && _tmp262
	  and $t0, $t3, $t0	
	# IfZ _tmp263 Goto _L29
	  beqz $t0, _L29	# branch if _tmp263 is zero 
	# _tmp264 = *(this + 4)
	  lw $t1, 4($t2) 	# load with offset
	# _tmp265 = 10
	  li $t0, 10		# load constant value 10 into $t0
	# _tmp266 = _tmp264 - _tmp265
	  sub $t0, $t1, $t0	
	# *(this + 4) = _tmp266
	  sw $t0, 4($t2) 	# store with offset
	# _tmp267 = *(this + 8)
	  lw $t1, 8($t2) 	# load with offset
	# _tmp268 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp269 = _tmp267 - _tmp268
	  sub $t0, $t1, $t0	
	# *(this + 8) = _tmp269
	  sw $t0, 8($t2) 	# store with offset
	# Goto _L28
	  b _L28		# unconditional branch
  _L29:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.DoubleDown:
	# BeginFunc 104
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 104	# decrement sp to make space for locals/temps
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	# _tmp270 = *(this + 4)
	  lw $t1, 4($t2) 	# load with offset
	# _tmp271 = 10
	  li $t0, 10		# load constant value 10 into $t0
	# _tmp272 = _tmp270 == _tmp271
	  seq $t1, $t1, $t0	
	# _tmp273 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp274 = _tmp272 == _tmp273
	  seq $t3, $t1, $t0	
	# _tmp275 = *(this + 4)
	  lw $t1, 4($t2) 	# load with offset
	# _tmp276 = 11
	  li $t0, 11		# load constant value 11 into $t0
	# _tmp277 = _tmp275 == _tmp276
	  seq $t1, $t1, $t0	
	# _tmp278 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp279 = _tmp277 == _tmp278
	  seq $t0, $t1, $t0	
	# _tmp280 = _tmp274 && _tmp279
	  and $t0, $t3, $t0	
	# IfZ _tmp280 Goto _L30
	  beqz $t0, _L30	# branch if _tmp280 is zero 
	# _tmp281 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# Return _tmp281
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _L30:
	# _tmp282 = "Would you like to double down?"
	  .data			# create string constant marked with label
	  _string19: .asciiz "Would you like to double down?"
	  .text
	  la $t0, _string19	# load label
	# PushParam _tmp282
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp283 = LCall _GetYesOrNo
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, 8($fp)	# spill deck from $t4 to $fp+8
	  jal _GetYesOrNo    	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# IfZ _tmp283 Goto _L31
	  beqz $t0, _L31	# branch if _tmp283 is zero 
	# _tmp284 = *(this + 16)
	  lw $t1, 16($t2) 	# load with offset
	# _tmp285 = 2
	  li $t0, 2		# load constant value 2 into $t0
	# _tmp286 = _tmp284 * _tmp285
	  mul $t0, $t1, $t0	
	# *(this + 16) = _tmp286
	  sw $t0, 16($t2) 	# store with offset
	# _tmp287 = *(this)
	  lw $t0, 0($t2) 	# load with offset
	# _tmp288 = *(_tmp287 + 4)
	  lw $t0, 4($t0) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t4, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# ACall _tmp288
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jalr $t0            	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp289 = *(this + 24)
	  lw $t0, 24($t2) 	# load with offset
	# PushParam _tmp289
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp290 = ", your total is "
	  .data			# create string constant marked with label
	  _string20: .asciiz ", your total is "
	  .text
	  la $t0, _string20	# load label
	# PushParam _tmp290
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp291 = *(this + 4)
	  lw $t0, 4($t2) 	# load with offset
	# PushParam _tmp291
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp292 = ".\n"
	  .data			# create string constant marked with label
	  _string21: .asciiz ".\n"
	  .text
	  la $t0, _string21	# load label
	# PushParam _tmp292
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp293 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# Return _tmp293
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _L31:
	# _tmp294 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# Return _tmp294
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
  _Player.TakeTurn:
	# BeginFunc 168
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 168	# decrement sp to make space for locals/temps
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	# _tmp295 = "\n"
	  .data			# create string constant marked with label
	  _string22: .asciiz "\n"
	  .text
	  la $t0, _string22	# load label
	# PushParam _tmp295
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, 8($fp)	# spill deck from $t4 to $fp+8
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp296 = *(this + 24)
	  lw $t0, 24($t2) 	# load with offset
	# PushParam _tmp296
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, 8($fp)	# spill deck from $t4 to $fp+8
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp297 = "'s turn.\n"
	  .data			# create string constant marked with label
	  _string23: .asciiz "'s turn.\n"
	  .text
	  la $t0, _string23	# load label
	# PushParam _tmp297
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, 8($fp)	# spill deck from $t4 to $fp+8
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp298 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# *(this + 4) = _tmp298
	  sw $t0, 4($t2) 	# store with offset
	# _tmp299 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# *(this + 8) = _tmp299
	  sw $t0, 8($t2) 	# store with offset
	# _tmp300 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# *(this + 12) = _tmp300
	  sw $t0, 12($t2) 	# store with offset
	# _tmp301 = *(this)
	  lw $t0, 0($t2) 	# load with offset
	# _tmp302 = *(_tmp301 + 4)
	  lw $t0, 4($t0) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t4, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# ACall _tmp302
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, 8($fp)	# spill deck from $t4 to $fp+8
	  jalr $t0            	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp303 = *(this)
	  lw $t0, 0($t2) 	# load with offset
	# _tmp304 = *(_tmp303 + 4)
	  lw $t0, 4($t0) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t4, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# ACall _tmp304
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, 8($fp)	# spill deck from $t4 to $fp+8
	  jalr $t0            	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp305 = *(this)
	  lw $t0, 0($t2) 	# load with offset
	# _tmp306 = *(_tmp305 + 8)
	  lw $t0, 8($t0) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t4, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# _tmp307 = ACall _tmp306
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, 8($fp)	# spill deck from $t4 to $fp+8
	  jalr $t0            	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp308 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp309 = _tmp307 == _tmp308
	  seq $t0, $t1, $t0	
	# IfZ _tmp309 Goto _L32
	  beqz $t0, _L32	# branch if _tmp309 is zero 
	# _tmp310 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# stillGoing = _tmp310
	  move $t5, $t0	# copy regs
  _L33:
	# _tmp311 = *(this + 4)
	  lw $t3, 4($t2) 	# load with offset
	# _tmp312 = 21
	  li $t0, 21		# load constant value 21 into $t0
	# _tmp313 = _tmp311 < _tmp312
	  slt $t1, $t3, $t0	
	# _tmp314 = _tmp311 == _tmp312
	  seq $t0, $t3, $t0	
	# _tmp315 = _tmp313 || _tmp314
	  or $t0, $t1, $t0	
	# _tmp316 = _tmp315 && stillGoing
	  and $t0, $t0, $t5	
	# IfZ _tmp316 Goto _L34
	  beqz $t0, _L34	# branch if _tmp316 is zero 
	# _tmp317 = *(this + 24)
	  lw $t0, 24($t2) 	# load with offset
	# PushParam _tmp317
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, 8($fp)	# spill deck from $t4 to $fp+8
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp318 = ", your total is "
	  .data			# create string constant marked with label
	  _string24: .asciiz ", your total is "
	  .text
	  la $t0, _string24	# load label
	# PushParam _tmp318
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, 8($fp)	# spill deck from $t4 to $fp+8
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp319 = *(this + 4)
	  lw $t0, 4($t2) 	# load with offset
	# PushParam _tmp319
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, 8($fp)	# spill deck from $t4 to $fp+8
	  jal _PrintInt      	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp320 = ".\n"
	  .data			# create string constant marked with label
	  _string25: .asciiz ".\n"
	  .text
	  la $t0, _string25	# load label
	# PushParam _tmp320
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, 8($fp)	# spill deck from $t4 to $fp+8
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp321 = "Would you like a hit?"
	  .data			# create string constant marked with label
	  _string26: .asciiz "Would you like a hit?"
	  .text
	  la $t0, _string26	# load label
	# PushParam _tmp321
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp322 = LCall _GetYesOrNo
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, 8($fp)	# spill deck from $t4 to $fp+8
	  jal _GetYesOrNo    	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# stillGoing = _tmp322
	  move $t5, $t0	# copy regs
	# IfZ stillGoing Goto _L35
	  beqz $t5, _L35	# branch if stillGoing is zero 
	# _tmp323 = *(this)
	  lw $t0, 0($t2) 	# load with offset
	# _tmp324 = *(_tmp323 + 4)
	  lw $t0, 4($t0) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t4, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# ACall _tmp324
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, 8($fp)	# spill deck from $t4 to $fp+8
	  sw $t5, -8($fp)	# spill stillGoing from $t5 to $fp-8
	  jalr $t0            	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	  lw $t5, -8($fp)	# fill stillGoing to $t5 from $fp-8
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
  _L35:
	# Goto _L33
	  b _L33		# unconditional branch
  _L34:
  _L32:
	# _tmp325 = *(this + 4)
	  lw $t1, 4($t2) 	# load with offset
	# _tmp326 = 21
	  li $t0, 21		# load constant value 21 into $t0
	# _tmp327 = _tmp326 < _tmp325
	  slt $t0, $t0, $t1	
	# IfZ _tmp327 Goto _L36
	  beqz $t0, _L36	# branch if _tmp327 is zero 
	# _tmp328 = *(this + 24)
	  lw $t0, 24($t2) 	# load with offset
	# PushParam _tmp328
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp329 = " busts with the big "
	  .data			# create string constant marked with label
	  _string27: .asciiz " busts with the big "
	  .text
	  la $t0, _string27	# load label
	# PushParam _tmp329
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp330 = *(this + 4)
	  lw $t0, 4($t2) 	# load with offset
	# PushParam _tmp330
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp331 = "!\n"
	  .data			# create string constant marked with label
	  _string28: .asciiz "!\n"
	  .text
	  la $t0, _string28	# load label
	# PushParam _tmp331
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L37
	  b _L37		# unconditional branch
  _L36:
	# _tmp332 = *(this + 24)
	  lw $t0, 24($t2) 	# load with offset
	# PushParam _tmp332
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp333 = " stays at "
	  .data			# create string constant marked with label
	  _string29: .asciiz " stays at "
	  .text
	  la $t0, _string29	# load label
	# PushParam _tmp333
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp334 = *(this + 4)
	  lw $t0, 4($t2) 	# load with offset
	# PushParam _tmp334
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp335 = ".\n"
	  .data			# create string constant marked with label
	  _string30: .asciiz ".\n"
	  .text
	  la $t0, _string30	# load label
	# PushParam _tmp335
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L37:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.HasMoney:
	# BeginFunc 12
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 12	# decrement sp to make space for locals/temps
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# _tmp336 = *(this + 20)
	  lw $t1, 20($t2) 	# load with offset
	# _tmp337 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp338 = _tmp337 < _tmp336
	  slt $t0, $t0, $t1	
	# Return _tmp338
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
  _Player.PrintMoney:
	# BeginFunc 16
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 16	# decrement sp to make space for locals/temps
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# _tmp339 = *(this + 24)
	  lw $t0, 24($t2) 	# load with offset
	# PushParam _tmp339
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp340 = ", you have $"
	  .data			# create string constant marked with label
	  _string31: .asciiz ", you have $"
	  .text
	  la $t0, _string31	# load label
	# PushParam _tmp340
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp341 = *(this + 20)
	  lw $t0, 20($t2) 	# load with offset
	# PushParam _tmp341
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp342 = ".\n"
	  .data			# create string constant marked with label
	  _string32: .asciiz ".\n"
	  .text
	  la $t0, _string32	# load label
	# PushParam _tmp342
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
  _Player.PlaceBet:
	# BeginFunc 56
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 56	# decrement sp to make space for locals/temps
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# _tmp343 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# *(this + 16) = _tmp343
	  sw $t0, 16($t2) 	# store with offset
	# _tmp344 = *(this)
	  lw $t0, 0($t2) 	# load with offset
	# _tmp345 = *(_tmp344 + 20)
	  lw $t0, 20($t0) 	# load with offset
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# ACall _tmp345
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jalr $t0            	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L38:
	# _tmp346 = *(this + 16)
	  lw $t3, 16($t2) 	# load with offset
	# _tmp347 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp348 = _tmp346 < _tmp347
	  slt $t1, $t3, $t0	
	# _tmp349 = _tmp346 == _tmp347
	  seq $t0, $t3, $t0	
	# _tmp350 = _tmp348 || _tmp349
	  or $t3, $t1, $t0	
	# _tmp351 = *(this + 16)
	  lw $t1, 16($t2) 	# load with offset
	# _tmp352 = *(this + 20)
	  lw $t0, 20($t2) 	# load with offset
	# _tmp353 = _tmp352 < _tmp351
	  slt $t0, $t0, $t1	
	# _tmp354 = _tmp350 || _tmp353
	  or $t0, $t3, $t0	
	# IfZ _tmp354 Goto _L39
	  beqz $t0, _L39	# branch if _tmp354 is zero 
	# _tmp355 = "How much would you like to bet? "
	  .data			# create string constant marked with label
	  _string33: .asciiz "How much would you like to bet? "
	  .text
	  la $t0, _string33	# load label
	# PushParam _tmp355
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp356 = LCall _ReadInteger
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  jal _ReadInteger   	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# *(this + 16) = _tmp356
	  sw $t0, 16($t2) 	# store with offset
	# Goto _L38
	  b _L38		# unconditional branch
  _L39:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.GetTotal:
	# BeginFunc 4
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 4	# decrement sp to make space for locals/temps
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	# _tmp357 = *(this + 4)
	  lw $t0, 4($t2) 	# load with offset
	# Return _tmp357
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
  _Player.Resolve:
	# BeginFunc 200
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 200	# decrement sp to make space for locals/temps
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t6, 8($fp)	# fill dealer to $t6 from $fp+8
	# _tmp358 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# win = _tmp358
	  move $t4, $t0	# copy regs
	# _tmp359 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# lose = _tmp359
	  move $t3, $t0	# copy regs
	# _tmp360 = *(this + 4)
	  lw $t1, 4($t2) 	# load with offset
	# _tmp361 = 21
	  li $t0, 21		# load constant value 21 into $t0
	# _tmp362 = _tmp360 == _tmp361
	  seq $t5, $t1, $t0	
	# _tmp363 = *(this + 12)
	  lw $t1, 12($t2) 	# load with offset
	# _tmp364 = 2
	  li $t0, 2		# load constant value 2 into $t0
	# _tmp365 = _tmp363 == _tmp364
	  seq $t0, $t1, $t0	
	# _tmp366 = _tmp362 && _tmp365
	  and $t0, $t5, $t0	
	# IfZ _tmp366 Goto _L40
	  beqz $t0, _L40	# branch if _tmp366 is zero 
	# _tmp367 = 2
	  li $t0, 2		# load constant value 2 into $t0
	# win = _tmp367
	  move $t4, $t0	# copy regs
	# Goto _L41
	  b _L41		# unconditional branch
  _L40:
	# _tmp368 = *(this + 4)
	  lw $t1, 4($t2) 	# load with offset
	# _tmp369 = 21
	  li $t0, 21		# load constant value 21 into $t0
	# _tmp370 = _tmp369 < _tmp368
	  slt $t0, $t0, $t1	
	# IfZ _tmp370 Goto _L42
	  beqz $t0, _L42	# branch if _tmp370 is zero 
	# _tmp371 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# lose = _tmp371
	  move $t3, $t0	# copy regs
	# Goto _L43
	  b _L43		# unconditional branch
  _L42:
	# _tmp372 = 21
	  li $t0, 21		# load constant value 21 into $t0
	# _tmp373 = _tmp372 < dealer
	  slt $t0, $t0, $t6	
	# IfZ _tmp373 Goto _L44
	  beqz $t0, _L44	# branch if _tmp373 is zero 
	# _tmp374 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# win = _tmp374
	  move $t4, $t0	# copy regs
	# Goto _L45
	  b _L45		# unconditional branch
  _L44:
	# _tmp375 = *(this + 4)
	  lw $t0, 4($t2) 	# load with offset
	# _tmp376 = dealer < _tmp375
	  slt $t0, $t6, $t0	
	# IfZ _tmp376 Goto _L46
	  beqz $t0, _L46	# branch if _tmp376 is zero 
	# _tmp377 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# win = _tmp377
	  move $t4, $t0	# copy regs
	# Goto _L47
	  b _L47		# unconditional branch
  _L46:
	# _tmp378 = *(this + 4)
	  lw $t0, 4($t2) 	# load with offset
	# _tmp379 = _tmp378 < dealer
	  slt $t0, $t0, $t6	
	# IfZ _tmp379 Goto _L48
	  beqz $t0, _L48	# branch if _tmp379 is zero 
	# _tmp380 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# lose = _tmp380
	  move $t3, $t0	# copy regs
  _L48:
  _L47:
  _L45:
  _L43:
  _L41:
	# _tmp381 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp382 = _tmp381 < win
	  slt $t1, $t0, $t4	
	# _tmp383 = _tmp381 == win
	  seq $t0, $t0, $t4	
	# _tmp384 = _tmp382 || _tmp383
	  or $t0, $t1, $t0	
	# IfZ _tmp384 Goto _L49
	  beqz $t0, _L49	# branch if _tmp384 is zero 
	# _tmp385 = *(this + 24)
	  lw $t0, 24($t2) 	# load with offset
	# PushParam _tmp385
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, -8($fp)	# spill win from $t4 to $fp-8
	  sw $t3, -12($fp)	# spill lose from $t3 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, -8($fp)	# fill win to $t4 from $fp-8
	  lw $t3, -12($fp)	# fill lose to $t3 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp386 = ", you won $"
	  .data			# create string constant marked with label
	  _string34: .asciiz ", you won $"
	  .text
	  la $t0, _string34	# load label
	# PushParam _tmp386
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, -8($fp)	# spill win from $t4 to $fp-8
	  sw $t3, -12($fp)	# spill lose from $t3 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, -8($fp)	# fill win to $t4 from $fp-8
	  lw $t3, -12($fp)	# fill lose to $t3 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp387 = *(this + 16)
	  lw $t0, 16($t2) 	# load with offset
	# PushParam _tmp387
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, -8($fp)	# spill win from $t4 to $fp-8
	  sw $t3, -12($fp)	# spill lose from $t3 to $fp-12
	  jal _PrintInt      	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, -8($fp)	# fill win to $t4 from $fp-8
	  lw $t3, -12($fp)	# fill lose to $t3 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp388 = ".\n"
	  .data			# create string constant marked with label
	  _string35: .asciiz ".\n"
	  .text
	  la $t0, _string35	# load label
	# PushParam _tmp388
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, -8($fp)	# spill win from $t4 to $fp-8
	  sw $t3, -12($fp)	# spill lose from $t3 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, -8($fp)	# fill win to $t4 from $fp-8
	  lw $t3, -12($fp)	# fill lose to $t3 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L50
	  b _L50		# unconditional branch
  _L49:
	# _tmp389 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp390 = _tmp389 < lose
	  slt $t1, $t0, $t3	
	# _tmp391 = _tmp389 == lose
	  seq $t0, $t0, $t3	
	# _tmp392 = _tmp390 || _tmp391
	  or $t0, $t1, $t0	
	# IfZ _tmp392 Goto _L51
	  beqz $t0, _L51	# branch if _tmp392 is zero 
	# _tmp393 = *(this + 24)
	  lw $t0, 24($t2) 	# load with offset
	# PushParam _tmp393
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, -8($fp)	# spill win from $t4 to $fp-8
	  sw $t3, -12($fp)	# spill lose from $t3 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, -8($fp)	# fill win to $t4 from $fp-8
	  lw $t3, -12($fp)	# fill lose to $t3 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp394 = ", you lost $"
	  .data			# create string constant marked with label
	  _string36: .asciiz ", you lost $"
	  .text
	  la $t0, _string36	# load label
	# PushParam _tmp394
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, -8($fp)	# spill win from $t4 to $fp-8
	  sw $t3, -12($fp)	# spill lose from $t3 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, -8($fp)	# fill win to $t4 from $fp-8
	  lw $t3, -12($fp)	# fill lose to $t3 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp395 = *(this + 16)
	  lw $t0, 16($t2) 	# load with offset
	# PushParam _tmp395
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, -8($fp)	# spill win from $t4 to $fp-8
	  sw $t3, -12($fp)	# spill lose from $t3 to $fp-12
	  jal _PrintInt      	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, -8($fp)	# fill win to $t4 from $fp-8
	  lw $t3, -12($fp)	# fill lose to $t3 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp396 = ".\n"
	  .data			# create string constant marked with label
	  _string37: .asciiz ".\n"
	  .text
	  la $t0, _string37	# load label
	# PushParam _tmp396
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, -8($fp)	# spill win from $t4 to $fp-8
	  sw $t3, -12($fp)	# spill lose from $t3 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, -8($fp)	# fill win to $t4 from $fp-8
	  lw $t3, -12($fp)	# fill lose to $t3 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L52
	  b _L52		# unconditional branch
  _L51:
	# _tmp397 = *(this + 24)
	  lw $t0, 24($t2) 	# load with offset
	# PushParam _tmp397
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, -8($fp)	# spill win from $t4 to $fp-8
	  sw $t3, -12($fp)	# spill lose from $t3 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, -8($fp)	# fill win to $t4 from $fp-8
	  lw $t3, -12($fp)	# fill lose to $t3 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp398 = ", you push!\n"
	  .data			# create string constant marked with label
	  _string38: .asciiz ", you push!\n"
	  .text
	  la $t0, _string38	# load label
	# PushParam _tmp398
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t2, 4($fp)	# spill this from $t2 to $fp+4
	  sw $t4, -8($fp)	# spill win from $t4 to $fp-8
	  sw $t3, -12($fp)	# spill lose from $t3 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t2, 4($fp)	# fill this to $t2 from $fp+4
	  lw $t4, -8($fp)	# fill win to $t4 from $fp-8
	  lw $t3, -12($fp)	# fill lose to $t3 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L52:
  _L50:
	# _tmp399 = *(this + 16)
	  lw $t0, 16($t2) 	# load with offset
	# _tmp400 = win * _tmp399
	  mul $t0, $t4, $t0	
	# win = _tmp400
	  move $t4, $t0	# copy regs
	# _tmp401 = *(this + 16)
	  lw $t0, 16($t2) 	# load with offset
	# _tmp402 = lose * _tmp401
	  mul $t0, $t3, $t0	
	# lose = _tmp402
	  move $t3, $t0	# copy regs
	# _tmp403 = *(this + 20)
	  lw $t0, 20($t2) 	# load with offset
	# _tmp404 = _tmp403 + win
	  add $t0, $t0, $t4	
	# _tmp405 = _tmp404 - lose
	  sub $t0, $t0, $t3	
	# *(this + 20) = _tmp405
	  sw $t0, 20($t2) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class Player
	  .data
	  .align 2
	  Player:		# label for class Player vtable
	  .word _Player.Init
	  .word _Player.Hit
	  .word _Player.DoubleDown
	  .word _Player.TakeTurn
	  .word _Player.HasMoney
	  .word _Player.PrintMoney
	  .word _Player.PlaceBet
	  .word _Player.GetTotal
	  .word _Player.Resolve
	  .text
  _Dealer.Init:
	# BeginFunc 16
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 16	# decrement sp to make space for locals/temps
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# _tmp406 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# *(this + 4) = _tmp406
	  sw $t0, 4($t3) 	# store with offset
	# _tmp407 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# *(this + 8) = _tmp407
	  sw $t0, 8($t3) 	# store with offset
	# _tmp408 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# *(this + 12) = _tmp408
	  sw $t0, 12($t3) 	# store with offset
	# _tmp409 = "Dealer"
	  .data			# create string constant marked with label
	  _string39: .asciiz "Dealer"
	  .text
	  la $t0, _string39	# load label
	# *(this + 24) = _tmp409
	  sw $t0, 24($t3) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Dealer.TakeTurn:
	# BeginFunc 84
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 84	# decrement sp to make space for locals/temps
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	# _tmp410 = "\n"
	  .data			# create string constant marked with label
	  _string40: .asciiz "\n"
	  .text
	  la $t0, _string40	# load label
	# PushParam _tmp410
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t4, 8($fp)	# spill deck from $t4 to $fp+8
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp411 = *(this + 24)
	  lw $t0, 24($t3) 	# load with offset
	# PushParam _tmp411
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t4, 8($fp)	# spill deck from $t4 to $fp+8
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp412 = "'s turn.\n"
	  .data			# create string constant marked with label
	  _string41: .asciiz "'s turn.\n"
	  .text
	  la $t0, _string41	# load label
	# PushParam _tmp412
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t4, 8($fp)	# spill deck from $t4 to $fp+8
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L53:
	# _tmp413 = *(this + 4)
	  lw $t2, 4($t3) 	# load with offset
	# _tmp414 = 16
	  li $t0, 16		# load constant value 16 into $t0
	# _tmp415 = _tmp413 < _tmp414
	  slt $t1, $t2, $t0	
	# _tmp416 = _tmp413 == _tmp414
	  seq $t0, $t2, $t0	
	# _tmp417 = _tmp415 || _tmp416
	  or $t0, $t1, $t0	
	# IfZ _tmp417 Goto _L54
	  beqz $t0, _L54	# branch if _tmp417 is zero 
	# _tmp418 = *(this)
	  lw $t0, 0($t3) 	# load with offset
	# _tmp419 = *(_tmp418 + 4)
	  lw $t0, 4($t0) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t4, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# ACall _tmp419
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t4, 8($fp)	# spill deck from $t4 to $fp+8
	  jalr $t0            	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t4, 8($fp)	# fill deck to $t4 from $fp+8
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# Goto _L53
	  b _L53		# unconditional branch
  _L54:
	# _tmp420 = *(this + 4)
	  lw $t1, 4($t3) 	# load with offset
	# _tmp421 = 21
	  li $t0, 21		# load constant value 21 into $t0
	# _tmp422 = _tmp421 < _tmp420
	  slt $t0, $t0, $t1	
	# IfZ _tmp422 Goto _L55
	  beqz $t0, _L55	# branch if _tmp422 is zero 
	# _tmp423 = *(this + 24)
	  lw $t0, 24($t3) 	# load with offset
	# PushParam _tmp423
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp424 = " busts with the big "
	  .data			# create string constant marked with label
	  _string42: .asciiz " busts with the big "
	  .text
	  la $t0, _string42	# load label
	# PushParam _tmp424
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp425 = *(this + 4)
	  lw $t0, 4($t3) 	# load with offset
	# PushParam _tmp425
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp426 = "!\n"
	  .data			# create string constant marked with label
	  _string43: .asciiz "!\n"
	  .text
	  la $t0, _string43	# load label
	# PushParam _tmp426
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L56
	  b _L56		# unconditional branch
  _L55:
	# _tmp427 = *(this + 24)
	  lw $t0, 24($t3) 	# load with offset
	# PushParam _tmp427
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp428 = " stays at "
	  .data			# create string constant marked with label
	  _string44: .asciiz " stays at "
	  .text
	  la $t0, _string44	# load label
	# PushParam _tmp428
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp429 = *(this + 4)
	  lw $t0, 4($t3) 	# load with offset
	# PushParam _tmp429
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp430 = ".\n"
	  .data			# create string constant marked with label
	  _string45: .asciiz ".\n"
	  .text
	  la $t0, _string45	# load label
	# PushParam _tmp430
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L56:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class Dealer
	  .data
	  .align 2
	  Dealer:		# label for class Dealer vtable
	  .word _Dealer.Init
	  .word _Player.Hit
	  .word _Player.DoubleDown
	  .word _Dealer.TakeTurn
	  .word _Player.HasMoney
	  .word _Player.PrintMoney
	  .word _Player.PlaceBet
	  .word _Player.GetTotal
	  .word _Player.Resolve
	  .text
  _House.SetupGame:
	# BeginFunc 84
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 84	# decrement sp to make space for locals/temps
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# _tmp431 = "\nWelcome to CS143 BlackJack!\n"
	  .data			# create string constant marked with label
	  _string46: .asciiz "\nWelcome to CS143 BlackJack!\n"
	  .text
	  la $t0, _string46	# load label
	# PushParam _tmp431
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp432 = "---------------------------\n"
	  .data			# create string constant marked with label
	  _string47: .asciiz "---------------------------\n"
	  .text
	  la $t0, _string47	# load label
	# PushParam _tmp432
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp433 = 8
	  li $t0, 8		# load constant value 8 into $t0
	# PushParam _tmp433
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp434 = LCall _Alloc
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jal _Alloc         	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp435 = Random
	  la $t0, Random	# load label
	# *(_tmp434) = _tmp435
	  sw $t0, 0($t1) 	# store with offset
	# gRnd = _tmp434
	  sw $t1, 0($gp)	# spill gRnd from $t1 to $gp+0
	# _tmp436 = "Please enter a random number seed: "
	  .data			# create string constant marked with label
	  _string48: .asciiz "Please enter a random number seed: "
	  .text
	  la $t0, _string48	# load label
	# PushParam _tmp436
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp437 = LCall _ReadInteger
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jal _ReadInteger   	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# _tmp438 = *(gRnd)
	  lw $v0, 0($gp)	# fill gRnd to $v0 from $gp+0
	  lw $t0, 0($v0) 	# load with offset
	# _tmp439 = *(_tmp438)
	  lw $t0, 0($t0) 	# load with offset
	# PushParam _tmp437
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# PushParam gRnd
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $v0, 0($gp)	# fill gRnd to $v0 from $gp+0
	  sw $v0, 4($sp)	# copy param value to stack
	# ACall _tmp439
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jalr $t0            	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp440 = 12
	  li $t0, 12		# load constant value 12 into $t0
	# PushParam _tmp440
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp441 = LCall _Alloc
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jal _Alloc         	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp442 = BJDeck
	  la $t0, BJDeck	# load label
	# *(_tmp441) = _tmp442
	  sw $t0, 0($t1) 	# store with offset
	# *(this + 12) = _tmp441
	  sw $t1, 12($t3) 	# store with offset
	# _tmp443 = 28
	  li $t0, 28		# load constant value 28 into $t0
	# PushParam _tmp443
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp444 = LCall _Alloc
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jal _Alloc         	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp445 = Dealer
	  la $t0, Dealer	# load label
	# *(_tmp444) = _tmp445
	  sw $t0, 0($t1) 	# store with offset
	# *(this + 8) = _tmp444
	  sw $t1, 8($t3) 	# store with offset
	# _tmp446 = *(this + 12)
	  lw $t1, 12($t3) 	# load with offset
	# _tmp447 = *(_tmp446)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp448 = *(_tmp447)
	  lw $t0, 0($t0) 	# load with offset
	# PushParam _tmp446
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp448
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jalr $t0            	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp449 = *(this + 12)
	  lw $t1, 12($t3) 	# load with offset
	# _tmp450 = *(_tmp449)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp451 = *(_tmp450 + 8)
	  lw $t0, 8($t0) 	# load with offset
	# PushParam _tmp449
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp451
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.SetupPlayers:
	# BeginFunc 196
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 196	# decrement sp to make space for locals/temps
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# _tmp452 = "How many players do we have today? "
	  .data			# create string constant marked with label
	  _string49: .asciiz "How many players do we have today? "
	  .text
	  la $t0, _string49	# load label
	# PushParam _tmp452
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp453 = LCall _ReadInteger
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jal _ReadInteger   	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# numPlayers = _tmp453
	  move $t2, $t0	# copy regs
	# _tmp454 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp455 = numPlayers < _tmp454
	  slt $t0, $t2, $t0	
	# IfZ _tmp455 Goto _L57
	  beqz $t0, _L57	# branch if _tmp455 is zero 
	# _tmp456 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string50: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t0, _string50	# load label
	# PushParam _tmp456
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t2, -12($fp)	# spill numPlayers from $t2 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t2, -12($fp)	# fill numPlayers to $t2 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t2, -12($fp)	# spill numPlayers from $t2 to $fp-12
	  jal _Halt          	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t2, -12($fp)	# fill numPlayers to $t2 from $fp-12
  _L57:
	# _tmp457 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp458 = _tmp457 + numPlayers
	  add $t0, $t0, $t2	
	# _tmp459 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp460 = _tmp458 * _tmp459
	  mul $t0, $t0, $t1	
	# PushParam _tmp460
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp461 = LCall _Alloc
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t2, -12($fp)	# spill numPlayers from $t2 to $fp-12
	  sw $t1, -44($fp)	# spill _tmp459 from $t1 to $fp-44
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t2, -12($fp)	# fill numPlayers to $t2 from $fp-12
	  lw $t1, -44($fp)	# fill _tmp459 to $t1 from $fp-44
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp461) = numPlayers
	  sw $t2, 0($t0) 	# store with offset
	# _tmp462 = _tmp461 + _tmp459
	  add $t0, $t0, $t1	
	# *(this + 4) = _tmp462
	  sw $t0, 4($t3) 	# store with offset
	# _tmp463 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp463
	  move $t6, $t0	# copy regs
  _L58:
	# _tmp464 = *(this + 4)
	  lw $t0, 4($t3) 	# load with offset
	# _tmp465 = *(_tmp464 + -4)
	  lw $t0, -4($t0) 	# load with offset
	# _tmp466 = i < _tmp465
	  slt $t0, $t6, $t0	
	# IfZ _tmp466 Goto _L59
	  beqz $t0, _L59	# branch if _tmp466 is zero 
	# _tmp467 = *(this + 4)
	  lw $t4, 4($t3) 	# load with offset
	# _tmp468 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp469 = i < _tmp468
	  slt $t1, $t6, $t2	
	# _tmp470 = *(_tmp467 + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp471 = i < _tmp470
	  slt $t0, $t6, $t0	
	# _tmp472 = _tmp471 == _tmp468
	  seq $t0, $t0, $t2	
	# _tmp473 = _tmp469 || _tmp472
	  or $t0, $t1, $t0	
	# IfZ _tmp473 Goto _L60
	  beqz $t0, _L60	# branch if _tmp473 is zero 
	# _tmp474 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string51: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string51	# load label
	# PushParam _tmp474
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t6, -8($fp)	# spill i from $t6 to $fp-8
	  sw $t4, -76($fp)	# spill _tmp467 from $t4 to $fp-76
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t6, -8($fp)	# fill i to $t6 from $fp-8
	  lw $t4, -76($fp)	# fill _tmp467 to $t4 from $fp-76
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t6, -8($fp)	# spill i from $t6 to $fp-8
	  sw $t4, -76($fp)	# spill _tmp467 from $t4 to $fp-76
	  jal _Halt          	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t6, -8($fp)	# fill i to $t6 from $fp-8
	  lw $t4, -76($fp)	# fill _tmp467 to $t4 from $fp-76
  _L60:
	# _tmp475 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp476 = _tmp475 * i
	  mul $t0, $t0, $t6	
	# _tmp477 = _tmp467 + _tmp476
	  add $t2, $t4, $t0	
	# _tmp478 = 28
	  li $t0, 28		# load constant value 28 into $t0
	# PushParam _tmp478
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp479 = LCall _Alloc
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t6, -8($fp)	# spill i from $t6 to $fp-8
	  sw $t2, -116($fp)	# spill _tmp477 from $t2 to $fp-116
	  jal _Alloc         	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t6, -8($fp)	# fill i to $t6 from $fp-8
	  lw $t2, -116($fp)	# fill _tmp477 to $t2 from $fp-116
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp480 = Player
	  la $t0, Player	# load label
	# *(_tmp479) = _tmp480
	  sw $t0, 0($t1) 	# store with offset
	# *(_tmp477) = _tmp479
	  sw $t1, 0($t2) 	# store with offset
	# _tmp481 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp482 = i + _tmp481
	  add $t5, $t6, $t0	
	# _tmp483 = *(this + 4)
	  lw $t4, 4($t3) 	# load with offset
	# _tmp484 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp485 = i < _tmp484
	  slt $t1, $t6, $t2	
	# _tmp486 = *(_tmp483 + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp487 = i < _tmp486
	  slt $t0, $t6, $t0	
	# _tmp488 = _tmp487 == _tmp484
	  seq $t0, $t0, $t2	
	# _tmp489 = _tmp485 || _tmp488
	  or $t0, $t1, $t0	
	# IfZ _tmp489 Goto _L61
	  beqz $t0, _L61	# branch if _tmp489 is zero 
	# _tmp490 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string52: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string52	# load label
	# PushParam _tmp490
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t6, -8($fp)	# spill i from $t6 to $fp-8
	  sw $t5, -136($fp)	# spill _tmp482 from $t5 to $fp-136
	  sw $t4, -140($fp)	# spill _tmp483 from $t4 to $fp-140
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t6, -8($fp)	# fill i to $t6 from $fp-8
	  lw $t5, -136($fp)	# fill _tmp482 to $t5 from $fp-136
	  lw $t4, -140($fp)	# fill _tmp483 to $t4 from $fp-140
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t6, -8($fp)	# spill i from $t6 to $fp-8
	  sw $t5, -136($fp)	# spill _tmp482 from $t5 to $fp-136
	  sw $t4, -140($fp)	# spill _tmp483 from $t4 to $fp-140
	  jal _Halt          	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t6, -8($fp)	# fill i to $t6 from $fp-8
	  lw $t5, -136($fp)	# fill _tmp482 to $t5 from $fp-136
	  lw $t4, -140($fp)	# fill _tmp483 to $t4 from $fp-140
  _L61:
	# _tmp491 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp492 = _tmp491 * i
	  mul $t0, $t0, $t6	
	# _tmp493 = _tmp483 + _tmp492
	  add $t0, $t4, $t0	
	# _tmp494 = *(_tmp493)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp495 = *(_tmp494)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp496 = *(_tmp495)
	  lw $t0, 0($t0) 	# load with offset
	# PushParam _tmp482
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t5, 4($sp)	# copy param value to stack
	# PushParam _tmp494
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp496
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t6, -8($fp)	# spill i from $t6 to $fp-8
	  jalr $t0            	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t6, -8($fp)	# fill i to $t6 from $fp-8
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp497 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp498 = i + _tmp497
	  add $t0, $t6, $t0	
	# i = _tmp498
	  move $t6, $t0	# copy regs
	# Goto _L58
	  b _L58		# unconditional branch
  _L59:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.TakeAllBets:
	# BeginFunc 148
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 148	# decrement sp to make space for locals/temps
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# _tmp499 = "\nFirst, let's take bets.\n"
	  .data			# create string constant marked with label
	  _string53: .asciiz "\nFirst, let's take bets.\n"
	  .text
	  la $t0, _string53	# load label
	# PushParam _tmp499
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp500 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp500
	  move $t5, $t0	# copy regs
  _L62:
	# _tmp501 = *(this + 4)
	  lw $t0, 4($t3) 	# load with offset
	# _tmp502 = *(_tmp501 + -4)
	  lw $t0, -4($t0) 	# load with offset
	# _tmp503 = i < _tmp502
	  slt $t0, $t5, $t0	
	# IfZ _tmp503 Goto _L63
	  beqz $t0, _L63	# branch if _tmp503 is zero 
	# _tmp504 = *(this + 4)
	  lw $t4, 4($t3) 	# load with offset
	# _tmp505 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp506 = i < _tmp505
	  slt $t1, $t5, $t2	
	# _tmp507 = *(_tmp504 + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp508 = i < _tmp507
	  slt $t0, $t5, $t0	
	# _tmp509 = _tmp508 == _tmp505
	  seq $t0, $t0, $t2	
	# _tmp510 = _tmp506 || _tmp509
	  or $t0, $t1, $t0	
	# IfZ _tmp510 Goto _L64
	  beqz $t0, _L64	# branch if _tmp510 is zero 
	# _tmp511 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string54: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string54	# load label
	# PushParam _tmp511
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t4, -32($fp)	# spill _tmp504 from $t4 to $fp-32
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t4, -32($fp)	# fill _tmp504 to $t4 from $fp-32
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t4, -32($fp)	# spill _tmp504 from $t4 to $fp-32
	  jal _Halt          	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t4, -32($fp)	# fill _tmp504 to $t4 from $fp-32
  _L64:
	# _tmp512 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp513 = _tmp512 * i
	  mul $t0, $t0, $t5	
	# _tmp514 = _tmp504 + _tmp513
	  add $t0, $t4, $t0	
	# _tmp515 = *(_tmp514)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp516 = *(_tmp515)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp517 = *(_tmp516 + 16)
	  lw $t0, 16($t0) 	# load with offset
	# PushParam _tmp515
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp518 = ACall _tmp517
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  jalr $t0            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# IfZ _tmp518 Goto _L65
	  beqz $t0, _L65	# branch if _tmp518 is zero 
	# _tmp519 = *(this + 4)
	  lw $t4, 4($t3) 	# load with offset
	# _tmp520 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp521 = i < _tmp520
	  slt $t1, $t5, $t2	
	# _tmp522 = *(_tmp519 + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp523 = i < _tmp522
	  slt $t0, $t5, $t0	
	# _tmp524 = _tmp523 == _tmp520
	  seq $t0, $t0, $t2	
	# _tmp525 = _tmp521 || _tmp524
	  or $t0, $t1, $t0	
	# IfZ _tmp525 Goto _L66
	  beqz $t0, _L66	# branch if _tmp525 is zero 
	# _tmp526 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string55: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string55	# load label
	# PushParam _tmp526
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t4, -92($fp)	# spill _tmp519 from $t4 to $fp-92
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t4, -92($fp)	# fill _tmp519 to $t4 from $fp-92
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t4, -92($fp)	# spill _tmp519 from $t4 to $fp-92
	  jal _Halt          	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t4, -92($fp)	# fill _tmp519 to $t4 from $fp-92
  _L66:
	# _tmp527 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp528 = _tmp527 * i
	  mul $t0, $t0, $t5	
	# _tmp529 = _tmp519 + _tmp528
	  add $t0, $t4, $t0	
	# _tmp530 = *(_tmp529)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp531 = *(_tmp530)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp532 = *(_tmp531 + 24)
	  lw $t0, 24($t0) 	# load with offset
	# PushParam _tmp530
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp532
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  jalr $t0            	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L65:
	# _tmp533 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp534 = i + _tmp533
	  add $t0, $t5, $t0	
	# i = _tmp534
	  move $t5, $t0	# copy regs
	# Goto _L62
	  b _L62		# unconditional branch
  _L63:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.TakeAllTurns:
	# BeginFunc 148
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 148	# decrement sp to make space for locals/temps
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# _tmp535 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp535
	  move $t6, $t0	# copy regs
  _L67:
	# _tmp536 = *(this + 4)
	  lw $t0, 4($t3) 	# load with offset
	# _tmp537 = *(_tmp536 + -4)
	  lw $t0, -4($t0) 	# load with offset
	# _tmp538 = i < _tmp537
	  slt $t0, $t6, $t0	
	# IfZ _tmp538 Goto _L68
	  beqz $t0, _L68	# branch if _tmp538 is zero 
	# _tmp539 = *(this + 4)
	  lw $t4, 4($t3) 	# load with offset
	# _tmp540 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp541 = i < _tmp540
	  slt $t1, $t6, $t2	
	# _tmp542 = *(_tmp539 + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp543 = i < _tmp542
	  slt $t0, $t6, $t0	
	# _tmp544 = _tmp543 == _tmp540
	  seq $t0, $t0, $t2	
	# _tmp545 = _tmp541 || _tmp544
	  or $t0, $t1, $t0	
	# IfZ _tmp545 Goto _L69
	  beqz $t0, _L69	# branch if _tmp545 is zero 
	# _tmp546 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string56: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string56	# load label
	# PushParam _tmp546
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t6, -8($fp)	# spill i from $t6 to $fp-8
	  sw $t4, -28($fp)	# spill _tmp539 from $t4 to $fp-28
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t6, -8($fp)	# fill i to $t6 from $fp-8
	  lw $t4, -28($fp)	# fill _tmp539 to $t4 from $fp-28
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t6, -8($fp)	# spill i from $t6 to $fp-8
	  sw $t4, -28($fp)	# spill _tmp539 from $t4 to $fp-28
	  jal _Halt          	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t6, -8($fp)	# fill i to $t6 from $fp-8
	  lw $t4, -28($fp)	# fill _tmp539 to $t4 from $fp-28
  _L69:
	# _tmp547 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp548 = _tmp547 * i
	  mul $t0, $t0, $t6	
	# _tmp549 = _tmp539 + _tmp548
	  add $t0, $t4, $t0	
	# _tmp550 = *(_tmp549)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp551 = *(_tmp550)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp552 = *(_tmp551 + 16)
	  lw $t0, 16($t0) 	# load with offset
	# PushParam _tmp550
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp553 = ACall _tmp552
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t6, -8($fp)	# spill i from $t6 to $fp-8
	  jalr $t0            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t6, -8($fp)	# fill i to $t6 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# IfZ _tmp553 Goto _L70
	  beqz $t0, _L70	# branch if _tmp553 is zero 
	# _tmp554 = *(this + 12)
	  lw $t5, 12($t3) 	# load with offset
	# _tmp555 = *(this + 4)
	  lw $t4, 4($t3) 	# load with offset
	# _tmp556 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp557 = i < _tmp556
	  slt $t1, $t6, $t2	
	# _tmp558 = *(_tmp555 + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp559 = i < _tmp558
	  slt $t0, $t6, $t0	
	# _tmp560 = _tmp559 == _tmp556
	  seq $t0, $t0, $t2	
	# _tmp561 = _tmp557 || _tmp560
	  or $t0, $t1, $t0	
	# IfZ _tmp561 Goto _L71
	  beqz $t0, _L71	# branch if _tmp561 is zero 
	# _tmp562 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string57: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string57	# load label
	# PushParam _tmp562
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t6, -8($fp)	# spill i from $t6 to $fp-8
	  sw $t5, -88($fp)	# spill _tmp554 from $t5 to $fp-88
	  sw $t4, -92($fp)	# spill _tmp555 from $t4 to $fp-92
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t6, -8($fp)	# fill i to $t6 from $fp-8
	  lw $t5, -88($fp)	# fill _tmp554 to $t5 from $fp-88
	  lw $t4, -92($fp)	# fill _tmp555 to $t4 from $fp-92
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t6, -8($fp)	# spill i from $t6 to $fp-8
	  sw $t5, -88($fp)	# spill _tmp554 from $t5 to $fp-88
	  sw $t4, -92($fp)	# spill _tmp555 from $t4 to $fp-92
	  jal _Halt          	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t6, -8($fp)	# fill i to $t6 from $fp-8
	  lw $t5, -88($fp)	# fill _tmp554 to $t5 from $fp-88
	  lw $t4, -92($fp)	# fill _tmp555 to $t4 from $fp-92
  _L71:
	# _tmp563 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp564 = _tmp563 * i
	  mul $t0, $t0, $t6	
	# _tmp565 = _tmp555 + _tmp564
	  add $t0, $t4, $t0	
	# _tmp566 = *(_tmp565)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp567 = *(_tmp566)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp568 = *(_tmp567 + 12)
	  lw $t0, 12($t0) 	# load with offset
	# PushParam _tmp554
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t5, 4($sp)	# copy param value to stack
	# PushParam _tmp566
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp568
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t6, -8($fp)	# spill i from $t6 to $fp-8
	  jalr $t0            	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t6, -8($fp)	# fill i to $t6 from $fp-8
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
  _L70:
	# _tmp569 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp570 = i + _tmp569
	  add $t0, $t6, $t0	
	# i = _tmp570
	  move $t6, $t0	# copy regs
	# Goto _L67
	  b _L67		# unconditional branch
  _L68:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.ResolveAllPlayers:
	# BeginFunc 164
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 164	# decrement sp to make space for locals/temps
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# _tmp571 = "\nTime to resolve bets.\n"
	  .data			# create string constant marked with label
	  _string58: .asciiz "\nTime to resolve bets.\n"
	  .text
	  la $t0, _string58	# load label
	# PushParam _tmp571
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp572 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp572
	  move $t6, $t0	# copy regs
  _L72:
	# _tmp573 = *(this + 4)
	  lw $t0, 4($t3) 	# load with offset
	# _tmp574 = *(_tmp573 + -4)
	  lw $t0, -4($t0) 	# load with offset
	# _tmp575 = i < _tmp574
	  slt $t0, $t6, $t0	
	# IfZ _tmp575 Goto _L73
	  beqz $t0, _L73	# branch if _tmp575 is zero 
	# _tmp576 = *(this + 4)
	  lw $t4, 4($t3) 	# load with offset
	# _tmp577 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp578 = i < _tmp577
	  slt $t1, $t6, $t2	
	# _tmp579 = *(_tmp576 + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp580 = i < _tmp579
	  slt $t0, $t6, $t0	
	# _tmp581 = _tmp580 == _tmp577
	  seq $t0, $t0, $t2	
	# _tmp582 = _tmp578 || _tmp581
	  or $t0, $t1, $t0	
	# IfZ _tmp582 Goto _L74
	  beqz $t0, _L74	# branch if _tmp582 is zero 
	# _tmp583 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string59: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string59	# load label
	# PushParam _tmp583
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t6, -8($fp)	# spill i from $t6 to $fp-8
	  sw $t4, -32($fp)	# spill _tmp576 from $t4 to $fp-32
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t6, -8($fp)	# fill i to $t6 from $fp-8
	  lw $t4, -32($fp)	# fill _tmp576 to $t4 from $fp-32
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t6, -8($fp)	# spill i from $t6 to $fp-8
	  sw $t4, -32($fp)	# spill _tmp576 from $t4 to $fp-32
	  jal _Halt          	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t6, -8($fp)	# fill i to $t6 from $fp-8
	  lw $t4, -32($fp)	# fill _tmp576 to $t4 from $fp-32
  _L74:
	# _tmp584 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp585 = _tmp584 * i
	  mul $t0, $t0, $t6	
	# _tmp586 = _tmp576 + _tmp585
	  add $t0, $t4, $t0	
	# _tmp587 = *(_tmp586)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp588 = *(_tmp587)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp589 = *(_tmp588 + 16)
	  lw $t0, 16($t0) 	# load with offset
	# PushParam _tmp587
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp590 = ACall _tmp589
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t6, -8($fp)	# spill i from $t6 to $fp-8
	  jalr $t0            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t6, -8($fp)	# fill i to $t6 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# IfZ _tmp590 Goto _L75
	  beqz $t0, _L75	# branch if _tmp590 is zero 
	# _tmp591 = *(this + 8)
	  lw $t1, 8($t3) 	# load with offset
	# _tmp592 = *(_tmp591)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp593 = *(_tmp592 + 28)
	  lw $t0, 28($t0) 	# load with offset
	# PushParam _tmp591
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp594 = ACall _tmp593
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t6, -8($fp)	# spill i from $t6 to $fp-8
	  jalr $t0            	# jump to function
	  move $t5, $v0		# copy function return value from $v0
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t6, -8($fp)	# fill i to $t6 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp595 = *(this + 4)
	  lw $t4, 4($t3) 	# load with offset
	# _tmp596 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp597 = i < _tmp596
	  slt $t1, $t6, $t2	
	# _tmp598 = *(_tmp595 + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp599 = i < _tmp598
	  slt $t0, $t6, $t0	
	# _tmp600 = _tmp599 == _tmp596
	  seq $t0, $t0, $t2	
	# _tmp601 = _tmp597 || _tmp600
	  or $t0, $t1, $t0	
	# IfZ _tmp601 Goto _L76
	  beqz $t0, _L76	# branch if _tmp601 is zero 
	# _tmp602 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string60: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string60	# load label
	# PushParam _tmp602
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t6, -8($fp)	# spill i from $t6 to $fp-8
	  sw $t4, -108($fp)	# spill _tmp595 from $t4 to $fp-108
	  sw $t5, -104($fp)	# spill _tmp594 from $t5 to $fp-104
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t6, -8($fp)	# fill i to $t6 from $fp-8
	  lw $t4, -108($fp)	# fill _tmp595 to $t4 from $fp-108
	  lw $t5, -104($fp)	# fill _tmp594 to $t5 from $fp-104
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t6, -8($fp)	# spill i from $t6 to $fp-8
	  sw $t4, -108($fp)	# spill _tmp595 from $t4 to $fp-108
	  sw $t5, -104($fp)	# spill _tmp594 from $t5 to $fp-104
	  jal _Halt          	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t6, -8($fp)	# fill i to $t6 from $fp-8
	  lw $t4, -108($fp)	# fill _tmp595 to $t4 from $fp-108
	  lw $t5, -104($fp)	# fill _tmp594 to $t5 from $fp-104
  _L76:
	# _tmp603 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp604 = _tmp603 * i
	  mul $t0, $t0, $t6	
	# _tmp605 = _tmp595 + _tmp604
	  add $t0, $t4, $t0	
	# _tmp606 = *(_tmp605)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp607 = *(_tmp606)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp608 = *(_tmp607 + 32)
	  lw $t0, 32($t0) 	# load with offset
	# PushParam _tmp594
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t5, 4($sp)	# copy param value to stack
	# PushParam _tmp606
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp608
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t6, -8($fp)	# spill i from $t6 to $fp-8
	  jalr $t0            	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t6, -8($fp)	# fill i to $t6 from $fp-8
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
  _L75:
	# _tmp609 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp610 = i + _tmp609
	  add $t0, $t6, $t0	
	# i = _tmp610
	  move $t6, $t0	# copy regs
	# Goto _L72
	  b _L72		# unconditional branch
  _L73:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.PrintAllMoney:
	# BeginFunc 84
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 84	# decrement sp to make space for locals/temps
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# _tmp611 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp611
	  move $t5, $t0	# copy regs
  _L77:
	# _tmp612 = *(this + 4)
	  lw $t0, 4($t3) 	# load with offset
	# _tmp613 = *(_tmp612 + -4)
	  lw $t0, -4($t0) 	# load with offset
	# _tmp614 = i < _tmp613
	  slt $t0, $t5, $t0	
	# IfZ _tmp614 Goto _L78
	  beqz $t0, _L78	# branch if _tmp614 is zero 
	# _tmp615 = *(this + 4)
	  lw $t4, 4($t3) 	# load with offset
	# _tmp616 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp617 = i < _tmp616
	  slt $t1, $t5, $t2	
	# _tmp618 = *(_tmp615 + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp619 = i < _tmp618
	  slt $t0, $t5, $t0	
	# _tmp620 = _tmp619 == _tmp616
	  seq $t0, $t0, $t2	
	# _tmp621 = _tmp617 || _tmp620
	  or $t0, $t1, $t0	
	# IfZ _tmp621 Goto _L79
	  beqz $t0, _L79	# branch if _tmp621 is zero 
	# _tmp622 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string61: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string61	# load label
	# PushParam _tmp622
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t4, -28($fp)	# spill _tmp615 from $t4 to $fp-28
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t4, -28($fp)	# fill _tmp615 to $t4 from $fp-28
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t4, -28($fp)	# spill _tmp615 from $t4 to $fp-28
	  jal _Halt          	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t4, -28($fp)	# fill _tmp615 to $t4 from $fp-28
  _L79:
	# _tmp623 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp624 = _tmp623 * i
	  mul $t0, $t0, $t5	
	# _tmp625 = _tmp615 + _tmp624
	  add $t0, $t4, $t0	
	# _tmp626 = *(_tmp625)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp627 = *(_tmp626)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp628 = *(_tmp627 + 20)
	  lw $t0, 20($t0) 	# load with offset
	# PushParam _tmp626
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp628
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  jalr $t0            	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp629 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp630 = i + _tmp629
	  add $t0, $t5, $t0	
	# i = _tmp630
	  move $t5, $t0	# copy regs
	# Goto _L77
	  b _L77		# unconditional branch
  _L78:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.PlayOneGame:
	# BeginFunc 112
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 112	# decrement sp to make space for locals/temps
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# _tmp631 = *(this + 12)
	  lw $t1, 12($t3) 	# load with offset
	# _tmp632 = *(_tmp631)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp633 = *(_tmp632 + 12)
	  lw $t0, 12($t0) 	# load with offset
	# PushParam _tmp631
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp634 = ACall _tmp633
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jalr $t0            	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp635 = 26
	  li $t0, 26		# load constant value 26 into $t0
	# _tmp636 = _tmp634 < _tmp635
	  slt $t0, $t1, $t0	
	# IfZ _tmp636 Goto _L80
	  beqz $t0, _L80	# branch if _tmp636 is zero 
	# _tmp637 = *(this + 12)
	  lw $t1, 12($t3) 	# load with offset
	# _tmp638 = *(_tmp637)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp639 = *(_tmp638 + 8)
	  lw $t0, 8($t0) 	# load with offset
	# PushParam _tmp637
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp639
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jalr $t0            	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L80:
	# _tmp640 = *(this)
	  lw $t0, 0($t3) 	# load with offset
	# _tmp641 = *(_tmp640 + 8)
	  lw $t0, 8($t0) 	# load with offset
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# ACall _tmp641
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jalr $t0            	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp642 = "\nDealer starts. "
	  .data			# create string constant marked with label
	  _string62: .asciiz "\nDealer starts. "
	  .text
	  la $t0, _string62	# load label
	# PushParam _tmp642
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp643 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp644 = *(this + 8)
	  lw $t1, 8($t3) 	# load with offset
	# _tmp645 = *(_tmp644)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp646 = *(_tmp645)
	  lw $t0, 0($t0) 	# load with offset
	# PushParam _tmp643
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# PushParam _tmp644
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp646
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jalr $t0            	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp647 = *(this + 12)
	  lw $t2, 12($t3) 	# load with offset
	# _tmp648 = *(this + 8)
	  lw $t1, 8($t3) 	# load with offset
	# _tmp649 = *(_tmp648)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp650 = *(_tmp649 + 4)
	  lw $t0, 4($t0) 	# load with offset
	# PushParam _tmp647
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# PushParam _tmp648
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp650
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jalr $t0            	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp651 = *(this)
	  lw $t0, 0($t3) 	# load with offset
	# _tmp652 = *(_tmp651 + 12)
	  lw $t0, 12($t0) 	# load with offset
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# ACall _tmp652
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jalr $t0            	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp653 = *(this + 12)
	  lw $t2, 12($t3) 	# load with offset
	# _tmp654 = *(this + 8)
	  lw $t1, 8($t3) 	# load with offset
	# _tmp655 = *(_tmp654)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp656 = *(_tmp655 + 12)
	  lw $t0, 12($t0) 	# load with offset
	# PushParam _tmp653
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# PushParam _tmp654
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp656
	  sw $t3, 4($fp)	# spill this from $t3 to $fp+4
	  jalr $t0            	# jump to function
	  lw $t3, 4($fp)	# fill this to $t3 from $fp+4
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp657 = *(this)
	  lw $t0, 0($t3) 	# load with offset
	# _tmp658 = *(_tmp657 + 16)
	  lw $t0, 16($t0) 	# load with offset
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# ACall _tmp658
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class House
	  .data
	  .align 2
	  House:		# label for class House vtable
	  .word _House.SetupGame
	  .word _House.SetupPlayers
	  .word _House.TakeAllBets
	  .word _House.TakeAllTurns
	  .word _House.ResolveAllPlayers
	  .word _House.PrintAllMoney
	  .word _House.PlayOneGame
	  .text
  _GetYesOrNo:
	# BeginFunc 32
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 32	# decrement sp to make space for locals/temps
	  lw $t0, 4($fp)	# fill prompt to $t0 from $fp+4
	# PushParam prompt
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp659 = " (y/n) "
	  .data			# create string constant marked with label
	  _string63: .asciiz " (y/n) "
	  .text
	  la $t0, _string63	# load label
	# PushParam _tmp659
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp660 = LCall _ReadLine
	  jal _ReadLine      	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# answer = _tmp660
	  move $t2, $t0	# copy regs
	# _tmp661 = "y"
	  .data			# create string constant marked with label
	  _string64: .asciiz "y"
	  .text
	  la $t0, _string64	# load label
	# PushParam _tmp661
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam answer
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# _tmp662 = LCall _StringEqual
	  sw $t2, -8($fp)	# spill answer from $t2 to $fp-8
	  jal _StringEqual   	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	  lw $t2, -8($fp)	# fill answer to $t2 from $fp-8
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp663 = "Y"
	  .data			# create string constant marked with label
	  _string65: .asciiz "Y"
	  .text
	  la $t0, _string65	# load label
	# PushParam _tmp663
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam answer
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# _tmp664 = LCall _StringEqual
	  sw $t1, -24($fp)	# spill _tmp662 from $t1 to $fp-24
	  jal _StringEqual   	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t1, -24($fp)	# fill _tmp662 to $t1 from $fp-24
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp665 = _tmp662 || _tmp664
	  or $t0, $t1, $t0	
	# Return _tmp665
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
	# BeginFunc 76
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 76	# decrement sp to make space for locals/temps
	# _tmp666 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# keepPlaying = _tmp666
	  move $t2, $t0	# copy regs
	# _tmp667 = 16
	  li $t0, 16		# load constant value 16 into $t0
	# PushParam _tmp667
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp668 = LCall _Alloc
	  sw $t2, -8($fp)	# spill keepPlaying from $t2 to $fp-8
	  jal _Alloc         	# jump to function
	  move $t1, $v0		# copy function return value from $v0
	  lw $t2, -8($fp)	# fill keepPlaying to $t2 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp669 = House
	  la $t0, House	# load label
	# *(_tmp668) = _tmp669
	  sw $t0, 0($t1) 	# store with offset
	# house = _tmp668
	  move $t1, $t1	# copy regs
	# _tmp670 = *(house)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp671 = *(_tmp670)
	  lw $t0, 0($t0) 	# load with offset
	# PushParam house
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp671
	  sw $t2, -8($fp)	# spill keepPlaying from $t2 to $fp-8
	  sw $t1, -12($fp)	# spill house from $t1 to $fp-12
	  jalr $t0            	# jump to function
	  lw $t2, -8($fp)	# fill keepPlaying to $t2 from $fp-8
	  lw $t1, -12($fp)	# fill house to $t1 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp672 = *(house)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp673 = *(_tmp672 + 4)
	  lw $t0, 4($t0) 	# load with offset
	# PushParam house
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp673
	  sw $t2, -8($fp)	# spill keepPlaying from $t2 to $fp-8
	  sw $t1, -12($fp)	# spill house from $t1 to $fp-12
	  jalr $t0            	# jump to function
	  lw $t2, -8($fp)	# fill keepPlaying to $t2 from $fp-8
	  lw $t1, -12($fp)	# fill house to $t1 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L81:
	# IfZ keepPlaying Goto _L82
	  beqz $t2, _L82	# branch if keepPlaying is zero 
	# _tmp674 = *(house)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp675 = *(_tmp674 + 24)
	  lw $t0, 24($t0) 	# load with offset
	# PushParam house
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp675
	  sw $t1, -12($fp)	# spill house from $t1 to $fp-12
	  jalr $t0            	# jump to function
	  lw $t1, -12($fp)	# fill house to $t1 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp676 = "\nDo you want to play another hand?"
	  .data			# create string constant marked with label
	  _string66: .asciiz "\nDo you want to play another hand?"
	  .text
	  la $t0, _string66	# load label
	# PushParam _tmp676
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp677 = LCall _GetYesOrNo
	  sw $t1, -12($fp)	# spill house from $t1 to $fp-12
	  jal _GetYesOrNo    	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t1, -12($fp)	# fill house to $t1 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# keepPlaying = _tmp677
	  move $t2, $t0	# copy regs
	# Goto _L81
	  b _L81		# unconditional branch
  _L82:
	# _tmp678 = *(house)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp679 = *(_tmp678 + 20)
	  lw $t0, 20($t0) 	# load with offset
	# PushParam house
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp679
	  jalr $t0            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp680 = "Thank you for playing...come again soon.\n"
	  .data			# create string constant marked with label
	  _string67: .asciiz "Thank you for playing...come again soon.\n"
	  .text
	  la $t0, _string67	# load label
	# PushParam _tmp680
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp681 = "\nCS143 BlackJack Copyright (c) 1999 by Peter Mor..."
	  .data			# create string constant marked with label
	  _string68: .asciiz "\nCS143 BlackJack Copyright (c) 1999 by Peter Mork.\n"
	  .text
	  la $t0, _string68	# load label
	# PushParam _tmp681
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp682 = "(2001 mods by jdz)\n"
	  .data			# create string constant marked with label
	  _string69: .asciiz "(2001 mods by jdz)\n"
	  .text
	  la $t0, _string69	# load label
	# PushParam _tmp682
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
