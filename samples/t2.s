	# standard Decaf preamble 
	  .text
	  .align 2
	  .globl main
  _tester:
	# BeginFunc 188
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 188	# decrement sp to make space for locals/temps
	  lw $t3, 4($fp)	# fill sz to $t3 from $fp+4
	# _tmp0 = 1
	  li $t2, 1		# load constant value 1 into $t2
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
	  sw $t3, 4($fp)	# spill sz from $t3 to $fp+4
	  sw $t2, -16($fp)	# spill _tmp0 from $t2 to $fp-16
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill sz to $t3 from $fp+4
	  lw $t2, -16($fp)	# fill _tmp0 to $t2 from $fp-16
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t3, 4($fp)	# spill sz from $t3 to $fp+4
	  sw $t2, -16($fp)	# spill _tmp0 from $t2 to $fp-16
	  jal _Halt          	# jump to function
	  lw $t3, 4($fp)	# fill sz to $t3 from $fp+4
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
	  sw $t3, 4($fp)	# spill sz from $t3 to $fp+4
	  sw $t2, -16($fp)	# spill _tmp0 from $t2 to $fp-16
	  sw $t1, -40($fp)	# spill _tmp6 from $t1 to $fp-40
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t3, 4($fp)	# fill sz to $t3 from $fp+4
	  lw $t2, -16($fp)	# fill _tmp0 to $t2 from $fp-16
	  lw $t1, -40($fp)	# fill _tmp6 to $t1 from $fp-40
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp8) = _tmp0
	  sw $t2, 0($t0) 	# store with offset
	# _tmp9 = _tmp8 + _tmp6
	  add $t0, $t0, $t1	
	# b = _tmp9
	  sw $t0, 4($gp)	# spill b from $t0 to $gp+4
	# _tmp10 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp11 = sz < _tmp10
	  slt $t0, $t3, $t0	
	# IfZ _tmp11 Goto _L1
	  beqz $t0, _L1	# branch if _tmp11 is zero 
	# _tmp12 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string2: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t0, _string2	# load label
	# PushParam _tmp12
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill sz from $t3 to $fp+4
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill sz to $t3 from $fp+4
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t3, 4($fp)	# spill sz from $t3 to $fp+4
	  jal _Halt          	# jump to function
	  lw $t3, 4($fp)	# fill sz to $t3 from $fp+4
  _L1:
	# _tmp13 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp14 = _tmp13 + sz
	  add $t0, $t0, $t3	
	# _tmp15 = 4
	  li $t1, 4		# load constant value 4 into $t1
	# _tmp16 = _tmp14 * _tmp15
	  mul $t0, $t0, $t1	
	# PushParam _tmp16
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp17 = LCall _Alloc
	  sw $t3, 4($fp)	# spill sz from $t3 to $fp+4
	  sw $t1, -76($fp)	# spill _tmp15 from $t1 to $fp-76
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	  lw $t3, 4($fp)	# fill sz to $t3 from $fp+4
	  lw $t1, -76($fp)	# fill _tmp15 to $t1 from $fp-76
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp17) = sz
	  sw $t3, 0($t0) 	# store with offset
	# _tmp18 = _tmp17 + _tmp15
	  add $t0, $t0, $t1	
	# result = _tmp18
	  move $t4, $t0	# copy regs
	# _tmp19 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp19
	  move $t5, $t0	# copy regs
  _L2:
	# _tmp20 = i < sz
	  slt $t0, $t5, $t3	
	# IfZ _tmp20 Goto _L3
	  beqz $t0, _L3	# branch if _tmp20 is zero 
	# _tmp21 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp22 = i < _tmp21
	  slt $t1, $t5, $t2	
	# _tmp23 = *(result + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp24 = i < _tmp23
	  slt $t0, $t5, $t0	
	# _tmp25 = _tmp24 == _tmp21
	  seq $t0, $t0, $t2	
	# _tmp26 = _tmp22 || _tmp25
	  or $t0, $t1, $t0	
	# IfZ _tmp26 Goto _L4
	  beqz $t0, _L4	# branch if _tmp26 is zero 
	# _tmp27 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string3: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string3	# load label
	# PushParam _tmp27
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, 4($fp)	# spill sz from $t3 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t4, -12($fp)	# spill result from $t4 to $fp-12
	  jal _PrintString   	# jump to function
	  lw $t3, 4($fp)	# fill sz to $t3 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t4, -12($fp)	# fill result to $t4 from $fp-12
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t3, 4($fp)	# spill sz from $t3 to $fp+4
	  sw $t5, -8($fp)	# spill i from $t5 to $fp-8
	  sw $t4, -12($fp)	# spill result from $t4 to $fp-12
	  jal _Halt          	# jump to function
	  lw $t3, 4($fp)	# fill sz to $t3 from $fp+4
	  lw $t5, -8($fp)	# fill i to $t5 from $fp-8
	  lw $t4, -12($fp)	# fill result to $t4 from $fp-12
  _L4:
	# _tmp28 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp29 = _tmp28 * i
	  mul $t0, $t0, $t5	
	# _tmp30 = result + _tmp29
	  add $t0, $t4, $t0	
	# *(_tmp30) = i
	  sw $t5, 0($t0) 	# store with offset
	# _tmp31 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp32 = i + _tmp31
	  add $t0, $t5, $t0	
	# i = _tmp32
	  move $t5, $t0	# copy regs
	# Goto _L2
	  b _L2		# unconditional branch
  _L3:
	# _tmp33 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp34 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp35 = _tmp33 < _tmp34
	  slt $t1, $t3, $t2	
	# _tmp36 = *(b + -4)
	  lw $v0, 4($gp)	# fill b to $v0 from $gp+4
	  lw $t0, -4($v0) 	# load with offset
	# _tmp37 = _tmp33 < _tmp36
	  slt $t0, $t3, $t0	
	# _tmp38 = _tmp37 == _tmp34
	  seq $t0, $t0, $t2	
	# _tmp39 = _tmp35 || _tmp38
	  or $t0, $t1, $t0	
	# IfZ _tmp39 Goto _L5
	  beqz $t0, _L5	# branch if _tmp39 is zero 
	# _tmp40 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string4: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string4	# load label
	# PushParam _tmp40
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t4, -12($fp)	# spill result from $t4 to $fp-12
	  sw $t3, -148($fp)	# spill _tmp33 from $t3 to $fp-148
	  jal _PrintString   	# jump to function
	  lw $t4, -12($fp)	# fill result to $t4 from $fp-12
	  lw $t3, -148($fp)	# fill _tmp33 to $t3 from $fp-148
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t4, -12($fp)	# spill result from $t4 to $fp-12
	  sw $t3, -148($fp)	# spill _tmp33 from $t3 to $fp-148
	  jal _Halt          	# jump to function
	  lw $t4, -12($fp)	# fill result to $t4 from $fp-12
	  lw $t3, -148($fp)	# fill _tmp33 to $t3 from $fp-148
  _L5:
	# _tmp41 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp42 = _tmp41 * _tmp33
	  mul $t0, $t0, $t3	
	# _tmp43 = b + _tmp42
	  lw $v0, 4($gp)	# fill b to $v0 from $gp+4
	  add $t1, $v0, $t0	
	# _tmp44 = "Done"
	  .data			# create string constant marked with label
	  _string5: .asciiz "Done"
	  .text
	  la $t0, _string5	# load label
	# *(_tmp43) = _tmp44
	  sw $t0, 0($t1) 	# store with offset
	# Return result
	  move $v0, $t4		# assign return value into $v0
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
	# BeginFunc 168
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 168	# decrement sp to make space for locals/temps
	# _tmp45 = 8
	  li $t0, 8		# load constant value 8 into $t0
	# PushParam _tmp45
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp46 = LCall _tester
	  jal _tester        	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# d = _tmp46
	  move $t4, $t0	# copy regs
	# _tmp47 = 1
	  li $t3, 1		# load constant value 1 into $t3
	# _tmp48 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp49 = _tmp47 < _tmp48
	  slt $t1, $t3, $t2	
	# _tmp50 = *(d + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp51 = _tmp47 < _tmp50
	  slt $t0, $t3, $t0	
	# _tmp52 = _tmp51 == _tmp48
	  seq $t0, $t0, $t2	
	# _tmp53 = _tmp49 || _tmp52
	  or $t0, $t1, $t0	
	# IfZ _tmp53 Goto _L6
	  beqz $t0, _L6	# branch if _tmp53 is zero 
	# _tmp54 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string6: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string6	# load label
	# PushParam _tmp54
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t4, -8($fp)	# spill d from $t4 to $fp-8
	  sw $t3, -20($fp)	# spill _tmp47 from $t3 to $fp-20
	  jal _PrintString   	# jump to function
	  lw $t4, -8($fp)	# fill d to $t4 from $fp-8
	  lw $t3, -20($fp)	# fill _tmp47 to $t3 from $fp-20
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t4, -8($fp)	# spill d from $t4 to $fp-8
	  sw $t3, -20($fp)	# spill _tmp47 from $t3 to $fp-20
	  jal _Halt          	# jump to function
	  lw $t4, -8($fp)	# fill d to $t4 from $fp-8
	  lw $t3, -20($fp)	# fill _tmp47 to $t3 from $fp-20
  _L6:
	# _tmp55 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp56 = _tmp55 * _tmp47
	  mul $t0, $t0, $t3	
	# _tmp57 = d + _tmp56
	  add $t0, $t4, $t0	
	# _tmp58 = *(_tmp57)
	  lw $t3, 0($t0) 	# load with offset
	# _tmp59 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp60 = _tmp58 < _tmp59
	  slt $t1, $t3, $t2	
	# _tmp61 = *(d + -4)
	  lw $t0, -4($t4) 	# load with offset
	# _tmp62 = _tmp58 < _tmp61
	  slt $t0, $t3, $t0	
	# _tmp63 = _tmp62 == _tmp59
	  seq $t0, $t0, $t2	
	# _tmp64 = _tmp60 || _tmp63
	  or $t0, $t1, $t0	
	# IfZ _tmp64 Goto _L7
	  beqz $t0, _L7	# branch if _tmp64 is zero 
	# _tmp65 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string7: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string7	# load label
	# PushParam _tmp65
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t4, -8($fp)	# spill d from $t4 to $fp-8
	  sw $t3, -64($fp)	# spill _tmp58 from $t3 to $fp-64
	  jal _PrintString   	# jump to function
	  lw $t4, -8($fp)	# fill d to $t4 from $fp-8
	  lw $t3, -64($fp)	# fill _tmp58 to $t3 from $fp-64
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t4, -8($fp)	# spill d from $t4 to $fp-8
	  sw $t3, -64($fp)	# spill _tmp58 from $t3 to $fp-64
	  jal _Halt          	# jump to function
	  lw $t4, -8($fp)	# fill d to $t4 from $fp-8
	  lw $t3, -64($fp)	# fill _tmp58 to $t3 from $fp-64
  _L7:
	# _tmp66 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp67 = _tmp66 * _tmp58
	  mul $t0, $t0, $t3	
	# _tmp68 = d + _tmp67
	  add $t0, $t4, $t0	
	# _tmp69 = *(_tmp68)
	  lw $t0, 0($t0) 	# load with offset
	# PushParam _tmp69
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  sw $t4, -8($fp)	# spill d from $t4 to $fp-8
	  jal _PrintInt      	# jump to function
	  lw $t4, -8($fp)	# fill d to $t4 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp70 = "\n"
	  .data			# create string constant marked with label
	  _string8: .asciiz "\n"
	  .text
	  la $t0, _string8	# load label
	# PushParam _tmp70
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t4, -8($fp)	# spill d from $t4 to $fp-8
	  jal _PrintString   	# jump to function
	  lw $t4, -8($fp)	# fill d to $t4 from $fp-8
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp71 = *(d + -4)
	  lw $t0, -4($t4) 	# load with offset
	# PushParam _tmp71
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp72 = "\n"
	  .data			# create string constant marked with label
	  _string9: .asciiz "\n"
	  .text
	  la $t0, _string9	# load label
	# PushParam _tmp72
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp73 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp74 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp75 = _tmp73 < _tmp74
	  slt $t1, $t3, $t2	
	# _tmp76 = *(b + -4)
	  lw $v0, 4($gp)	# fill b to $v0 from $gp+4
	  lw $t0, -4($v0) 	# load with offset
	# _tmp77 = _tmp73 < _tmp76
	  slt $t0, $t3, $t0	
	# _tmp78 = _tmp77 == _tmp74
	  seq $t0, $t0, $t2	
	# _tmp79 = _tmp75 || _tmp78
	  or $t0, $t1, $t0	
	# IfZ _tmp79 Goto _L8
	  beqz $t0, _L8	# branch if _tmp79 is zero 
	# _tmp80 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string10: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string10	# load label
	# PushParam _tmp80
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t3, -124($fp)	# spill _tmp73 from $t3 to $fp-124
	  jal _PrintString   	# jump to function
	  lw $t3, -124($fp)	# fill _tmp73 to $t3 from $fp-124
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  sw $t3, -124($fp)	# spill _tmp73 from $t3 to $fp-124
	  jal _Halt          	# jump to function
	  lw $t3, -124($fp)	# fill _tmp73 to $t3 from $fp-124
  _L8:
	# _tmp81 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp82 = _tmp81 * _tmp73
	  mul $t0, $t0, $t3	
	# _tmp83 = b + _tmp82
	  lw $v0, 4($gp)	# fill b to $v0 from $gp+4
	  add $t0, $v0, $t0	
	# _tmp84 = *(_tmp83)
	  lw $t0, 0($t0) 	# load with offset
	# PushParam _tmp84
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp85 = "\n"
	  .data			# create string constant marked with label
	  _string11: .asciiz "\n"
	  .text
	  la $t0, _string11	# load label
	# PushParam _tmp85
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
