

class Objx
	constructor:()->
		@typ=0
		@rwx=0		
		@len=0
		@pos=0
		@nam=''
		@val=[]


	clone:()->
		o=new Objx()
		o.typ=@typ
		o.rwx=@rwx
		o.len=@len
		o.pos=@pos
		o.nam=@nam
		o.val=@val
		return o

	isLiteral:()->
		return 'Literal'==@typ

	isNative:()->
		return 'Native'==@typ

	isComposite:()->
		return 'Array'==@typ

	isProcedure:()->
		return 'Array'==@typ and 1==(@rwx%2)


Objx.EX=1

Objx.newLiteral=(x)->
	o=new Objx()
	o.typ='Literal'
	o.rwx=0
	o.len=0
	o.pos=0
	o.val=x
	return o

Objx.newArray=(x)->
	o=new Objx()
	o.typ='Array'
	o.rwx=0
	o.len=x.length
	o.pos=0
	o.val=x
	return o

Objx.newNative=(x)->
	o=new Objx()
	o.typ='Native'
	o.rwx=0
	o.len=0
	o.pos=0
	o.val=x
	return o

# Objx.newToken=(x)->
# 	o=new Objx()
# 	o.typ='Token'
# 	o.rwx=6
# 	o.len=x.length
# 	o.pos=0
# 	o.val=x
# 	return o


module.exports={Objx}