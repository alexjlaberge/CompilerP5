/* File: codegen.cc
 * ----------------
 * Implementation for the CodeGenerator class. The methods don't do anything
 * too fancy, mostly just create objects of the various Tac instruction
 * classes and append them to the list.
 */

#include "codegen.h"
#include <string.h>
#include "tac.h"
#include "mips.h"
#include "ast_decl.h"
#include "errors.h"
#include <stack>
#include <cassert>

using std::vector;
using std::stack;
using namespace std;

 class Mips;

    void CodeGenerator::setRegs()
    {
    	for(int i = 0; i < locs.size(); i++)
    	{
    		//locs[i]->SetRegister(Mips::t0);
    		//Mips::regs[Mips::t0].isDirty = true;
    	}
    }

void CodeGenerator::constructCFG() //Done?
{
  for(int i = 0; i < code->NumElements() - 1; i++)
  {
    if(dynamic_cast<IfZ*>(code->Nth(i)))
    {
      code->Nth(i)->addEdge(labels.Lookup(((IfZ*)code->Nth(i))->GetLabel()));
      //Add label location to Instructions neighbors
    }
    else if(dynamic_cast<Goto*>(code->Nth(i)))
    {
    	code->Nth(i)->addEdge(labels.Lookup(((Goto*)code->Nth(i))->GetLabel()));
      //Add label location to Instructions neighbors
      continue;
    }
    else if(dynamic_cast<Return*>(code->Nth(i)))
    {
            continue;
    }
    else if(dynamic_cast<EndFunc*>(code->Nth(i)))
    {
            continue;
    }

    code->Nth(i)->addEdge(code->Nth(i+1));
    //Add next instruction to Instructions neighbors
  }
}
  
void CodeGenerator::livelinessAnalysis()
{
  Instruction *currInst;
  bool changed = true;
  while(changed)
  {
    changed = false;
    for(int i = 0; i < code->NumElements(); i++)
    {
      currInst = code->Nth(i);
      List<Instruction*> edges = currInst->getEdges();
      List<Location*> outSet;
      List<Location*> inSet;
      List<Location*> old_IN = currInst->inSet;
      for(int j = 0; j < edges.NumElements(); j++)
      {
        Instruction* currEdge = edges.Nth(j);
        List<Location*> edgeInSet = currEdge->inSet;
        for(int k = 0; k < edgeInSet.NumElements(); k++)
        {
          Location* currElem = edgeInSet.Nth(k);
          outSet.Append(currElem);
          outSet.Unique();
        }
        List<Location*> genSet = currInst->genSet;
        List<Location*> killSet = currInst->killSet;
        //OUT(X) = Union(IN(Y))
        currInst->outSet = outSet;
        for(int j = 0; j < genSet.NumElements(); j++)
        {
        	inSet.Append(genSet.Nth(j));
        }
        List<Location*> tmpList;
        for(int j = 0; j < outSet.NumElements(); j++)
        {
        	tmpList.Append(outSet.Nth(j));
        }
        for(int j = 0; j < tmpList.NumElements(); j++)
        {
        	for(int k = 0; k < killSet.NumElements(); k++)
        	{
        		if(tmpList.Nth(j) == killSet.Nth(k))
        		{
        			tmpList.RemoveAt(j);
        			j--;
        			break;
        		}
        	}
        }
        for(int j = 0; j < tmpList.NumElements(); j++)
        {
        	Location* currElem = tmpList.Nth(j);
          inSet.Append(currElem);
          inSet.Unique();
        }
        inSet.Unique();
        outSet.Unique();
        old_IN.Unique();
        currInst->outSet = outSet;
        currInst->inSet = inSet;
        /*if(inSet.NumElements() != old_IN.NumElements())
        {	
          changed = true;
          cerr << "diffnum " << currInst->PrintName() << endl;
          for(int j = 0; j < inSet.NumElements(); j++)
          {
            cerr << "INSET: ";
            cerr << inSet.Nth(j)->GetName() << endl;
          }
        for(int j = 0; j < old_IN.NumElements(); j++)
        {
          cerr << "OLDINSET: ";
          cerr << old_IN.Nth(j)->GetName() << endl;
        }

        }*/
        //else
        //{
        	for(int j = 0; j < inSet.NumElements(); j++)
        	{
        		Location* currElem = inSet.Nth(j);
	          	bool foundElem = false;
	          	for(int k = 0; k < old_IN.NumElements(); k++)
	          	{
	            	if(old_IN.Nth(k) == currElem)
	            	{
	              		foundElem = true;
	            	}
	          	}
	          	if(!foundElem)
	          	{
	            	changed = true;
                //cerr << currInst->PrintName() << endl;
	          	}
        	}
        //}
      }
    }
    //old_IN = IN(X);
    //OUT(X) = Union(IN(Y)) for all successors Y of X
    //IN(X) = GEN(X) + (OUT(X) - KILL(X))


    
  }

}

void CodeGenerator::printSets()
{
  Instruction* currInst;
  for(int i = 0; i < code->NumElements(); i++)
    {
        currInst = code->Nth(i);
        List<Location*> inSet = currInst->inSet;
        List<Location*> genSet = currInst->genSet;
        List<Location*> outSet = currInst->outSet;
        List<Location*> killSet = currInst->killSet;
        cerr << "INSTRUCTION: " << currInst->PrintName() << endl;
        for(int j = 0; j < inSet.NumElements(); j++)
        {
          cerr << "INSET: ";
          cerr << inSet.Nth(j)->GetName() << endl;
        }
        for(int j = 0; j < outSet.NumElements(); j++)
        {
          cerr << "OUTSET: ";
          cerr << outSet.Nth(j)->GetName() << endl;
        }
        for(int j = 0; j < killSet.NumElements(); j++)
        {
          cerr << "KILLSET: ";
          if(killSet.Nth(j)->GetName())
          cerr << killSet.Nth(j)->GetName() << endl;
        }
        for(int j = 0; j < genSet.NumElements(); j++)
        {
          cerr << "GENSET: ";
          cerr << genSet.Nth(j)->GetName() << endl;
        }
        cerr << endl;
    }
}

void CodeGenerator::printRegs()
{
  for(int i = 0; i < locs.size(); i++)
  {
    Mips mips;
    if(locs[i]->GetRegister())
      cerr << locs[i]->GetName() << " " << mips.regs[locs[i]->GetRegister()].name << endl;
    else 
      cerr << "Poop" << endl;
  }
}

void CodeGenerator::constructInterGraph()
{
	for(int i = 0; i < code->NumElements(); i++)
	{
		List<Location*> outSet = code->Nth(i)->outSet;
		List<Location*> killSet = code->Nth(i)->killSet;
		for(int j = 0; j < outSet.NumElements(); j++)
		{
			for(int k = 0; k < killSet.NumElements(); k++)
			{
                                outSet.Nth(j)->edges.Append(killSet.Nth(k));
                                killSet.Nth(k)->edges.Append(outSet.Nth(j));

                                outSet.Nth(j)->edges.Unique();
                                killSet.Nth(k)->edges.Unique();
			}

                        for (int k = 0; k < outSet.NumElements(); k++)
                        {
                                if (j == k)
                                {
                                        continue;
                                }
                                outSet.Nth(j)->edges.Append(outSet.Nth(k));
                                outSet.Nth(j)->edges.Unique();
                        }
		}
	}
}

class Comp
{
public:
        Comp(const Location *thing) : mine(thing) {}

        bool operator()(const Location *heyo) const
        {
                return heyo == mine;
        }

private:
        const Location *mine;
};

size_t real_size(List<Location *> &graph, vector<Location *> &ignore)
{
        size_t size = graph.NumElements();

        for (size_t i = 0; i < graph.NumElements(); i++)
        {
                for (auto &ig : ignore)
                {
                        if (graph.Nth(i) == ig)
                        {
                                size--;
                                break;
                        }
                }
        }

        assert(size <= graph.NumElements());
        assert(size >= 0);

        return size;
}

bool vec_find(vector<Location *> &v, const Location *l)
{
        for (const auto &loc : v)
        {
                if (l == loc)
                {
                        return true;
                }
        }
        return false;
}

void CodeGenerator::color()
{
        stack<Location *> s;
        vector<Location *> ignore;
        int k = 18;
        auto g = locs;

        while (s.size() < g.size()) {
                int init_size = s.size();
                Location *most_cons = *(g.begin());

                for (const auto &node : g) {
                        bool add = false;

                        if (vec_find(ignore, node) == false &&
                                        real_size(node->edges, ignore) < k) {
                                s.push(node);
                                ignore.push_back(node);
                                break;
                        } else if (real_size(node->edges, ignore) >
                                        real_size(most_cons->edges, ignore)) {
                                most_cons = node;
                        }
                }

                if (init_size == s.size()) {
                        ignore.push_back(most_cons);
                }
        }

        while (s.size() > 0) {
                vector<Mips::Register> available;
                int color = 0;

                available.push_back(Mips::t0);
                available.push_back(Mips::t1);
                available.push_back(Mips::t2);
                available.push_back(Mips::t3);
                available.push_back(Mips::t4);
                available.push_back(Mips::t5);
                available.push_back(Mips::t6);
                available.push_back(Mips::t7);
                available.push_back(Mips::t8);
                available.push_back(Mips::t9);
                available.push_back(Mips::s0);
                available.push_back(Mips::s1);
                available.push_back(Mips::s2);
                available.push_back(Mips::s3);
                available.push_back(Mips::s4);
                available.push_back(Mips::s5);
                available.push_back(Mips::s6);
                available.push_back(Mips::s7);

                for (size_t i = 0; i < s.top()->edges.NumElements(); i++)
                {
                        if (s.top()->edges.Nth(i)->GetRegister() == NULL)
                        {
                                continue;
                        }

                        for (size_t j = 0; j < available.size(); j++)
                        {
                                if (available[j] == s.top()->edges.Nth(i)->GetRegister())
                                {
                                        available.erase(available.begin() + j);
                                        break;
                                }
                        }
                }

                /* cerr << "Allocating " << *(available.begin()) << endl; */
                s.top()->SetRegister(*(available.begin()));
                s.pop();
        }
}


CodeGenerator::CodeGenerator()
{
  code = new List<Instruction*>();
  curGlobalOffset = 0;
}

char *CodeGenerator::NewLabel()
{
  static int nextLabelNum = 0;
  char temp[10];
  sprintf(temp, "_L%d", nextLabelNum++);
  return strdup(temp);
}


Location *CodeGenerator::GenTempVariable()
{
  static int nextTempNum;
  char temp[10];
  Location *result = NULL;
  sprintf(temp, "_tmp%d", nextTempNum++);
  return GenLocalVariable(temp);
}

  
Location *CodeGenerator::GenLocalVariable(const char *varName)
{            
    curStackOffset -= VarSize;
    Location *loc = new Location(fpRelative, curStackOffset+4, varName);
    locs.push_back(loc);
    return loc;
}

Location *CodeGenerator::GenGlobalVariable(const char *varName)
{
    curGlobalOffset += VarSize;
    Location *loc = new Location(gpRelative, curGlobalOffset-4, varName);
    locs.push_back(loc);
    return loc;
}

Location *CodeGenerator::GenParameter(int index, const char *varName)
{
    Location *loc = new Location(fpRelative, OffsetToFirstParam+index*VarSize, varName);
    locs.push_back(loc);
    return loc;
}

Location *CodeGenerator::GenIndirect(Location* base, int offset)
{
    Location *loc = new Location(base, offset);
    locs.push_back(loc);
    return loc;
}


Location *CodeGenerator::GenLoadConstant(int value)
{
  Location *result = GenTempVariable();
  code->Append(new LoadConstant(result, value));
  return result;
}

Location *CodeGenerator::GenLoadConstant(const char *s)
{
  Location *result = GenTempVariable();
  code->Append(new LoadStringConstant(result, s));
  return result;
} 

Location *CodeGenerator::GenLoadLabel(const char *label)
{
  Location *result = GenTempVariable();
  code->Append(new LoadLabel(result, label));
  return result;
} 


void CodeGenerator::GenAssign(Location *dst, Location *src)
{
  code->Append(new Assign(dst, src));
}


Location *CodeGenerator::GenLoad(Location *ref, int offset)
{
  Location *result = GenTempVariable();
  code->Append(new Load(result, ref, offset));
  return result;
}

void CodeGenerator::GenStore(Location *dst,Location *src, int offset)
{
  code->Append(new Store(dst, src, offset));
}


Location *CodeGenerator::GenBinaryOp(const char *opName, Location *op1,
						     Location *op2)
{
  Location *result = GenTempVariable();
  code->Append(new BinaryOp(BinaryOp::OpCodeForName(opName), result, op1, op2));
  return result;
}


void CodeGenerator::GenLabel(const char *label)
{
  Label *tmp = new Label(label);
  labels.Enter(label, tmp);
  code->Append(tmp);
}

void CodeGenerator::GenIfZ(Location *test, const char *label)
{
  code->Append(new IfZ(test, label));
}

void CodeGenerator::GenGoto(const char *label)
{
  code->Append(new Goto(label));
}

void CodeGenerator::GenReturn(Location *val)
{
  code->Append(new Return(val));
}


BeginFunc *CodeGenerator::GenBeginFunc()
{
  BeginFunc *result = new BeginFunc;
  code->Append(result);
  insideFn = code->NumElements() - 1;
  curStackOffset = OffsetToFirstLocal;
  return result;
}

void CodeGenerator::GenEndFunc()
{
  code->Append(new EndFunc());
  BeginFunc *beginFunc = dynamic_cast<BeginFunc*>(code->Nth(insideFn));
  Assert(beginFunc != NULL);
  beginFunc->SetFrameSize(OffsetToFirstLocal-curStackOffset);
}

void CodeGenerator::GenPushParam(Location *param)
{
  code->Append(new PushParam(param));
}

void CodeGenerator::GenPopParams(int numBytesOfParams)
{
  Assert(numBytesOfParams >= 0 && numBytesOfParams % VarSize == 0); // sanity check
  if (numBytesOfParams > 0)
    code->Append(new PopParams(numBytesOfParams));
}

Location *CodeGenerator::GenLCall(const char *label, bool fnHasReturnValue)
{
  Location *result = fnHasReturnValue ? GenTempVariable() : NULL;
  code->Append(new LCall(label, result));
  return result;
}
  
Location *CodeGenerator::GenFunctionCall(const char *fnLabel, List<Location*> *args, bool hasReturnValue)
{
  for (int i = args->NumElements()-1; i >= 0; i--) // push params right to left
    GenPushParam(args->Nth(i));
  Location *result = GenLCall(fnLabel, hasReturnValue);
  GenPopParams(args->NumElements()*VarSize);
  return result;
}

Location *CodeGenerator::GenACall(Location *fnAddr, bool fnHasReturnValue)
{
  Location *result = fnHasReturnValue ? GenTempVariable() : NULL;
  code->Append(new ACall(fnAddr, result));
  return result;
}
  
Location *CodeGenerator::GenMethodCall(Location *rcvr,
			     Location *meth, List<Location*> *args, bool fnHasReturnValue)
{
  for (int i = args->NumElements()-1; i >= 0; i--)
    GenPushParam(args->Nth(i));
  GenPushParam(rcvr);	// hidden "this" parameter
  Location *result= GenACall(meth, fnHasReturnValue);
  GenPopParams((args->NumElements()+1)*VarSize);
  return result;
}
 
 
static struct _builtin {
  const char *label;
  int numArgs;
  bool hasReturn;
} builtins[] =
 {{"_Alloc", 1, true},
  {"_ReadLine", 0, true},
  {"_ReadInteger", 0, true},
  {"_StringEqual", 2, true},
  {"_PrintInt", 1, false},
  {"_PrintString", 1, false},
  {"_PrintBool", 1, false},
  {"_Halt", 0, false}};

Location *CodeGenerator::GenBuiltInCall(BuiltIn bn,Location *arg1, Location *arg2)
{
  Assert(bn >= 0 && bn < NumBuiltIns);
  struct _builtin *b = &builtins[bn];
  Location *result = NULL;

  if (b->hasReturn) result = GenTempVariable();
                // verify appropriate number of non-NULL arguments given
  Assert((b->numArgs == 0 && !arg1 && !arg2)
	|| (b->numArgs == 1 && arg1 && !arg2)
	|| (b->numArgs == 2 && arg1 && arg2));
  if (arg2) code->Append(new PushParam(arg2));
  if (arg1) code->Append(new PushParam(arg1));
  code->Append(new LCall(b->label, result));
  GenPopParams(VarSize*b->numArgs);
  return result;
}


void CodeGenerator::GenVTable(const char *className, List<const char *> *methodLabels)
{
  code->Append(new VTable(className, methodLabels));
}


void CodeGenerator::DoFinalCodeGen()
{
  if (IsDebugOn("tac")) { // if debug don't translate to mips, just print Tac
    for (int i = 0; i < code->NumElements(); i++)
      code->Nth(i)->Print();
  } else {
    Mips mips;
    mips.EmitPreamble();
    for (int i = 0; i < code->NumElements(); i++)
      code->Nth(i)->Emit(&mips);
  }
}



Location *CodeGenerator::GenArrayLen(Location *array)
{
  return GenLoad(array, -4);
}

Location *CodeGenerator::GenNew(const char *vTableLabel, int instanceSize)
{
  Location *size = GenLoadConstant(instanceSize);
  Location *result = GenBuiltInCall(Alloc, size);
  Location *vt = GenLoadLabel(vTableLabel);
  GenStore(result, vt);
  return result;
}


Location *CodeGenerator::GenDynamicDispatch(Location *rcvr, int vtableOffset, List<Location*> *args, bool hasReturnValue)
{
  Location *vptr = GenLoad(rcvr); // load vptr
  Assert(vtableOffset >= 0);
  Location *m = GenLoad(vptr, vtableOffset*4);
  return GenMethodCall(rcvr, m, args, hasReturnValue);
}

// all variables (ints, bools, ptrs, arrays) are 4 bytes in for code generation
// so this simplifies the math for offsets
Location *CodeGenerator::GenSubscript(Location *array, Location *index)
{
  Location *zero = GenLoadConstant(0);
  Location *isNegative = GenBinaryOp("<", index, zero);
  Location *count = GenLoad(array, -4);
  Location *isWithinRange = GenBinaryOp("<", index, count);
  Location *pastEnd = GenBinaryOp("==", isWithinRange, zero);
  Location *outOfRange = GenBinaryOp("||", isNegative, pastEnd);
  const char *pastError = NewLabel();
  GenIfZ(outOfRange, pastError);
  GenHaltWithMessage(err_arr_out_of_bounds);
  GenLabel(pastError);
  Location *four = GenLoadConstant(VarSize);
  Location *offset = GenBinaryOp("*", four, index);
  Location *elem = GenBinaryOp("+", array, offset);
  return GenIndirect(elem, 0); 
}



Location *CodeGenerator::GenNewArray(Location *numElems)
{
  Location *one = GenLoadConstant(1);
  Location *isNonpositive = GenBinaryOp("<", numElems, one);
  const char *pastError = NewLabel();
  GenIfZ(isNonpositive, pastError);
  GenHaltWithMessage(err_arr_bad_size);
  GenLabel(pastError);

  // need (numElems+1)*VarSize total bytes (extra 1 is for length)
  Location *arraySize = GenLoadConstant(1);
  Location *num = GenBinaryOp("+", arraySize, numElems);
  Location *four = GenLoadConstant(VarSize);
  Location *bytes = GenBinaryOp("*", num, four);
  Location *result = GenBuiltInCall(Alloc, bytes);
  GenStore(result, numElems);
  return GenBinaryOp("+", result, four);
}

void CodeGenerator::GenHaltWithMessage(const char *message)
{
   Location *msg = GenLoadConstant(message);
   GenBuiltInCall(PrintString, msg);
   GenBuiltInCall(Halt, NULL);
}

