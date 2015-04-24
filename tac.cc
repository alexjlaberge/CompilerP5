/* File: tac.cc
 * ------------
 * Implementation of Location class and Instruction class/subclasses.
 */
  
#include "tac.h"
#include "mips.h"
#include <string.h>
#include <deque>

Location::Location(Segment s, int o, const char *name) :
  variableName(strdup(name)), segment(s), offset(o),
  reference(NULL) {}

 
void Instruction::Print() {
  printf("\t%s ;", printed);
  printf("\n");
}

void Instruction::Emit(Mips *mips) {
  if (*printed)
    mips->Emit("# %s", printed);   // emit TAC as comment into assembly
  EmitSpecific(mips);
}

LoadConstant::LoadConstant(Location *d, int v)
  : dst(d), val(v) {
  Assert(dst != NULL);
  sprintf(printed, "%s = %d", dst->GetName(), val);
  killSet.Append(dst);
}
void LoadConstant::EmitSpecific(Mips *mips) {
  mips->EmitLoadConstant(dst, val);
}

LoadStringConstant::LoadStringConstant(Location *d, const char *s)
  : dst(d) {
  Assert(dst != NULL && s != NULL);
  const char *quote = (*s == '"') ? "" : "\"";
  str = new char[strlen(s) + 2*strlen(quote) + 1];
  sprintf(str, "%s%s%s", quote, s, quote);
  quote = (strlen(str) > 50) ? "...\"" : "";
  sprintf(printed, "%s = %.50s%s", dst->GetName(), str, quote);
  killSet.Append(dst);
}
void LoadStringConstant::EmitSpecific(Mips *mips) {
  mips->EmitLoadStringConstant(dst, str);
}

     

LoadLabel::LoadLabel(Location *d, const char *l)
  : dst(d), label(strdup(l)) {
  Assert(dst != NULL && label != NULL);
  sprintf(printed, "%s = %s", dst->GetName(), label);
  killSet.Append(dst);
}
void LoadLabel::EmitSpecific(Mips *mips) {
  mips->EmitLoadLabel(dst, label);
}



#include <iostream>
Assign::Assign(Location *d, Location *s)
  : dst(d), src(s) {
  Assert(dst != NULL && src != NULL);
  sprintf(printed, "%s = %s", dst->GetName(), src->GetName());
  killSet.Append(dst);
  genSet.Append(src);
}
void Assign::EmitSpecific(Mips *mips) {
  mips->EmitCopy(dst, src);
}



Load::Load(Location *d, Location *s, int off)
  : dst(d), src(s), offset(off) {
  Assert(dst != NULL && src != NULL);
  if (offset) 
    sprintf(printed, "%s = *(%s + %d)", dst->GetName(), src->GetName(), offset);
  else
    sprintf(printed, "%s = *(%s)", dst->GetName(), src->GetName());
	
  killSet.Append(dst);
  genSet.Append(src);
}
void Load::EmitSpecific(Mips *mips) {
  mips->EmitLoad(dst, src, offset);
}



Store::Store(Location *d, Location *s, int off)
  : dst(d), src(s), offset(off) {
  Assert(dst != NULL && src != NULL);
  if (offset)
  {
    sprintf(printed, "*(%s + %d) = %s", dst->GetName(), offset, src->GetName());
  }
  else
  {
    sprintf(printed, "*(%s) = %s", dst->GetName(), src->GetName());
  }
  genSet.Append(dst);
  genSet.Append(src);
}
void Store::EmitSpecific(Mips *mips) {
  mips->EmitStore(dst, src, offset);
}

 
const char * const BinaryOp::opName[Mips::NumOps]  = {"+", "-", "*", "/", "%", "==", "<", "&&", "||"};;

Mips::OpCode BinaryOp::OpCodeForName(const char *name) {
  for (int i = 0; i < Mips::NumOps; i++) 
    if (opName[i] && !strcmp(opName[i], name))
	return (Mips::OpCode)i;
  Failure("Unrecognized Tac operator: '%s'\n", name);
  return Mips::Add; // can't get here, but compiler doesn't know that
}

BinaryOp::BinaryOp(Mips::OpCode c, Location *d, Location *o1, Location *o2)
  : code(c), dst(d), op1(o1), op2(o2) {
  Assert(dst != NULL && op1 != NULL && op2 != NULL);
  Assert(code >= 0 && code < Mips::NumOps);
  sprintf(printed, "%s = %s %s %s", dst->GetName(), op1->GetName(), opName[code], op2->GetName());
  killSet.Append(dst);
  genSet.Append(op1);
  genSet.Append(op2);
}
void BinaryOp::EmitSpecific(Mips *mips) {	  
  mips->EmitBinaryOp(code, dst, op1, op2);
}



Label::Label(const char *l) : label(strdup(l)) {
  Assert(label != NULL);
  *printed = '\0';
}
void Label::Print() {
  printf("%s:\n", label);
}
void Label::EmitSpecific(Mips *mips) {
  mips->EmitLabel(label);
}


 
Goto::Goto(const char *l) : label(strdup(l)) {
  Assert(label != NULL);
  sprintf(printed, "Goto %s", label);
}
void Goto::EmitSpecific(Mips *mips) {	  
  mips->EmitGoto(label);
}


IfZ::IfZ(Location *te, const char *l)
   : test(te), label(strdup(l)) {
  Assert(test != NULL && label != NULL);
  sprintf(printed, "IfZ %s Goto %s", test->GetName(), label);
  genSet.Append(test);
}
void IfZ::EmitSpecific(Mips *mips) {	  
  mips->EmitIfZ(test, label);
}


#include <iostream>


BeginFunc::BeginFunc() {
  sprintf(printed,"BeginFunc (unassigned)");
  frameSize = -555; // used as sentinel to recognized unassigned value
}
void BeginFunc::SetFrameSize(int numBytesForAllLocalsAndTemps) {
  frameSize = numBytesForAllLocalsAndTemps; 
  sprintf(printed,"BeginFunc %d", frameSize);
}
void BeginFunc::EmitSpecific(Mips *mips) {
  mips->EmitBeginFunction(frameSize);

        for (size_t i = 0; i < inSet.NumElements(); i++)
        {
                mips->FillRegister(inSet.Nth(i), inSet.Nth(i)->GetRegister());
        }
}


EndFunc::EndFunc() : Instruction() {
  sprintf(printed, "EndFunc");
}
void EndFunc::EmitSpecific(Mips *mips) {
  mips->EmitEndFunction();
}


 
Return::Return(Location *v) : val(v) {
  sprintf(printed, "Return %s", val? val->GetName() : "");
  if(val)
  	genSet.Append(val);
}
void Return::EmitSpecific(Mips *mips) {	  
  mips->EmitReturn(val);
}



PushParam::PushParam(Location *p)
  :  param(p) {
  Assert(param != NULL);
  sprintf(printed, "PushParam %s", param->GetName());
  genSet.Append(param);
}
void PushParam::EmitSpecific(Mips *mips) {
  mips->EmitParam(param);
} 


PopParams::PopParams(int nb)
  :  numBytes(nb) {
  sprintf(printed, "PopParams %d", numBytes);
}
void PopParams::EmitSpecific(Mips *mips) {
  mips->EmitPopParams(numBytes);
} 


LCall::LCall(const char *l, Location *d)
  :  label(strdup(l)), dst(d) {
  sprintf(printed, "%s%sLCall %s", dst? dst->GetName(): "", dst?" = ":"", label);
  if(dst)
    killSet.Append(dst);
}
void LCall::EmitSpecific(Mips *mips) {
        for (size_t i = 0; i < inSet.NumElements(); i++)
        {
                mips->SpillRegister(inSet.Nth(i),
                                inSet.Nth(i)->GetRegister());
        }

  mips->EmitLCall(dst, label);

        for (size_t i = 0; i < inSet.NumElements(); i++)
        {
                mips->FillRegister(inSet.Nth(i),
                                inSet.Nth(i)->GetRegister());
        }
}


ACall::ACall(Location *ma, Location *d)
  : dst(d), methodAddr(ma) {
  Assert(methodAddr != NULL);
  sprintf(printed, "%s%sACall %s", dst? dst->GetName(): "", dst?" = ":"",
	    methodAddr->GetName());
  if (dst)
  {
          killSet.Append(dst);
  }
  genSet.Append(methodAddr);
}
void ACall::EmitSpecific(Mips *mips) {
        for (size_t i = 0; i < inSet.NumElements(); i++)
        {
                if (inSet.Nth(i) == methodAddr)
                {
                        continue;
                }
                mips->SpillRegister(inSet.Nth(i),
                                inSet.Nth(i)->GetRegister());
        }

  mips->EmitACall(dst, methodAddr);

        for (size_t i = 0; i < inSet.NumElements(); i++)
        {
                if (inSet.Nth(i) == methodAddr)
                {
                        continue;
                }
                mips->FillRegister(inSet.Nth(i),
                                inSet.Nth(i)->GetRegister());
        }
} 



VTable::VTable(const char *l, List<const char *> *m)
  : methodLabels(m), label(strdup(l)) {
  Assert(methodLabels != NULL && label != NULL);
  sprintf(printed, "VTable for class %s", l);
}

void VTable::Print() {
  printf("VTable %s =\n", label);
  for (int i = 0; i < methodLabels->NumElements(); i++) 
    printf("\t%s,\n", methodLabels->Nth(i));
  printf("; \n"); 
}
void VTable::EmitSpecific(Mips *mips) {
  mips->EmitVTable(label, methodLabels);
}


