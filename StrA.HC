/*
---------------------------------------------------------------------------------------------------------
          DC       DR        RC        DC->Date Created, DR->Date Revised, RC->Revised Count
  Version 20250620-r20250625.3
---------------------------------------------------------------------------------------------------------
  Date Created: 2025-06-20
  Date Revised: 2025-07-03
  Author Name: Zeke S. Redgrave
  Description: Adding String Features for Holy C
  
  God Bless to you all including Mr.Terry, TempleOS, HolyC and JC 
---------------------------------------------------------------------------------------------------------
*/
U8 *StrCat(U8 *d, U8 *s){ 
        //Connecting from Source to Destination
        StrCpy(d+StrLen(d), s);
        return d;
}

I64 StrDLen(U8 *str, U8 *f){
        //Check and Get All Delimiter(Str) Count inside of Str
        I64 a=0,b,i=0,c=0,_f=StrLen(f);
        U8 *s=MAlloc(_f*sizeof(U8));
        
        while(a<StrLen(str)){
                if(a<_f) {
                        s[i]=str[a];
                        i++;
                }
                if(StrCmp(s,f)==FALSE) c++;

                for(b=0;b<_f;b++) s[b]=s[b+1];
                s[i-1]=str[a];
                                        
                a++;
        }
        Free(s);
        return c;
}

I64 *StrIAToken(U8 *str, U8 *f){
        //Get All StrIndexAt And Return Token with Int Contain
        
        //Check and Get All Delimiter(Str) Length inside of Str
        I64 a=0,b,i=0,c=0,_f=StrLen(f), *t=MAlloc(StrDLen(str,f)*sizeof(I64));
        U8 *s=MAlloc(_f*sizeof(U8));
        
        while(a<StrLen(str)){
                if(a<_f) {
                        s[i]=str[a];
                        i++;
                }
                if(StrCmp(s,f)==FALSE) {
                        t[c]=AbsI64(StrLen(f)-a);
                        c++;
                }

                for(b=0;b<_f;b++) s[b]=s[b+1];
                s[i-1]=str[a];
                                        
                a++;
        }
                
        Free(s);
        return t;
}


U64 *StrSplit(U8 *str, U8 *ch){
        //Splitting Whole Str into Multiple Str and Return Token with Str Contain
        U64 *p;
        U8 *s;
        I64 *IT=StrIAToken(str,ch), l=StrDLen(str,ch);
        I64 a=0,b=0;
        
        p=MAlloc(l*sizeof(U64));
        while(a<l){
                while(b<IT[a]){
                        s=MStrPrint("%s%c",s,str[b-1]);
                        b++;
                }
                b=StrLen(ch)+IT[a];
                p[a]=s;
                s=NULL;
                
                a++;
        }
        while(b<StrLen(str)) {
                s=MStrPrint("%s%c",s,str[b]);
                b++;
        }
        p[a]=s;
        
        s=NULL;
        Free(IT);
        
        return p;
}

I64 StrIndexAt(U8 *str, U8 *f){ 
        //Inserting String and Return Index in given Words
        I64 a=0,b,i=0;
        U8 *s=MAlloc(StrLen(f)*sizeof(U8));
        
        if(StrLen(f)!=0) {
                while(a<StrLen(str)){
	                if(a<StrLen(f)) {
		                s[i]=str[a];
		                i++;
	                }
	                if(StrCmp(s,f)==FALSE) {
	                        Free(s);
	                        return AbsI64(StrLen(f)-a); 
	                }
	                
	                for(b=0;b<StrLen(f);b++) s[b]=s[b+1];
	                s[i-1]=str[a];
                        
	                a++;
                }
        }
        
        Free(s);
        return -1;
}

U8 *StrIndex(U8 *str, I64 i){
        //Inserting String and Return Words in given Index 
	if(StrLen(str)<i || i <= -1) throw('OutIndex');
	
        U8 *s="";
        I64 _i=0;
        
	while(i<StrLen(str)){
	        if(str[i]==' ' || str[i]=='\0' || str[i] == '\n') break;
	        s[_i]=str[i];
	        
	        _i++;
	        i++;
	}
	
	return s;
}

U64 *StrIns(U8 *str,U8 *part,I64 i){
        //Inserting Char into another String
        U64 pl=StrLen(part);
        U8 *st=MStrPrint("%h*c%s",pl,32,str);

        if(StrLen(str)<i || i < -1) throw('OutIndex');

        MemCpy(st,str,i);
        MemCpy(st+i,part,pl);

        return st;
}

U8 *StrRep(U8 *str, U8 *old, U8 *new){
        //Replace Single Identical Char Only then Overwrite the Str
        
        //Looking for a old Char
        I64 i=StrIndexAt(str,old),a,b;
        U8 *t="";
        
        if(i!=-1) {
	        for(a=0;a<i;a++) t[a]=str[a];
	        for(b=0;b<StrLen(new);b++){
	                t[a]=new[b];
	                a++;
	        }
	        for(i=StrLen(old)+i;i<StrLen(str);i++){
	                t[a]=str[i];
	                a++;
	        }
	        str=t;
	        t=NULL;
        }
        return str;
}

U8 *StrRepAll(U8 *str, U8 *old, U8 *new){
        //Replace Multiple Identical Char then Overwrite the Str
	I64 l=StrDLen(str,old);
	I64 *t=StrIAToken(str,old);
	I64 a=0,b=0;
	U8 *ts="";
	
	while(a<l){
		while(b<t[a]){
		        ts=MStrPrint("%s%c",ts,str[b]);
			//ts[c]=str[b];
			//c++;
			b++;

		}
		/*while(d<StrLen(new)){
			ts[c]=new[d];
			c++;
		}*/
		ts=MStrPrint("%s%s",ts,new);

		b=AbsI64(StrLen(old)+b);
		
		a++;
	}
	
	while(b<StrLen(str)){
		ts=MStrPrint("%s%c",ts,str[b]);
		//ts[c]=str[b];
		b++;
	}

	StrCpy(str,ts);
	Free(ts);

	return str;
}

