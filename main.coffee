

Obj=require('./objx.coffee').Objx;
Ndo=require('./ndox.coffee').Ndox;


# Create as Forth/Postscript like engine
ndo=new Ndo();

log0 'enginge', ndo, ndo.logStacks()


# Create an engine task helper
ndoTask=(name)->
	x={}
	x.name=name
	x.data=[]

	x.dat=(data)->
		x.data.push( Obj.newLiteral(data || {}) )
		return x


	x.use=(plugin, options)->
		x.data.push( Obj.newLiteral(options || {}) )
		x.data.push( Obj.newNative(plugin) )		
		return x

	x.end=()->
		o=Obj.newArray(x.data)
		o.nam=x.name
		return o

	return x


#some plugins to do work 
aPlugin=(ndo)->
	log0 'aPlugin'
	opt=ndo.os.pop()
	dat=ndo.os.pop()

	log0 opt
	log0 dat

	ndo.os.push(Obj.newLiteral( {adata:'aPlugin transformed'} ))

	ndo.done()

bPlugin=(ndo)->
	log0 'bPlugin'
	opt=ndo.os.pop()
	dat=ndo.os.pop()

	log0 opt
	log0 dat

	ndo.os.push(Obj.newLiteral( {adata:'bPlugin transformed'} ))

	done=()->
		ndo.done()
	setTimeout done, 3000


cPlugin=(ndo)->
	log0 'cPlugin'
	opt=ndo.os.pop()
	# dat=ndo.os.pop()

	ndo.logStacks()

	ndo.fail()



atask=ndoTask('atask')
	.use( aPlugin, {aopt:'aopt'})
	.use( aPlugin, {aopt:'aopt'})
	.dat( {ataskdata:'ataskdata0'} )
	.use( bPlugin, {bopt:'bopt'})
	.use( cPlugin, {})
	.end()


btask=ndoTask('btask')
	.dat( {btaskdata:'btaskdata0'} )
	.dat( {btaskdata:'btaskdata1'} )
	.use( aPlugin, {aopt:'aopt'})
	.use( bPlugin, {bopt:'bopt'})
	.use( cPlugin, {})
	.end()



ndo.logStacks()

#push some data
ndo.os.push(Obj.newLiteral( {adata:'adata'} ))
ndo.os.push(Obj.newLiteral( {bdata:'bdata'} ))
ndo.os.push(Obj.newLiteral( {cdata:'cdata'} ))

#push some tasks
ndo.xs.push(atask.clone())
ndo.xs.push(btask.clone())

ndo.logStacks()

#execute them
ndo.next()

# ndo.logStacks()