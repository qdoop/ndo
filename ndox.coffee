


class Ndox
	constructor:()->
		@os=[] #operand stack
		@xs=[] #execute stack
		@nv=[] #dictionary stack
		@


	fail:(x)->
		log0 'fail'
		next=()=>
			@next()
		setTimeout next, 1
		return @

	done:(x)->
		log0 'done'
		next=()=>
			@next()
		setTimeout next, 1
		return @

	logStacks:()->
		log0 'o stack:'
		log0 @os
		log0 'x stack:'
		log0 @xs
		return @

	next:()->

		# @logStacks()

		while true
			break if @xs.length<1
			tos=@xs[@xs.length-1]

			if tos.isComposite()
				x=tos.val[tos.pos]
				@xs.pop() if (tos.pos+1)==tos.len
				tos.pos++

				return x.val( @ ) if x.isNative()
				@os.push( x ) if x.isLiteral()
				continue


			if tos.isLiteral()
				@os.push( @xs.pop() )
				continue



		@logStacks()
		log0 'No more work !!!'
		return @



module.exports={Ndox}